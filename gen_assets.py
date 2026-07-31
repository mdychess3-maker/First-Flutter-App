from PIL import Image, ImageDraw
import math

GOLD = (212, 175, 55, 255)
GOLD_LIGHT = (238, 214, 138, 255)
OBSIDIAN = (8, 8, 8, 255)
OBSIDIAN2 = (21, 21, 21, 255)

def radial_bg(size, c_in, c_out):
    img = Image.new("RGBA", (size, size), c_out)
    cx, cy = size / 2, size / 2
    max_r = math.hypot(cx, cy)
    px = img.load()
    for y in range(size):
        for x in range(size):
            d = math.hypot(x - cx, y - cy) / max_r
            d = min(d, 1)
            r = int(c_in[0] + (c_out[0] - c_in[0]) * d)
            g = int(c_in[1] + (c_out[1] - c_in[1]) * d)
            b = int(c_in[2] + (c_out[2] - c_in[2]) * d)
            px[x, y] = (r, g, b, 255)
    return img

def draw_crown(draw, cx, cy, w, h, fill, outline=None, outline_w=0):
    # 5-point queen crown silhouette
    base_w = w * 0.82
    base_h = h * 0.16
    top_y = cy - h * 0.5
    base_y = cy + h * 0.34

    # base band (trapezoid)
    band_top_w = base_w * 0.72
    draw.polygon([
        (cx - base_w/2, base_y + base_h),
        (cx + base_w/2, base_y + base_h),
        (cx + band_top_w/2, base_y),
        (cx - band_top_w/2, base_y),
    ], fill=fill, outline=outline)

    # spikes (5 triangles) rising from band_top to points, with valleys between
    n_spikes = 5
    left = cx - band_top_w/2
    right = cx + band_top_w/2
    spike_w = (right - left) / n_spikes
    valley_y = base_y - h * 0.06
    peak_heights = [0.62, 0.82, 1.0, 0.82, 0.62]
    points_top = []
    for i in range(n_spikes):
        sx = left + spike_w * (i + 0.5)
        sy = top_y + (1 - peak_heights[i]) * (base_y - top_y) * 0.55
        points_top.append((sx, sy))

    # build a zigzag polygon: base_y line with peaks
    poly = [(left, base_y)]
    for i in range(n_spikes):
        peak = points_top[i]
        poly.append(peak)
        valley_x = left + spike_w * (i + 1)
        poly.append((valley_x, valley_y if i < n_spikes - 1 else base_y))
    poly.append((right, base_y))
    draw.polygon(poly, fill=fill, outline=outline)

    # orbs on top of each spike
    orb_r = w * 0.045
    for (sx, sy) in points_top:
        draw.ellipse([sx - orb_r, sy - orb_r*1.6, sx + orb_r, sy + orb_r*0.6], fill=fill, outline=outline)

    # jewel dots on band
    jewel_r = w * 0.02
    for i in range(3):
        jx = cx - base_w*0.22 + i * (base_w*0.22)
        jy = base_y + base_h*0.55
        draw.ellipse([jx-jewel_r, jy-jewel_r, jx+jewel_r, jy+jewel_r], fill=(8,8,8,255))

def make_icon(path, size=1024, transparent=False):
    if transparent:
        img = Image.new("RGBA", (size, size), (0,0,0,0))
    else:
        img = radial_bg(size, OBSIDIAN2, OBSIDIAN)
    draw = ImageDraw.Draw(img)
    if not transparent:
        # subtle gold ring
        m = size*0.045
        draw.ellipse([m, m, size-m, size-m], outline=(212,175,55,90), width=max(2,int(size*0.006)))
    draw_crown(draw, size/2, size*0.52, size*0.62, size*0.5, fill=GOLD)
    img.save(path)

make_icon("assets/images/app_icon.png", 1024, transparent=False)
make_icon("assets/images/app_icon_fg.png", 1024, transparent=True)
make_icon("assets/images/splash_icon.png", 800, transparent=True)
print("icons generated")
