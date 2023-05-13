DESCRIPTION = "Hans hook bundle"

inherit bundle

LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

RAUC_BUNDLE_COMPATIBLE = "qemu86-64 demo platform"

RAUC_BUNDLE_DESCRIPTION = "Hans hook bundle"
RAUC_BUNDLE_SLOTS = "efi rootfs"

RAUC_SLOT_rootfs = "core-image-minimal"
# uncomment for enabling adaptive update method 'block-hash-index'
#RAUC_SLOT_rootfs[fstype] = "ext4"
#RAUC_SLOT_rootfs[adaptive] = "block-hash-index"

RAUC_SLOT_efi = "boot-image"
RAUC_SLOT_efi[file] = "efi-boot.vfat"
RAUC_SLOT_efi[type] = "boot"

SRC_URI += " file://post-install-hook.sh"
RAUC_BUNDLE_HOOKS[file] = "post-install-hook.sh"
# RAUC_BUNDLE_HOOKS[hooks] = "post-install"
RAUC_SLOT_rootfs[hooks] = "post-install"