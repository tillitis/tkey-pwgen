#! /bin/sh

set -e

tkey_libs_version="v0.0.1"
signer_version="v0.0.7"

printf "Building tkey-libs with version: %s\n" "$tkey_libs_version"
printf "Building signer with version: %s\n" "$signer_version"

if [ -d ../tkey-libs ]
then
    (cd ../tkey-libs; git checkout "$tkey_libs_version")
else
    git clone -b "$tkey_libs_version" https://github.com/tillitis/tkey-libs.git ../tkey-libs
fi

if [ -d ../tkey-device-signer ]
then
    (cd ../tkey-device-signer; git checkout "$signer_version")
else
    git clone -b "$signer_version" https://github.com/tillitis/tkey-device-signer.git ../tkey-device-signer
fi

make -C ../tkey-libs podman
make -C ../tkey-device-signer podman

cp ../tkey-device-signer/signer/app.bin cmd/tkey-sign/signer.bin-${signer_version}

make podman
