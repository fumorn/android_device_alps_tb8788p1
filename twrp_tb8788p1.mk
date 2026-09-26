#
# SPDX-License-Identifier: Apache-2.0
#
# TWRP device tree for tb8788p1_64_wifi (MT6771 / Chuwi TALIH-PD1 tablet)
#

LOCAL_PATH := device/alps/tb8788p1

# Inherit from the common TWRP AOSP config
$(call inherit-product, $(SRC_TARGET_DIR)/product/base.mk)

# Inherit TWRP common parts
$(call inherit-product, vendor/twrp/config/common.mk)

# Device-specific files
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/recovery.fstab:root/recovery.fstab

PRODUCT_NAME := twrp_tb8788p1
PRODUCT_DEVICE := tb8788p1
PRODUCT_BRAND := alps
PRODUCT_MODEL := tb8788p1_64_wifi
PRODUCT_MANUFACTURER := alps

# A/B
AB_OTA_UPDATER := true
