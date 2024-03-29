#!/bin/sh

echo "Calling custom handler: $*"

case "$1" in
        slot-install)
                # Environment variables in custom handlers:
                # See: https://rauc.readthedocs.io/en/latest/reference.html?highlight=format#custom-handlers-interface
                echo "RAUC_IMAGE_NAME=$RAUC_IMAGE_NAME $RAUC_IMAGE_SIZE bytes"
                set | grep RAUC
                cp $RAUC_IMAGE_NAME /demo_binary.bin
                chmod a+x /demo_binary.bin
                exit 0
                ;;
esac

>&2 echo "Unexpected $*"

exit 2
