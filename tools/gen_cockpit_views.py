#!/usr/bin/env python3
"""
gen_cockpit_views.py — genera tres perspectivas de cabina para el giro de cuello.

cockpit_face_left.png   : monitor izquierdo de frente (visto recto, ancho)
cockpit_face_center.png : vista central (los tres en perspectiva simétrica)
cockpit_face_right.png  : monitor derecho de frente (espejo de face_left)

El truco es que la geometría de los trapecios cambia según el punto de vista:
  - Monitor frontal → casi rectangular, grande, ocupa ~57% del ancho
  - Monitor a 45°   → trapezoide más comprimido
  - Monitor casi de canto → franja estrecha en el borde
"""

from PIL import Image, ImageDraw, ImageFilter
import os, math

W, H      = 1280, 720
OUT_DIR   = r"c:\Users\enriq\EL ULTIMO SELLO\game\assets\ui\cockpit"

# ── PALETA ───────────────────────────────────────────────────────────────────
BG          = (4,  8,  4)
METAL_DARK  = (10, 14, 10)
METAL_MID   = (22, 30, 22)
METAL_LIGHT = (38, 52, 38)
SCREEN_OFF  = (7,  14,  7)
GREEN_DIM   = (10, 65, 10)
CONSOLE_Y   = 598

# ── GEOMETRÍAS POR VISTA ─────────────────────────────────────────────────────
# Cada monitor: (top-left, top-right, bottom-right, bottom-left) en px.

# VISTA CENTRAL — monitor central recto, laterales en trapezoide simétrico
L_FRAME_C  = [(15, 52),  (368, 90),  (368, 545), (15, 570)]
L_SCREEN_C = [(30, 68),  (353, 104), (353, 530), (30, 555)]
C_FRAME_C  = [(392, 34), (888, 34),  (888, 590), (392, 590)]
C_SCREEN_C = [(406, 50), (874, 50),  (874, 575), (406, 575)]
R_FRAME_C  = [(912, 90), (1265, 52), (1265, 570),(912, 545)]
R_SCREEN_C = [(927, 104),(1250, 68), (1250, 555),(927, 530)]

MONITORS_CENTER = [
    (L_FRAME_C, L_SCREEN_C, 0.60),
    (C_FRAME_C, C_SCREEN_C, 1.00),
    (R_FRAME_C, R_SCREEN_C, 0.60),
]

# VISTA IZQUIERDA — monitor izq. de frente (casi rectángulo, ~57% de ancho)
# El jugador giró el cuello: el izq. aparece recto, el central está angulado
# a la derecha, el derecho es una franja casi de canto.
L_FRAME_L  = [(10, 28),  (738, 52),  (738, 648), (10, 692)]
L_SCREEN_L = [(22, 44),  (726, 65),  (726, 634), (22, 676)]

C_FRAME_L  = [(746, 50), (1062, 35), (1062, 648),(746, 668)]
C_SCREEN_L = [(758, 64), (1050, 49), (1050, 635),(758, 654)]

R_FRAME_L  = [(1070, 82),(1270, 60), (1270, 638),(1070, 660)]
R_SCREEN_L = [(1078, 94),(1262, 72), (1262, 626),(1078, 648)]

MONITORS_LEFT = [
    (L_FRAME_L, L_SCREEN_L, 1.00),  # frontal: máximo brillo
    (C_FRAME_L, C_SCREEN_L, 0.65),  # angulado a la derecha
    (R_FRAME_L, R_SCREEN_L, 0.28),  # casi de canto, muy tenue
]

# VISTA DERECHA — espejo perfecto de la vista izquierda
def mx(pts):
    return [(W - x, y) for x, y in pts]

MONITORS_RIGHT = [
    (mx(R_FRAME_L), mx(R_SCREEN_L), 0.28),   # izq casi de canto
    (mx(C_FRAME_L), mx(C_SCREEN_L), 0.65),   # central angulado a la izq
    (mx(L_FRAME_L), mx(L_SCREEN_L), 1.00),   # der frontal: máximo brillo
]

