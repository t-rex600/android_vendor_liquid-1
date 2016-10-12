# Inherit common Liquid stuff
$(call inherit-product, vendor/liquid/config/common_mini.mk)

# Required Liquid packages
PRODUCT_PACKAGES += \
    LatinIME
