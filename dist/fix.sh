#!/usr/bin/env bash
set -euo pipefail
err(){ echo "[ERR]" "$@" >&2; exit 1; }
info(){ echo "[INFO]" "$@"; }

APP_NAME="飞书 Ask"
DEFAULT_APP="/Applications/${APP_NAME}.app"
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

TARGET="${1:-}"
if [ -z "$TARGET" ]; then
  if [ -d "$DEFAULT_APP" ]; then
    TARGET="$DEFAULT_APP"
    info "未提供参数，默认修复: $TARGET"
  else
    CANDIDATE="$(find "$SCRIPT_DIR" -maxdepth 1 -name "${APP_NAME}*.dmg" -print -quit 2>/dev/null || true)"
    if [ -n "$CANDIDATE" ]; then
      TARGET="$CANDIDATE"
      info "未提供参数，检测到 DMG: $TARGET"
    else
      err "未提供参数，且未找到 $DEFAULT_APP 或 ${APP_NAME}*.dmg。请先将应用拖入 /Applications 或将 DMG 与脚本放在同一目录。"
    fi
  fi
fi

APP_PATH=""; MOUNT_POINT=""
if [[ "$TARGET" == *.dmg ]]; then
  [ -f "$TARGET" ] || err "DMG 不存在: $TARGET"
  info "挂载 DMG..."
  MOUNT_POINT="$(hdiutil attach -nobrowse -quiet "$TARGET" | awk '/\/Volumes\//{print $3; exit}')"
  [ -n "$MOUNT_POINT" ] || err "无法挂载 DMG"
  APP_IN_DMG="$(find "$MOUNT_POINT" -maxdepth 2 -name "${APP_NAME}.app" -print -quit)"
  [ -n "$APP_IN_DMG" ] || err "DMG 内未找到 ${APP_NAME}.app"
  info "复制到 /Applications..."
  ditto "$APP_IN_DMG" "$DEFAULT_APP"
  APP_PATH="$DEFAULT_APP"
else
  APP_PATH="$TARGET"; [ -d "$APP_PATH" ] || err "App 路径无效: $APP_PATH"
fi

info "移除隔离属性..."; xattr -dr com.apple.quarantine "$APP_PATH" || true
info "Ad-hoc 签名..."; codesign --force --deep --sign - --timestamp=none "$APP_PATH"
info "Gatekeeper 评估(可忽略失败)..."; spctl --assess -vv "$APP_PATH" || true
[ -n "$MOUNT_POINT" ] && { info "卸载 DMG..."; hdiutil detach "$MOUNT_POINT" -quiet || true; }
info "完成。现在可直接打开: $APP_PATH"
