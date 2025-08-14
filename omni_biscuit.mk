#
# Copyright (C) 2025 The Team Win Recovery Project
#
# SPDX-License-Identifier: Apache-2.0
#

# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/aosp_base.mk)

# Inherit some common AOSP stuff.
$(call inherit-product-if-exists, vendor/cm/config/common.mk)
$(call inherit-product-if-exists, vendor/omni/config/common.mk)
$(call inherit-product-if-exists, vendor/twrp/config/common.mk)

PRODUCT_DEVICE := biscuit
PRODUCT_NAME := omni_biscuit
PRODUCT_BRAND := Amazon
PRODUCT_MODEL := Echo Dot 2nd Gen
PRODUCT_MANUFACTURER := Amazon