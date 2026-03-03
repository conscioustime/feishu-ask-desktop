# 飞书 Ask 桌面应用

使用 **Tauri** 将 [ask.feishu.cn](https://ask.feishu.cn) 打包为 macOS 桌面应用，体积约十几 MB，并附带 **fix 脚本**，方便分发给他人使用。

## 环境要求

- [Node.js](https://nodejs.org/)（建议 18+）
- [Rust](https://rustup.rs/)（构建 Tauri 需要，一次性安装）

安装 Rust：

```bash
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
```

安装后执行 `cargo -V` 能显示版本即可。

## 构建

```bash
npm install
npm run build
```

构建完成后，产物位于：

- **.app**：`src-tauri/target/release/bundle/macos/飞书 Ask.app`
- **.dmg**：`src-tauri/target/release/bundle/dmg/飞书 Ask_0.1.0_aarch64.dmg`（Apple Silicon）

如需将 fix 脚本一并放入 dmg，可参考本仓库 `dist/` 下的说明，在打包后手动将 `dist/fix.command`、`dist/fix.sh`、`dist/README.txt` 加入 dmg 或随 dmg 一起提供。

## 分发给他人

建议一并提供：

1. **DMG 安装包**：`飞书 Ask_0.1.0_aarch64.dmg`（或对应架构的 .dmg）
2. **fix 脚本**：本仓库 `dist/fix.command` 或 `dist/fix.sh`

对方使用步骤：

1. 双击 .dmg，将「飞书 Ask.app」拖入「应用程序」
2. 双击 **fix.command**（或在终端执行 `./fix.sh`）
3. 之后在启动台或应用程序中正常打开「飞书 Ask」即可

**为什么需要 fix？**  
未做 Apple 开发者签名时，从网络下载的 app 可能被 macOS 隔离，提示“已损坏”或无法打开。fix 脚本会移除隔离并做本机 ad-hoc 签名，对方只需运行一次。

## 技术说明

- 使用 Tauri 2，在 `tauri.conf.json` 中配置主窗口加载 `https://ask.feishu.cn`
- 前端仅保留占位页面，实际内容为上述网页
- 应用需联网使用，并在应用内登录飞书账号

## 许可证

MIT
