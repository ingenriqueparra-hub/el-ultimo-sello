class_name CockpitFrame
extends Control

# ── Colores ──────────────────────────────────────────────────────────────────
const C_BG           := Color(0.010, 0.014, 0.010)
const C_FRAME_OUTER  := Color(0.055, 0.075, 0.055)
const C_FRAME_MID    := Color(0.100, 0.140, 0.100)
const C_FRAME_LIGHT  := Color(0.150, 0.210, 0.150)
const C_SCREEN       := Color(0.018, 0.032, 0.018)
const C_GLOW_OUTER   := Color(0.04,  0.30,  0.04,  0.35)
const C_GLOW_MID     := Color(0.07,  0.50,  0.07,  0.65)
const C_GLOW_INNER   := Color(0.12,  0.75,  0.12,  1.00)
const C_CONSOLE      := Color(0.025, 0.038, 0.025)
const C_CONSOLE_SEP  := Color(0.14,  0.20,  0.14)

const CONSOLE_Y := 598.0

# ── Geometrías de cada vista ──────────────────────────────────────────────────
# Cada vista: 6 polígonos en orden [L_frame, L_screen, C_frame, C_screen, R_frame, R_screen]
# Cada polígono: 4 Vector2 [TL, TR, BR, BL]

const _RAW_VIEWS := [
	[  # Vista 0 — izquierda (L monitor frontal, grande)
		[[10,28],[738,52],[738,648],[10,692]],
		[[22,44],[726,65],[726,634],[22,676]],
		[[746,50],[1062,35],[1062,648],[746,668]],
		[[758,64],[1050,49],[1050,635],[758,654]],
		[[1070,82],[1270,60],[1270,638],[1070,660]],
		[[1078,94],[1262,72],[1262,626],[1078,648]],
	],
	[  # Vista 1 — centro (vista simétrica)
		[[15,52],[368,90],[368,545],[15,570]],
		[[30,68],[353,104],[353,530],[30,555]],
		[[392,34],[888,34],[888,590],[392,590]],
		[[406,50],[874,50],[874,575],[406,575]],
		[[912,90],[1265,52],[1265,570],[912,545]],
		[[927,104],[1250,68],[1250,555],[927,530]],
	],
	[  # Vista 2 — derecha (R monitor frontal, L apenas visible)
		[[210,82],[10,60],[10,638],[210,660]],        # L frame (franja izq)
		[[202,94],[18,72],[18,626],[202,648]],         # L screen
		[[534,50],[218,35],[218,648],[534,668]],       # C frame (angulado izq)
		[[522,64],[230,49],[230,635],[522,654]],       # C screen
		[[1270,28],[542,52],[542,648],[1270,692]],     # R frame (frontal, grande)
		[[1258,44],[554,65],[554,634],[1258,676]],     # R screen
	],
]

# Datos compilados
var _views: Array[Array] = []
var _from_view: Array = []
var _to_view:   Array = []
var _blend:     float = 1.0
var _current:   int   = 1

# ── Init ──────────────────────────────────────────────────────────────────────
func _ready() -> void:
	mouse_filter = MOUSE_FILTER_IGNORE
	z_index = -5
	set_anchors_preset(Control.PRESET_FULL_RECT)
	_compile_views()
	_from_view = _views[1]
	_to_view   = _views[1]

func _compile_views() -> void:
	for raw_view in _RAW_VIEWS:
		var view: Array = []
		for raw_poly in raw_view:
			var pv := PackedVector2Array()
			for pt in raw_poly:
				pv.append(Vector2(pt[0], pt[1]))
			view.append(pv)
		_views.append(view)

# ── API pública ───────────────────────────────────────────────────────────────
func set_focus(view_idx: int) -> void:
	if view_idx == _current:
		return
	_from_view = _lerp_views(_from_view, _to_view, _blend)
	_to_view   = _views[view_idx]
	_current   = view_idx
	var tween  := create_tween()
	tween.set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	tween.tween_method(
		func(v: float) -> void: _blend = v; queue_redraw(),
		0.0, 1.0, 0.38
	)

