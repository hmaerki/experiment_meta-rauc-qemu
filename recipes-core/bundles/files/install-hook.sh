#!/bin/sh

>&2 echo "A $1"

case "$1" in
        slot-install)
                # only rootfs needs to be handled
                >&2 echo "B $RAUC_SLOT_CLASS"
                test "$RAUC_SLOT_CLASS" = "rootfs" || exit 0

                >&2 echo "C $RAUC_IMAGE_NAME"
                touch "$RAUC_SLOT_MOUNT_POINT/extra-file-2"
                ;;
        *)
                >&2 echo "D"
                exit 1
                ;;
esac

>&2 echo "F"

exit 0