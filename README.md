# Yocto & Rauc Demo

See

* https://github.com/rauc/meta-rauc
* https://rauc.readthedocs.io/en/latest/
* https://www.pengutronix.de/de/blog/2022-02-03-tutorial-evaluating-rauc-on-qemu-a-quick-setup-with-yocto.html
* https://github.com/rauc/meta-rauc-community/blob/master/meta-rauc-qemux86/README.rst


**Create directory structure**

and clone this repo into directory `poky/meta-rauc-qemu-demo`.

```
poky/meta-rauc-qemu-demo 
```

**Clone other layers**

```
cd poky
./meta-rauc-qemu-demo/run_1_yocto_bootstrap_git.sh
```

**Start docker container**

```
cd poky
docker run --rm -it --network=host -v `pwd`:/workdir crops/poky --workdir=/workdir
```

Build

```
source ./meta-rauc-qemu-demo/run_2_docker_init-build-env.sh

bitbake core-image-minimal
```

Start

```
runqemu nographic slirp ovmf wic core-image-minimal

rauc status
```

Build update bundle

```
bitbake qemu-demo-bundle
```

Remove qemu-disks

```
rm -f `find /workdir/build/tmp/ -name *qemux86-64*.rootfs.wic`
bitbake -c cleanall core-image-minimal
bitbake core-image-minimal
runqemu nographic slirp ovmf wic core-image-minimal
```

Update

```
scp -P 2222 tmp/deploy/images/qemux86-64/qemu-demo-bundle-qemux86-64.raucb root@localhost:/data/

rauc install /data/qemu-demo-bundle-qemux86-64.raucb
```


## Rauc Hawkbit Updater

* https://github.com/rauc/rauc-hawkbit-updater


Start qemu, make sure the containers 

```
journalctl --follow -u rauc-hawkbit-updater.service
```


Start the update server 

```
docker run -it -p 8080:8080 hawkbit/hawkbit-update-server
```

admin/admin

