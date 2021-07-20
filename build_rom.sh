# sync rom
repo init --depth=1 --no-repo-verify -u https://github.com/Komodo-OS-Rom/manifest -b 11 -g default,-device,-mips,-darwin,-notdefault
git clone https://github.com/Fraschze97/local_manifest.git --depth 1 -b Komodo-11 .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build rom
source build/envsetup.sh
lunch komodo_RMX1941-userdebug
export SKIP_API_CHECKS=true
export SKIP_ABI_CHECKS=true
export ALLOW_MISSING_DEPENDENCIES=true
export TZ=Asia/Jakarta
masak komodo

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
