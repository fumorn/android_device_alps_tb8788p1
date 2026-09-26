# TWRP device tree for tb8788p1_64_wifi (MT6771 / Chuwi TALIH-PD1)

CI builds TWRP (twrp-12.1 branch) with our prebuilt TALIH-PD1 kernel
(4.14.186 with it6112 display + TDDI touch fixes).

## 设备要点
- MT6771 (Helio P60), arm64, 4.14 内核（prebuilt, 自研）
- A/B 分区 + recovery-in-boot（`BOARD_USES_RECOVERY_AS_BOOT`）
- UFS（sda），by-name 路径 `/dev/block/platform/bootdevice/by-name/`
- 显示：it6112 MIPI 桥 + HX83102P TDDI（1600x2176, fb0/mtkfb, 32bpp）
- /data：ext4 + inlinecrypt 卷级加密——**Phase 1 不解密**（TWRP 里 data 挂不上是预期）

## 编译
GitHub Actions 自动编译（`.github/workflows/build.yml`），产物 `boot.img`：
- 临时启动：`fastboot boot boot.img`（不进分区，零风险）
- 或刷入 recovery 模式使用

## 结构
- `BoardConfig.mk` — 板级配置（prebuilt kernel/dtb + TWRP 图形/触摸参数）
- `twrp_tb8788p1.mk` / `AndroidProducts.mk` — 产品定义
- `recovery.fstab` — 分区表（源自原厂，改 TWRP 格式）
- `prebuilt/Image` — 自研内核（CI 最新稳定版）
- `prebuilt/dtb` — 原厂 mt6771 dtb（mkdtimg 容器）
