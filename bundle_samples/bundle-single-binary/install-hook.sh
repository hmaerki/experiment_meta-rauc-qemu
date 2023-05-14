#!/bin/sh

echo "Calling custom handler: $*"

case "$1" in
        slot-install)
                # Environment variables in custom handlers:
                # See: https://rauc.readthedocs.io/en/latest/reference.html?highlight=format#custom-handlers-interface
                >&2 echo "RAUC_IMAGE_NAME=$RAUC_IMAGE_NAME"
                >&2 set | grep rauc
                cp $RAUC_IMAGE_NAME /
                exit 0
                ;;
esac

>&2 echo "Unexpected $*"

exit 2
