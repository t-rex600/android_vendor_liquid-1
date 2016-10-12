# Inherit common Liquid stuff
$(call inherit-product, vendor/liquid/config/common_full.mk)

# Required Liquid packages
PRODUCT_PACKAGES += \
    LatinIME

# Include Liquid LatinIME dictionaries
PRODUCT_PACKAGE_OVERLAYS += vendor/liquid/overlay/dictionaries

$(call inherit-product, vendor/liquid/config/telephony.mk)
