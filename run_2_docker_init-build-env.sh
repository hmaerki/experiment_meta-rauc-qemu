#
# The yocto project proposes a `setupsdk` script.
# In our docker container, we used this bashrc instead!
#
# set -eo

export ROOT=/workdir
export LAYERS=$ROOT/layers
export META_DEMO=$LAYERS/meta-rauc-qemu-demo
export TEMPLATECONF=$META_DEMO/conf

source $LAYERS/poky/oe-init-build-env $ROOT/build

if [ ! -f "conf/site.conf" ]; then
    cp $META_DEMO/conf/site.conf.sample conf/site.conf
fi

export RAUC_KEYRING_FILE="$META_DEMO/example-ca/ca.cert.pem"
export RAUC_KEY_FILE="$META_DEMO/example-ca/private/development-1.key.pem"
export RAUC_CERT_FILE="$META_DEMO/example-ca/development-1.cert.pem"

export PATH=$META_DEMO:$PATH
echo "Calling: oe-init-build-env $ROOT/build"
