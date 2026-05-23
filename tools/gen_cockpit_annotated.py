#!/usr/bin/env python3
"""
gen_cockpit_annotated.py — versión anotada del cockpit con rectángulos UI.
Muestra los trapezoides de los monitores + los rectángulos funcionales de UI
para validar que el texto cabe dentro de cada pantalla.
"""

from PIL import Image, ImageDraw
import math

SRC = r"c:\Users\enriq\EL ULTIMO SELLO\game\assets\ui\cockpit\cockpit_three_screens_pc.png"
OUT = r"c:\Users\enriq\EL ULTIMO SELLO\tools\cockpit_paso2_rects.png"

img = Image.open(SRC).convert("RGB")
draw = ImageDraw.Draw(img)

# ── TRAPEZOIDES DE PANTALLA (del gen_cockpit.py) ─────────────────────────────
L_SCREEN = [(30, 68), (353, 104), (353, 530), (30, 555)]
C_SCREEN = [(406, 50), (874, 50), (874, 575), (406, 575)]
R_SCREEN = [(927, 104), (1250, 68), (1250, 555), (927, 530)]

# Borde de los trapezoides en blanco tenue
for scr in [L_SCREEN, C_SCREEN, R_SCREEN]:
    for i in range(4):
        draw.line([scr[i], scr[(i+1)%4]], fill=(60, 90, 60), width=1)

# ── RECTÁNGULOS UI PROPUESTOS (VISUAL_ASSET_PLAN sección 7) ─────────────────
# Ajustados para quedar dentro de los trapezoides con margen seguro
RECTS = {
    "P1 SOLICITANTE":  (24,  88,  24+330,  88+462),   # x, y, x2, y2
    "P2 EXPEDIENTE":   (410, 62,  410+460, 62+513),
    "P3 HERRAMIENTAS": (930, 88,  930+310, 88+442),
    "CONSOLA":         (300, 608, 300+680, 608+72),
}

COLORS = {
    "P1 SOLICITANTE":  (80, 220, 80),
    "P2 EXPEDIENTE":   (80, 180, 220),
    "P3 HERRAMIENTAS": (220, 180, 80),
    "CONSOLA":         (200, 80,  80),
}

for label, (x1, y1, x2, y2) in RECTS.items():
    color = COLORS[label]
    # Rectángulo
    draw.rectangle([x1, y1, x2, y2], outline=color, width=2)
    # Esquinas marcadas
    sz = 6
    for cx, cy in [(x1,y1),(x2,y1),(x2,y2),(x1,y2)]:
        draw.rectangle([cx-sz, cy-sz, cx+sz, cy+sz], fill=color)
    # Label
    draw.rectangle([x1, y1, x1+len(label)*7+8, y1+16], fill=color)
    draw.text((x1+4, y1+2), label, fill=(0, 0, 0))
    # Dimensiones
    w = x2 - x1
    h = y2 - y1
    dim_text = f"{w}x{h}px"
    draw.text((x1+4, y2-16), dim_text, fill=color)

# ── COORDENADAS EN ESQUINAS DE TRAPEZOIDES ───────────────────────────────────
for scr, color in [(L_SCREEN,(50,180,50)),(C_SCREEN,(50,200,200)),(R_SCREEN,(180,180,50))]:
    for px, py in scr:
        draw.ellipse([px-3, py-3, px+3, py+3], fill=color)
        draw.text((px+5, py-8), f"{px},{py}", fill=color)

img.save(OUT)
print(f"Guardado: {OUT}")
print()
print("Rectángulos UI:")
for label, (x1,y1,x2,y2) in RECTS.items():
    print(f"  {label}: x={x1} y={y1} w={x2-x1} h={y2-y1}")
