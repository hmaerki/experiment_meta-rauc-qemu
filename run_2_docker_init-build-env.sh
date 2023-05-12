#
# The yocto project proposes a `setupsdk` script.
# In our docker container, we used this bashrc instead!
#

export ROOT=/workdir
export TEMPLATECONF=$ROOT/layers/meta-rauc-qemu-demo/conf
source $ROOT/layers/poky/oe-init-build-env $ROOT/build

if [ ! -f "conf/site.conf" ]; then
    cp $ROOT/layers/meta-rauc-qemu-demo/conf/site.conf.sample conf/site.conf
fi

echo "Calling: oe-init-build-env $ROOT/build"
