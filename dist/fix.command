#!/usr/bin/env bash
set -euo pipefail
err(){ echo "[ERR]" "$@" >&2; exit 1; }
info(){ echo "[INFO]" "$@"; }
VOLUME_DIR="$(cd "$(dirname "$0")" && pwd)"
APP_NAME="飞书 Ask"
DEFAULT_APP="/Applications/${APP_NAME}.app"
APP_IN_VOL="$VOLUME_DIR/${APP_NAME}.app"
TARGET="${1:-}"

install_if_needed(){
  if [ -d "$DEFAULT_APP" ]; then
    info "已存在: $DEFAULT_APP"
  else
    [ -d "$APP_IN_VOL" ] || err "未在当前卷找到 ${APP_NAME}.app: $APP_IN_VOL"
    info "复制 ${APP_NAME}.app 到 /Applications..."
    ditto "$APP_IN_VOL" "$DEFAULT_APP"
  fi
}

repair_app(){
  local APP_PATH="$1"
  info "移除隔离属性..."; xattr -dr com.apple.quarantine "$APP_PATH" || true
  info "Ad-hoc 签名..."; codesign --force --deep --sign - --timestamp=none "$APP_PATH"
  info "Gatekeeper 评估(可忽略失败)..."; spctl --assess -vv "$APP_PATH" || true
}

if [ -z "$TARGET" ]; then
  install_if_needed
  repair_app "$DEFAULT_APP"
else
  if [[ "$TARGET" == *.dmg ]]; then
    err "此 DMG 内已包含 ${APP_NAME}.app，直接关闭此窗口，双击 fix.command 即可。"
  elif [ -d "$TARGET" ]; then
    repair_app "$TARGET"
  else
    err "参数无效: $TARGET"
  fi
fi

info "完成。现在可直接打开: $DEFAULT_APP"
open -R "$DEFAULT_APP" || true