# ── Dibujo ────────────────────────────────────────────────────────────────────
func _draw() -> void:
	# Fondo total
	draw_rect(Rect2(0, 0, 1280, 720), C_BG)

	var polys := _lerp_views(_from_view, _to_view, _blend)

	# Los tres monitores: 0=L, 1=C, 2=R
	for i in 3:
		_draw_monitor(polys[i * 2], polys[i * 2 + 1])

	# Consola inferior
	draw_rect(Rect2(0, CONSOLE_Y, 1280, 720 - CONSOLE_Y), C_CONSOLE)
	draw_line(Vector2(0, CONSOLE_Y), Vector2(1280, CONSOLE_Y), C_CONSOLE_SEP, 2.0)
	_draw_console_texture()

func _draw_monitor(frame: PackedVector2Array, screen: PackedVector2Array) -> void:
	# 1. Sombra del marco
	var shadow := _offset_poly(frame, Vector2(4, 4))
	draw_colored_polygon(shadow, Color(0, 0, 0, 0.6))

	# 2. Marco exterior (metal oscuro)
	draw_colored_polygon(frame, C_FRAME_OUTER)

	# 3. Bisel interior (metal medio — da sensación de profundidad)
	var bevel := _shrink_poly(frame, 7.0)
	draw_colored_polygon(bevel, C_FRAME_MID)

	# 4. Borde interior del bisel (más claro)
	_draw_border(bevel, C_FRAME_LIGHT, 1.5)

	# 5. Área de pantalla
	draw_colored_polygon(screen, C_SCREEN)

	# 6. Borde luminoso de pantalla (glow en 3 capas)
	_draw_border(screen, C_GLOW_OUTER, 5.0)
	_draw_border(screen, C_GLOW_MID,   2.5)
	_draw_border(screen, C_GLOW_INNER, 1.0)

	# 7. Tornillos en esquinas del marco
	_draw_screws(frame)

func _draw_border(pts: PackedVector2Array, color: Color, width: float) -> void:
	for i in 4:
		draw_line(pts[i], pts[(i + 1) % 4], color, width, true)

func _draw_screws(frame: PackedVector2Array) -> void:
	var center := Vector2.ZERO
	for p in frame:
		center += p
	center /= 4.0
	for p in frame:
		var sp: Vector2 = p.lerp(center, 0.07)
		draw_circle(sp, 4.5, C_FRAME_OUTER)
		draw_arc(sp, 4.5, 0.0, TAU, 16, C_FRAME_LIGHT, 1.0)
		draw_line(sp + Vector2(-2.5, 0), sp + Vector2(2.5, 0), C_FRAME_LIGHT, 1.0)
		draw_line(sp + Vector2(0, -2.5), sp + Vector2(0, 2.5), C_FRAME_LIGHT, 1.0)

func _draw_console_texture() -> void:
	# Textura de teclado/panel en la consola
	for kx in range(12, 1268, 10):
		for ky in range(int(CONSOLE_Y) + 18, 712, 10):
			draw_rect(Rect2(kx, ky, 7, 7), C_FRAME_OUTER)
			draw_line(Vector2(kx, ky), Vector2(kx + 7, ky), C_FRAME_MID, 1.0)
			draw_line(Vector2(kx, ky), Vector2(kx, ky + 7), C_FRAME_MID, 1.0)

# ── Helpers geométricos ───────────────────────────────────────────────────────
func _lerp_views(a: Array, b: Array, t: float) -> Array:
	var result: Array = []
	for i in a.size():
		var pv := PackedVector2Array()
		for j in 4:
			pv.append((a[i][j] as Vector2).lerp(b[i][j], t))
		result.append(pv)
	return result

func _shrink_poly(pts: PackedVector2Array, amount: float) -> PackedVector2Array:
	var center := Vector2.ZERO
	for p in pts:
		center += p
	center /= float(pts.size())
	var result := PackedVector2Array()
	for p in pts:
		var dir: Vector2 = p - center
		result.append(p - dir.normalized() * amount)
	return result

func _offset_poly(pts: PackedVector2Array, offset: Vector2) -> PackedVector2Array:
	var result := PackedVector2Array()
	for p in pts:
		result.append(p + offset)
	return result
