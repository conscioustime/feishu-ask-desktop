分发给其他人时，请一起提供：

1. 飞书 Ask_0.1.0_aarch64.dmg（或 x64 的 .dmg）
2. 本目录下的 fix.command（或 fix.sh）

对方使用步骤：
- 双击 .dmg 打开，把「飞书 Ask.app」拖到「应用程序」
- 双击 fix.command（或在终端运行 ./fix.sh）
- 之后即可在启动台/应用程序里正常打开「飞书 Ask」

说明：因未做 Apple 开发者签名，macOS 会隔离从网络下载的 app；fix 脚本会移除隔离并做本机签名，只需运行一次。
