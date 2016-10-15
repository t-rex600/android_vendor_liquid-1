# Liquidproduct
PRODUCT_BRAND ?= liquid
PRODUCT_NAME ?= liquid

# Definitions
CONFIG := vendor/liquid/config
OVERLAY := vendor/liquid/overlay
PREBUILT := vendor/liquid/prebuilt/common

# Copy prebuilt files
PRODUCT_COPY_FILES +=  \
    $(PREBUILT)/media/bootanimation.zip:system/media/bootanimation.zip

PRODUCT_BUILD_PROP_OVERRIDES += BUILD_UTC_DATE=$(shell date +"%s")

ifeq ($(PRODUCT_GMS_CLIENTID_BASE),)
PRODUCT_PROPERTY_OVERRIDES += \
    ro.com.google.clientidbase=android-google
else
PRODUCT_PROPERTY_OVERRIDES += \
    ro.com.google.clientidbase=$(PRODUCT_GMS_CLIENTID_BASE)
endif

PRODUCT_PROPERTY_OVERRIDES += \
    keyguard.no_require_sim=true \
    ro.url.legal=http://www.google.com/intl/%s/mobile/android/basic/phone-legal.html \
    ro.url.legal.android_privacy=http://www.google.com/intl/%s/mobile/android/basic/privacy.html \
    ro.com.android.wifi-watchlist=GoogleGuest \
    ro.setupwizard.enterprise_mode=1 \
    ro.com.android.dateformat=dd-MM-yyyy \
    ro.com.android.dataroaming=false

PRODUCT_PROPERTY_OVERRIDES += \
    ro.build.selinux=1

# Default notification/alarm sounds
PRODUCT_PROPERTY_OVERRIDES += \
    ro.config.notification_sound=Argon.ogg \
    ro.config.alarm_alert=Helium.ogg

ifneq ($(TARGET_BUILD_VARIANT),user)
# Thank you, please drive thru!
PRODUCT_PROPERTY_OVERRIDES += persist.sys.dun.override=0
endif

ifneq ($(TARGET_BUILD_VARIANT),eng)
# Enable ADB authentication
ADDITIONAL_DEFAULT_PROPERTIES += ro.adb.secure=1
endif

# Backup Tool
PRODUCT_COPY_FILES += \
    $(PREBUILT)/bin/backuptool.sh:install/bin/backuptool.sh \
    $(PREBUILT)/bin/backuptool.functions:install/bin/backuptool.functions \
    $(PREBUILT)/bin/50-cm.sh:system/addon.d/50-cm.sh \
    $(PREBUILT)/bin/blacklist:system/addon.d/blacklist

# Backup Services whitelist
PRODUCT_COPY_FILES += \
    $(CONFIG)/permissions/backup.xml:system/etc/sysconfig/backup.xml

# Signature compatibility validation
PRODUCT_COPY_FILES += \
    $(PREBUILT)/bin/otasigcheck.sh:install/bin/otasigcheck.sh

# init.d support
PRODUCT_COPY_FILES += \
    $(PREBUILT)/etc/init.d/00banner:system/etc/init.d/00banner \
    $(PREBUILT)/bin/sysinit:system/bin/sysinit

ifneq ($(TARGET_BUILD_VARIANT),user)
# userinit support
PRODUCT_COPY_FILES += \
    $(PREBUILT)/etc/init.d/90userinit:system/etc/init.d/90userinit
endif

# Liquid-specific init file
PRODUCT_COPY_FILES += \
    $(PREBUILT)/etc/init.local.rc:root/init.liquid.rc

# Copy over added mimetype supported in libcore.net.MimeUtils
PRODUCT_COPY_FILES += \
    $(PREBUILT)/lib/content-types.properties:system/lib/content-types.properties

# Enable SIP+VoIP on all targets
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.software.sip.voip.xml:system/etc/permissions/android.software.sip.voip.xml

# Enable wireless Xbox 360 controller support
PRODUCT_COPY_FILES += \
    frameworks/base/data/keyboards/Vendor_045e_Product_028e.kl:system/usr/keylayout/Vendor_045e_Product_0719.kl

# This is Liquid!
PRODUCT_COPY_FILES += \
    $(CONFIG)/permissions/com.cyanogenmod.android.xml:system/etc/permissions/com.cyanogenmod.android.xml

# Copy LatinIME libs for gesture typing
PRODUCT_COPY_FILES += \
    $(PREBUILT)/lib/libjni_latinime.so:system/lib/libjni_latinime.so \
    $(PREBUILT)/lib/libjni_latinimegoogle.so:system/lib/libjni_latinimegoogle.so \
    $(PREBUILT)/lib64/libjni_latinime.so:system/lib64/libjni_latinime.so \
    $(PREBUILT)/lib64/libjni_latinimegoogle.so:system/lib64/libjni_latinimegoogle.so

