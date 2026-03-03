# 飞书 Ask 桌面应用

将 [飞书 Ask](https://ask.feishu.cn) 打包为 macOS 桌面应用，独立窗口、体积小，无需单独打开浏览器。

---

## 系统要求

- **macOS** 10.13 及以上
- **Apple Silicon (M1/M2/M3)**：请下载 `*_aarch64.dmg`  
- **Intel 芯片**：若有提供 `*_x64.dmg`，请下载对应版本

---

## 下载与安装

### 1. 下载

打开 [Releases](https://github.com/conscioustime/feishu-ask-desktop/releases) 页面，下载最新版本中的：

- **飞书 Ask_xxx_aarch64.dmg**（安装包，Apple Silicon 用）

建议同时下载同版本下的 **fix.command**（或 fix.sh），与 dmg 放在同一文件夹，便于安装后使用。

### 2. 安装

1. 双击 **.dmg** 打开，将「**飞书 Ask.app**」拖入「**应用程序**」文件夹（或拖到窗口里的 Applications 快捷方式）。
2. 关闭 dmg 窗口。
3. 在下载目录找到 **fix.command**，**双击运行一次**（若弹出终端并提示输入密码，输入本机登录密码即可）。
4. 打开 **启动台** 或 **应用程序**，点击「**飞书 Ask**」即可使用。

### 3. 首次使用

- 应用内会打开飞书 Ask 网页，需**登录你的飞书账号**后使用。
- 需要联网；登录状态会由飞书网页端管理。

---

## 常见问题

**打开时提示「已损坏」或无法打开？**  
请务必先**双击运行一次 fix.command**（与 dmg 同次下载的），再打开应用。因应用未做 Apple 开发者签名，系统会隔离从网络下载的 app，fix 脚本会解除隔离并做本机签名，只需运行一次。

**没有 fix.command 怎么办？**  
回到 [Releases](https://github.com/conscioustime/feishu-ask-desktop/releases) 页面，在同一次发布里下载 fix.command 或 fix.sh，放到任意位置后双击 fix.command 运行一次即可。

---

## 开发者（从源码构建）

若需从源码打包，请确保已安装 [Node.js](https://nodejs.org/) 与 [Rust](https://rustup.rs/)，在项目目录执行：

```bash
npm install
npm run build
```

产物位于 `src-tauri/target/release/bundle/`。发布时请将 dmg 与 fix 脚本上传至 GitHub Release，供用户下载。

---

## 许可证

MIT
