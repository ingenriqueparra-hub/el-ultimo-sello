#!/usr/bin/env python3
"""
gen_cockpit.py — genera cockpit_three_screens_pc.png (1280x720)
Mockup estructural para El Ultimo Sello.
Tres monitores en perspectiva de cabina: el jugador "mueve el cuello" para
enfocar cada pantalla. Centro recto, laterales angulados hacia adentro.
"""

from PIL import Image, ImageDraw, ImageFilter
import os, math

W, H = 1280, 720

# ── PALETA ──────────────────────────────────────────────────────────────────
BG          = (4,  8,  4)
METAL_DARK  = (10, 14, 10)
METAL_MID   = (22, 30, 22)
METAL_LIGHT = (38, 52, 38)
SCREEN_OFF  = (7,  14,  7)
GREEN_DIM   = (10, 65, 10)
GREEN_MID   = (16, 110, 16)
GREEN_EDGE  = (22, 160, 22)
AMBER       = (80, 65,  8)
RED_DARK    = (50,  8,  8)

# ── GEOMETRIA ───────────────────────────────────────────────────────────────
# Los tres monitores como poligonos (perspectiva de cabina).
# El monitor central es rectangular y frontal.
# Los laterales son trapezoides que simulan el angulo de "cuello".

# Monitor IZQUIERDO — lado exterior (izq) mas alto, interior (der) converge
L_FRAME = [(15, 52), (368, 90), (368, 545), (15, 570)]
L_SCREEN = [(30, 68), (353, 104), (353, 530), (30, 555)]

# Monitor CENTRAL — recto, mas grande, mas alto
C_FRAME  = [(392, 34), (888, 34), (888, 590), (392, 590)]
C_SCREEN = [(406, 50), (874, 50), (874, 575), (406, 575)]

# Monitor DERECHO — espejo del izquierdo
R_FRAME  = [(912, 90), (1265, 52), (1265, 570), (912, 545)]
R_SCREEN = [(927, 104), (1250, 68), (1250, 555), (927, 530)]

CONSOLE_Y = 598   # donde empieza la consola inferior

# ── HELPERS ─────────────────────────────────────────────────────────────────
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
        t = 0.07
        ox = int(px + (cx-px)*t)
        oy = int(py + (cy-py)*t)
        draw.ellipse([ox-4, oy-4, ox+4, oy+4], fill=METAL_MID, outline=METAL_LIGHT)
        draw.line([ox-2, oy, ox+2, oy], fill=METAL_LIGHT, width=1)
        draw.line([ox, oy-2, ox, oy+2], fill=METAL_LIGHT, width=1)

# ── IMAGEN BASE ──────────────────────────────────────────────────────────────
img = Image.new("RGB", (W, H), BG)
draw = ImageDraw.Draw(img)

# Fondo con gradiente vertical muy sutil
for y in range(H):
    t = y / H
    g = int(BG[1] + t * 10)
    draw.line([(0, y), (W-1, y)], fill=(BG[0], g, BG[0]))