# ── HELPERS ───────────────────────────────────────────────────────────────────
def lerp_pts(pts_a, pts_b, t):
    return [(int(a[0]+(b[0]-a[0])*t), int(a[1]+(b[1]-a[1])*t))
            for a, b in zip(pts_a, pts_b)]

def centroid(pts):
    return (sum(p[0] for p in pts)//len(pts),
            sum(p[1] for p in pts)//len(pts))

def shrink_poly(pts, px):
    cx, cy = centroid(pts)
    result = []
    for x, y in pts:
        dx, dy = x - cx, y - cy
        length = math.hypot(dx, dy) or 1
        result.append((int(x - dx/length*px), int(y - dy/length*px)))
    return result

def draw_screws(draw, frame_pts):
    for px, py in frame_pts:
        cx, cy = centroid(frame_pts)
        ox = int(px + (cx-px)*0.07)
        oy = int(py + (cy-py)*0.07)
        draw.ellipse([ox-4, oy-4, ox+4, oy+4], fill=METAL_MID, outline=METAL_LIGHT)
        draw.line([ox-2, oy, ox+2, oy], fill=METAL_LIGHT, width=1)
        draw.line([ox, oy-2, ox, oy+2], fill=METAL_LIGHT, width=1)

# ── GENERADOR PRINCIPAL ───────────────────────────────────────────────────────
def generate(monitors, filename):
    img = Image.new("RGB", (W, H), BG)
    draw = ImageDraw.Draw(img)

    # Gradiente de fondo
    for y in range(H):
        g = int(BG[1] + (y / H) * 10)
        draw.line([(0, y), (W-1, y)], fill=(BG[0], g, BG[0]))

    # Paredes laterales de cabina
    for x in range(90):
        alpha = int(60 * (1 - x/90)**2)
        draw.line([(x, 0), (x, H)], fill=(0, alpha//6, 0))
        draw.line([(W-1-x, 0), (W-1-x, H)], fill=(0, alpha//6, 0))

    # Glow difuso por pantalla
    glow = Image.new("RGB", (W, H), (0, 0, 0))
    gdraw = ImageDraw.Draw(glow)
    for frame, screen, intensity in monitors:
        ctr = [centroid(screen)] * 4
        for step in range(10):
            t = step / 10
            pts = lerp_pts(screen, ctr, t)
            v = int(45 * (1-t) * intensity)
            gdraw.polygon(pts, fill=(v//5, v, v//5))
    glow = glow.filter(ImageFilter.GaussianBlur(radius=20))

    # Combinar glow (add blend)
    img_px = list(img.getdata())
    glw_px = list(glow.getdata())
    img.putdata([
        (min(255, a+b), min(255, c+d), min(255, e+f))
        for (a,c,e),(b,d,f) in zip(img_px, glw_px)
    ])
    draw = ImageDraw.Draw(img)

    # Marcos y pantallas de monitores (de fondo a frente por intensidad)
    for frame, screen, intensity in sorted(monitors, key=lambda m: m[2]):
        draw.polygon([(x+5, y+5) for x,y in frame], fill=(2, 3, 2))  # sombra
        draw.polygon(frame, fill=METAL_DARK)
        draw.polygon(shrink_poly(frame, 6), fill=METAL_MID)
        draw.polygon(shrink_poly(frame, 10), fill=METAL_DARK)
        draw.polygon(screen, fill=SCREEN_OFF)
        for i in range(4):
            draw.line([screen[i], screen[(i+1)%4]], fill=GREEN_DIM, width=1)
        draw_screws(draw, frame)

    # Header oscuro (zona de título) en cada pantalla
    for frame, screen, intensity in monitors:
        top2 = screen[:2]
        bot2 = [screen[3], screen[2]]
        h_bot = lerp_pts(top2, bot2[::-1], 0.13)
        draw.polygon([screen[0], screen[1], h_bot[1], h_bot[0]], fill=(10, 24, 10))
        draw.line([h_bot[0], h_bot[1]], fill=GREEN_DIM, width=1)

    # Scanlines
    sl = Image.new("RGBA", (W, H), (0, 0, 0, 0))
    sl_d = ImageDraw.Draw(sl)
    for y in range(0, H, 3):
        sl_d.line([(0, y), (W-1, y)], fill=(0, 0, 0, 30))
    img = img.convert("RGBA")
    img = Image.alpha_composite(img, sl)
    img = img.convert("RGB")
    draw = ImageDraw.Draw(img)

    # Consola inferior
    draw.rectangle([0, CONSOLE_Y, W, H], fill=(8, 12, 8))
    draw.rectangle([0, CONSOLE_Y, W, CONSOLE_Y+2], fill=METAL_LIGHT)
    for kx in range(10, W-10, 10):
        for ky in range(CONSOLE_Y+18, H-8, 10):
            draw.rectangle([kx+1, ky+1, kx+8, ky+8], fill=(13, 20, 13))
            draw.rectangle([kx+1, ky+1, kx+8, ky+1], fill=METAL_LIGHT)
            draw.rectangle([kx+1, ky+1, kx+1, ky+8], fill=METAL_LIGHT)

    # Botones de decisión
    BTN_W, BTN_H = 200, 52
    BTN_Y1 = CONSOLE_Y + 10
    BTN_Y2 = BTN_Y1 + BTN_H
    bx0 = (W - (3 * BTN_W + 2 * 30)) // 2
    for i, (fill, edge) in enumerate([
        ((8, 42, 8), (18, 110, 18)),
        ((36, 30, 4), (90, 75, 10)),
        ((42, 6, 6), (110, 16, 16)),
    ]):
        bx = bx0 + i * (BTN_W + 30)
        draw.rectangle([bx+3, BTN_Y1+3, bx+BTN_W+3, BTN_Y2+3], fill=(2,3,2))
        draw.rectangle([bx, BTN_Y1, bx+BTN_W, BTN_Y2], fill=fill)
        draw.rectangle([bx, BTN_Y1, bx+BTN_W, BTN_Y1+1], fill=edge)
        draw.rectangle([bx, BTN_Y1, bx+1, BTN_Y2], fill=edge)
        draw.rectangle([bx, BTN_Y2-1, bx+BTN_W, BTN_Y2],
                       fill=(fill[0]//3, fill[1]//3, fill[2]//3))

    # Ribetes entre monitores (solo para vista central)
    if filename == "cockpit_face_center.png":
        for i, x0 in enumerate([388, 890]):
            for j in range(3):
                v = [28, 18, 10][j] if x0 == 388 else [10, 18, 28][j]
                draw.line([(x0+j, 30), (x0+j, CONSOLE_Y)], fill=(v//2, v, v//2))

    # Vignette
    vig = Image.new("RGBA", (W, H), (0, 0, 0, 0))
    vd  = ImageDraw.Draw(vig)
    for i in range(55):
        alpha = int(160 * (1 - i/55)**1.8)
        m = i * 5
        vd.rectangle([m, m, W-m, H-m], outline=(0, 0, 0, alpha))
    img = img.convert("RGBA")
    img = Image.alpha_composite(img, vig)
    img = img.convert("RGB")

    out = os.path.join(OUT_DIR, filename)
    img.save(out, "PNG")
    print(f"OK: {out}")

# ── EJECUTAR ─────────────────────────────────────────────────────────────────
if __name__ == "__main__":
    os.makedirs(OUT_DIR, exist_ok=True)
    generate(MONITORS_LEFT,   "cockpit_face_left.png")
    generate(MONITORS_CENTER, "cockpit_face_center.png")
    generate(MONITORS_CENTER, "cockpit_three_screens_pc.png")  # sobreescribe el ya importado
    generate(MONITORS_RIGHT,  "cockpit_face_right.png")
    print("\nListo. Tres vistas generadas.")
