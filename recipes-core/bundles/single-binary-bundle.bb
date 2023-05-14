DESCRIPTION = "Hans hook bundle"

inherit bundle

LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

RAUC_BUNDLE_COMPATIBLE = "qemu86-64 demo platform"

RAUC_BUNDLE_DESCRIPTION = "Hans hook bundle"

RAUC_IMAGE_FSTYPE = "raw"

SRC_URI += " file://dummy_kernel.txt"
RAUC_SLOT_rootfs = "linux"
RAUC_SLOT_rootfs[fstype] = "file"
RAUC_SLOT_rootfs[file] = "dummy_kernel.txt"

SRC_URI += " file://install-hook.sh"
RAUC_BUNDLE_HOOKS[file] = "install-hook.sh"
RAUC_SLOT_rootfs[hooks] = "install"

# RAUC_BUNDLE_EXTRAS ?= "kernel"
# RAUC_BUNDLE_EXTRA_kernel[file] ?= "dummy_kernel.txt"