# Include Liquid audio files
include $(CONFIG)/liquid_audio.mk

# Theme engine
include $(CONFIG)/themes_common.mk

ifneq ($(TARGET_DISABLE_CMSDK), true)
# CMSDK
include $(CONFIG)/cmsdk_common.mk
endif

# Required Liquid packages
PRODUCT_PACKAGES += \
    BluetoothExt \
    CMAudioService \
    CMParts \
    Development \
    Profiles \
    WeatherManagerService

# Optional Liquid packages
PRODUCT_PACKAGES += \
    libemoji \
    Terminal \
    LiveWallpapersPicker \
    PhotoTable

# Include librsjni explicitly to workaround GMS issue
PRODUCT_PACKAGES += \
    librsjni

# Custom Liquid packages
PRODUCT_PACKAGES += \
    Trebuchet \
    AudioFX \
    CMFileManager \
    Eleven \
    LockClock \
    CMSettingsProvider \
    ExactCalculator \
    LiveLockScreenService \
    WeatherProvider \
    SoundRecorder \
    Screencast

# Exchange support
PRODUCT_PACKAGES += \
    Exchange2

# Extra tools in XenonHD
PRODUCT_PACKAGES += \
    libsepol \
    mke2fs \
    tune2fs \
    nano \
    htop \
    mkfs.ntfs \
    fsck.ntfs \
    mount.ntfs \
    gdbserver \
    micro_bench \
    oprofiled \
    sqlite3 \
    strace \
    pigz \
    7z \
    lib7z \
    bash \
    bzip2 \
    curl \
    powertop \
    unrar \
    unzip \
    vim \
    wget \
    zip

# Custom off-mode charger
ifneq ($(WITH_CM_CHARGER),false)
PRODUCT_PACKAGES += \
    charger_res_images \
    cm_charger_res_images \
    font_log.png \
    libhealthd.cm
endif

# ExFAT support
WITH_EXFAT ?= true
ifeq ($(WITH_EXFAT),true)
TARGET_USES_EXFAT := true
PRODUCT_PACKAGES += \
    mount.exfat \
    fsck.exfat \
    mkfs.exfat
endif

# Openssh
PRODUCT_PACKAGES += \
    scp \
    sftp \
    ssh \
    sshd \
    sshd_config \
    ssh-keygen \
    start-ssh

# rsync
PRODUCT_PACKAGES += \
    rsync

# Stagefright FFMPEG plugin
PRODUCT_PACKAGES += \
    libffmpeg_extractor \
    libffmpeg_omx \
    media_codecs_ffmpeg.xml

PRODUCT_PROPERTY_OVERRIDES += \
    media.sf.omx-plugin=libffmpeg_omx.so \
    media.sf.extractor-plugin=libffmpeg_extractor.so

# Telephony
PRODUCT_PACKAGES += \
    telephony-ext

PRODUCT_BOOT_JARS += \
    telephony-ext

# These packages are excluded from user builds
ifneq ($(TARGET_BUILD_VARIANT),user)
PRODUCT_PACKAGES += \
    procmem \
    procrank \
    su
endif

PRODUCT_PROPERTY_OVERRIDES += \
    persist.sys.root_access=0

DEVICE_PACKAGE_OVERLAYS += $(OVERLAY)/common

# Liquid version
BOARD := $(subst liquid_,,$(TARGET_PRODUCT))
PRODUCT_NAME := $(TARGET_PRODUCT)

LIQUID_VERSION :=  Liquid-$(shell date +"%y-%m-%d")-$(OTA_TYPE)

PRODUCT_PROPERTY_OVERRIDES += \
    ro.liquid.version=Liquid-$(shell date +"%y-%m-%d") \
    ro.modversion=Liquid-$(shell date +"%y-%m-%d") \
    ro.rommanager.developerid=LiquidDark

ifeq ($(OTA_PACKAGE_SIGNING_KEY),)
    PRODUCT_EXTRA_RECOVERY_KEYS += \
        vendor/liquid/build/target/product/security/cm \
        vendor/liquid/build/target/product/security/cm-devkey
endif

-include vendor/cm-priv/keys/keys.mk

ifneq ($(PRODUCT_DEFAULT_DEV_CERTIFICATE),)
ifneq ($(PRODUCT_DEFAULT_DEV_CERTIFICATE),build/target/product/security/testkey)
    ifndef TARGET_VENDOR_RELEASE_BUILD_ID
      TARGET_VENDOR_RELEASE_BUILD_ID := $(shell date -u +%Y%m%d)
    endif
endif
endif

-include $(WORKSPACE)/build_env/image-auto-bits.mk
-include $(CONFIG)/partner_gms.mk
-include vendor/cyngn/product.mk

$(call prepend-product-if-exists, vendor/extra/product.mk)
