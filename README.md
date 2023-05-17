# Yocto & Rauc Demo

See

* https://github.com/rauc/meta-rauc
* https://rauc.readthedocs.io/en/latest/
* https://www.pengutronix.de/de/blog/2022-02-03-tutorial-evaluating-rauc-on-qemu-a-quick-setup-with-yocto.html
* https://github.com/rauc/meta-rauc-community/blob/master/meta-rauc-qemux86/README.rst


**Create directory structure**

and clone this repo into directory `poky/layers/meta-rauc-qemu-demo`.


**Clone other layers**

```
cd poky
./layers/meta-rauc-qemu-demo/run_1_ubuntu_bootstrap_git.sh
```

**Start docker container**

```
cd poky
docker run --rm -it --network=host -v `pwd`:/workdir crops/poky --workdir=/workdir
```

**Build**

```
source ./layers/meta-rauc-qemu-demo/run_2_docker_init-build-env.sh

bitbake core-image-minimal
```

**Start qemu**

```
runqemu nographic slirp ovmf wic core-image-minimal

rauc status
```

## Prepare bundle deployment

On host start ngins

```
cd poky
layers/meta-rauc-qemu-demo/run_2_ubuntu_nginx.sh
```

### Create bundle `qemu-demo-bundle`

In crops container
```
bitbake qemu-demo-bundle
```

In qemu

```
rauc install http://10.0.2.2:8000/build/tmp/work/qemux86_64-poky-linux/qemu-demo-bundle/1.0-r0/deploy-qemu-demo-bundle/qemu-demo-bundle-qemux86-64.raucb
reboot
```


### Create bundle `bundle-single-binary`

In container
```
cd poky

bitbake rauc-native -caddto_recipe_sysroot

rm -f bundle-single-binary.raucb ; \
oe-run-native rauc-native \
  rauc bundle \
  --key=$RAUC_KEY_FILE \
  --cert=$RAUC_CERT_FILE \
  --keyring=$RAUC_KEYRING_FILE \
  $META_DEMO/bundle_samples/bundle-single-binary/ \
  bundle-single-binary.raucb
```

In qemu

```
rauc install http://10.0.2.2:8000/bundle-single-binary.raucb
reboot
```


## Rauc Hawkbit Updater

* https://github.com/rauc/rauc-hawkbit-updater


Start qemu, make sure the containers 

```
journalctl --follow -u rauc-hawkbit-updater.service
```


Start the update server 

```
docker run -it --rm --network=host hawkbit/hawkbit-update-server
```

admin/admin


# Divers

Remove qemu-disks

```
rm -f `find /workdir/build/tmp/ -name *qemux86-64*.rootfs.wic`
bitbake -c cleanall rauc core-image-minimal
bitbake rauc core-image-minimal
runqemu nographic slirp ovmf wic core-image-minimal
```

Verify contents of bundle

```
oe-run-native rauc-native rauc info --keyring=/workdir/layers/meta-rauc-qemu-demo/example-ca/ca.cert.pem tmp/deploy/images/qemux86-64/qemu-demo-bundle-qemux86-64.raucb
```

```
systemctl list-units
dbus.service
rauc-hawkbit-updater.service
rauc-mark-good.service
rauc.service 
dbus.socket
sshd.socket

journalctl -u rauc-hawkbit-updater.service
journalctl -u sshd.socket
```
