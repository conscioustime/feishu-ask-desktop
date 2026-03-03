#!/usr/bin/env python3
"""把白底 icon.png 转为透明底，并缩小图形到约 72% 居中"""
import os
from PIL import Image

icons_dir = os.path.join(os.path.dirname(__file__), "..", "src-tauri", "icons")
src = os.path.join(icons_dir, "icon.png")
out = os.path.join(icons_dir, "icon.png")
size = 1024
scale = 0.72  # 图形缩小到 72%

img = Image.open(src).convert("RGBA")
dat = img.getdata()
# 白色/接近白色 -> 透明
new_dat = []
for item in dat:
    r, g, b, a = item
    if r >= 248 and g >= 248 and b >= 248:
        new_dat.append((255, 255, 255, 0))
    else:
        new_dat.append(item)
img.putdata(new_dat)

# 缩小图形并居中到新画布
w, h = img.size
box = img.getbbox()  # 非透明区域
if not box:
    box = (0, 0, w, h)
cx = (box[0] + box[2]) // 2
cy = (box[1] + box[3]) // 2
new_w = int(w * scale)
new_h = int(h * scale)
img_small = img.resize((new_w, new_h), Image.Resampling.LANCZOS)
# 透明画布
canvas = Image.new("RGBA", (size, size), (255, 255, 255, 0))
paste_x = (size - new_w) // 2
paste_y = (size - new_h) // 2
canvas.paste(img_small, (paste_x, paste_y), img_small)
canvas.save(out)
print("OK:", out)
