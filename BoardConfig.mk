#
# SPDX-License-Identifier: Apache-2.0
#
# BoardConfig for tb8788p1_64_wifi (MT6771, Chuwi TALIH-PD1)
#

DEVICE_PATH := device/alps/tb8788p1

# Architecture
TARGET_ARCH := arm64
TARGET_ARCH_VARIANT := armv8-a
TARGET_CPU_ABI := arm64-v8a
TARGET_CPU_ABI2 :=
TARGET_CPU_VARIANT := cortex-a53
TARGET_IS_64_BIT := true
TARGET_SUPPORTS_64_BIT_APPS := true

TARGET_2ND_ARCH := arm
TARGET_2ND_ARCH_VARIANT := armv8-a
TARGET_2ND_CPU_ABI := armeabi-v7a
TARGET_2ND_CPU_ABI2 := armeabi
TARGET_2ND_CPU_VARIANT := cortex-a53
TARGET_SUPPORTS_32_BIT_APPS := true
TARGET_SUPPORTS_64_BIT_APPS := true

# Platform
TARGET_BOARD_PLATFORM := mt6771
TARGET_BOOTLOADER_BOARD_NAME := tb8788p1_64_wifi
TARGET_NO_BOOTLOADER := true
BOARD_USES_MTK_HARDWARE := true

# A/B + recovery in boot
AB_OTA_UPDATER := true
BOARD_USES_RECOVERY_AS_BOOT := true
AB_OTA_PARTITIONS += boot vendor vbmeta vbmeta_system vbmeta_vendor dtbo logo
# The real boot partition is 32MB, but the TWRP ramdisk (full UI + tools)
# makes boot.img ~46MB. Phase 1 targets `fastboot boot` (loads from RAM,
# no partition limit), so only satisfy the mkbootimg size check here.
# A flashable coexistence image will need ramdisk trimming first.
BOARD_BOOTIMAGE_PARTITION_SIZE := 67108864

# Kernel (prebuilt: our own TALIH-PD1 4.14.186 build with display/touch fixes)
TARGET_PREBUILT_KERNEL := $(DEVICE_PATH)/prebuilt/Image
BOARD_KERNEL_IMAGE_NAME := Image
BOARD_KERNEL_BASE := 0x40080000
BOARD_KERNEL_PAGESIZE := 2048
BOARD_KERNEL_CMDLINE := bootopt=64S3,32N2,64N2 buildvariant=user
BOARD_MKBOOTIMG_ARGS := --base 0x40080000 --pagesize 2048 --ramdisk_offset 0x55000000 --tags_offset 0x54000000 --header_version 2

# dtb: stock boot.img uses header v2 with a separate dtb section; mkbootimg
# only emits the dtb section when header_version >= 2. TWRP 12.1 has no
# BOARD_BOOT_HEADER_VERSION variable, so --header_version goes through
# BOARD_MKBOOTIMG_ARGS. The plain FDT (mkdtimg container unpacked) is fed
# via PREBUILT_DTBIMAGE_DIR (build packs *.dtb there into dtb.img).
BOARD_INCLUDE_DTB_IN_BOOTIMG := true
BOARD_PREBUILT_DTBIMAGE_DIR := $(DEVICE_PATH)/prebuilt/dtb

# Display / graphics (MTK framebuffer, not DRM)
TARGET_RECOVERY_PIXEL_FORMAT := "RGBX_8888"
TW_THEME := portrait_hdpi
DEVICE_RESOLUTION := 1600x2176
TW_MAX_BRIGHTNESS := 255
TW_DEFAULT_BRIGHTNESS := 120
TW_NO_SCREEN_BLANK := true
TW_NO_SCREEN_TIMEOUT := true
TW_SCREEN_BLANK_ON_BOOT := false
RECOVERY_GRAPHICS_USE_LINELENGTH := true
TARGET_RECOVERY_LCD_BACKLIGHT_PATH := \"/sys/class/leds/lcd-backlight/brightness\"

# Touch (HX83102P TDDI via our kernel driver)
# TW_INPUT_BLACKLIST := "accelerometer"
TW_NO_TOUCH_INPUT := false

# Crypto: NOT in phase 1 (inlinecrypt volume encryption on /data)
TW_INCLUDE_CRYPTO := false
TW_INCLUDE_CRYPTO_FBE := false

# Storage / partitions
TARGET_RECOVERY_FSTAB := $(DEVICE_PATH)/recovery.fstab
BOARD_HAS_LARGE_FILESYSTEM := true
BOARD_SUPPRESS_SECURE_ERASE := true
BOARD_HAS_NO_SELECT_BUTTON := true
RECOVERY_SDCARD_ON_DATA := false

# TWRP build options
TW_EXCLUDE_DEFAULT_USB_INIT := false
TW_USE_TOOLBOX := true
TW_INCLUDE_REPACKTOOLS := true
TW_INCLUDE_RESETPROP := true
TW_EXCLUDE_TWRPAPP := true
TW_EXCLUDE_APEX := true
TW_EXTRA_LANGUAGES := true
TW_DEFAULT_LANGUAGE := zh_CN
TWRP_INCLUDE_LOGCAT := true
TARGET_USES_LOGD := true

# Logcat for debugging
TWRP_EVENT_LOGGING := true

# Vendor
TARGET_COPY_OUT_VENDOR := vendor