# Paredes laterales de la cabina (sensacion de estar dentro)
for x in range(90):
    alpha = int(60 * (1 - x/90)**2)
    draw.line([(x, 0), (x, H)], fill=(0, alpha//6, 0))
    draw.line([(W-1-x, 0), (W-1-x, H)], fill=(0, alpha//6, 0))

# ── GLOW DIFUSO DE PANTALLAS (capa separada, blur) ──────────────────────────
glow = Image.new("RGB", (W, H), (0, 0, 0))
gdraw = ImageDraw.Draw(glow)

for scr, intensity in [(L_SCREEN, 0.6), (C_SCREEN, 1.0), (R_SCREEN, 0.6)]:
    for step in range(10):
        t = step / 10
        pts = lerp_pts(scr, [centroid(scr)]*4, t)
        v = int(45 * (1-t) * intensity)
        gdraw.polygon(pts, fill=(v//5, v, v//5))

glow = glow.filter(ImageFilter.GaussianBlur(radius=18))

# Componer glow (add blend)
img_px = list(img.getdata())
glw_px = list(glow.getdata())
img.putdata([
    (min(255, a+b), min(255, c+d), min(255, e+f))
    for (a,c,e),(b,d,f) in zip(img_px, glw_px)
])
draw = ImageDraw.Draw(img)

# ── MARCOS DE MONITORES ──────────────────────────────────────────────────────
for frame, screen in [(L_FRAME, L_SCREEN), (C_FRAME, C_SCREEN), (R_FRAME, R_SCREEN)]:
    # Sombra
    shadow = [(x+5, y+5) for x,y in frame]
    draw.polygon(shadow, fill=(2, 3, 2))
    # Marco exterior
    draw.polygon(frame, fill=METAL_DARK)
    # Bisel (borde interior del marco)
    bevel = shrink_poly(frame, 6)
    draw.polygon(bevel, fill=METAL_MID)
    bevel2 = shrink_poly(frame, 10)
    draw.polygon(bevel2, fill=METAL_DARK)
    # Pantalla
    draw.polygon(screen, fill=SCREEN_OFF)
    # Borde luminoso de pantalla
    for i in range(4):
        p1, p2 = screen[i], screen[(i+1)%4]
        draw.line([p1, p2], fill=GREEN_DIM, width=1)
    # Tornillos
    draw_screws(draw, frame)

# ── HEADER OSCURO EN CADA PANTALLA (zona de titulo) ─────────────────────────
for scr in [L_SCREEN, C_SCREEN, R_SCREEN]:
    # Top 14% de la pantalla = header oscuro con borde
    header = lerp_pts(scr[:2] + scr[1:3], scr, 0.0)  # fix
    t = 0.13
    top2   = scr[:2]
    bot2   = [scr[3], scr[2]]
    h_bot  = lerp_pts(top2, bot2[::-1] if len(bot2) == 2 else bot2, t)
    header_poly = [scr[0], scr[1], h_bot[1], h_bot[0]]
    draw.polygon(header_poly, fill=(10, 24, 10))
    draw.line([h_bot[0], h_bot[1]], fill=GREEN_DIM, width=1)

# ── SCANLINES ────────────────────────────────────────────────────────────────
sl = Image.new("RGBA", (W, H), (0, 0, 0, 0))
sl_draw = ImageDraw.Draw(sl)
for y in range(0, H, 3):
    sl_draw.line([(0, y), (W-1, y)], fill=(0, 0, 0, 30))
img = img.convert("RGBA")
img = Image.alpha_composite(img, sl)
img = img.convert("RGB")
draw = ImageDraw.Draw(img)

# ── CONSOLA INFERIOR ─────────────────────────────────────────────────────────
# Fondo de consola
draw.rectangle([0, CONSOLE_Y, W, H], fill=(8, 12, 8))
draw.rectangle([0, CONSOLE_Y, W, CONSOLE_Y+2], fill=METAL_LIGHT)

# Teclado / textura de panel
for kx in range(10, W-10, 10):
    for ky in range(CONSOLE_Y+18, H-8, 10):
        draw.rectangle([kx+1, ky+1, kx+8, ky+8], fill=(13, 20, 13))
        draw.rectangle([kx+1, ky+1, kx+8, ky+1], fill=METAL_LIGHT)
        draw.rectangle([kx+1, ky+1, kx+1, ky+8], fill=METAL_LIGHT)

# Tres botones de decision
BTN_W, BTN_H = 200, 52
BTN_Y1 = CONSOLE_Y + 10
BTN_Y2 = BTN_Y1 + BTN_H
total_w = 3 * BTN_W + 2 * 30
bx0 = (W - total_w) // 2

btn_data = [
    (bx0,              (8, 42, 8),  (18, 110, 18), "APROBAR"),
    (bx0 + BTN_W + 30, (36, 30, 4), (90, 75, 10),  "RETENER"),
    (bx0 + 2*(BTN_W+30),(42, 6, 6), (110, 16, 16), "RECHAZAR"),
]

for bx, fill, edge, label in btn_data:
    # Sombra
    draw.rectangle([bx+3, BTN_Y1+3, bx+BTN_W+3, BTN_Y2+3], fill=(2,3,2))
    # Cuerpo
    draw.rectangle([bx, BTN_Y1, bx+BTN_W, BTN_Y2], fill=fill)
    # Borde superior (highlight)
    draw.rectangle([bx, BTN_Y1, bx+BTN_W, BTN_Y1+1], fill=edge)
    draw.rectangle([bx, BTN_Y1, bx+1, BTN_Y2],       fill=edge)
    # Borde inferior (sombra)
    draw.rectangle([bx, BTN_Y2-1, bx+BTN_W, BTN_Y2], fill=(fill[0]//3, fill[1]//3, fill[2]//3))

# ── RIBETE METALICO ENTRE MONITORES ─────────────────────────────────────────
# Columna izquierda entre monitor L y C
for i in range(3):
    v = [28, 18, 10][i]
    draw.line([(388+i, 30), (388+i, CONSOLE_Y)], fill=(v//2, v, v//2))
# Columna derecha entre monitor C y R
for i in range(3):
    v = [10, 18, 28][i]
    draw.line([(890+i, 30), (890+i, CONSOLE_Y)], fill=(v//2, v, v//2))

# ── VIGNETTE ─────────────────────────────────────────────────────────────────
vig = Image.new("RGBA", (W, H), (0,0,0,0))
vd  = ImageDraw.Draw(vig)
for i in range(55):
    alpha = int(160 * (1 - i/55)**1.8)
    m = i * 5
    vd.rectangle([m, m, W-m, H-m], outline=(0, 0, 0, alpha))

img = img.convert("RGBA")
img = Image.alpha_composite(img, vig)
img = img.convert("RGB")

# ── GUARDAR ──────────────────────────────────────────────────────────────────
out = r"c:\Users\enriq\EL ULTIMO SELLO\game\assets\ui\cockpit\cockpit_three_screens_pc.png"
os.makedirs(os.path.dirname(out), exist_ok=True)
img.save(out, "PNG")
print(f"OK: {out}  ({W}x{H})")
