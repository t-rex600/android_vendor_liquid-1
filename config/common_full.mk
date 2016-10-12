# Inherit common Liquid stuff
$(call inherit-product, vendor/liquid/config/common.mk)

PRODUCT_SIZE := full

# Themes
PRODUCT_PACKAGES += \
    HexoLibre
