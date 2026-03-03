#!/usr/bin/env python3
"""将 SVG 转为透明背景 PNG，输出 1024x1024"""
import cairosvg
import os

icons_dir = os.path.join(os.path.dirname(__file__), "..", "src-tauri", "icons")
svg_path = os.path.join(icons_dir, "icon-myai-transparent.svg")
png_path = os.path.join(icons_dir, "icon.png")

cairosvg.svg2png(
    url=svg_path,
    write_to=png_path,
    output_width=1024,
    output_height=1024,
    background_color=None,  # 透明背景
)
print("OK:", png_path)
