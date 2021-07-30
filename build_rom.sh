# sync rom
repo init --depth=1 --no-repo-verify -u https://gitlab.e.foundation/e/os/android.git -b v1-r -g default,-device,-mips,-darwin,-notdefault
git clone https://github.com/Realme-G70-Series/local_manifest.git --depth=1 .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build rom
source build/envsetup.sh
lunch lineage_RMX2020-userdebug
export TZ=Asia/Dhaka #put before last build command
mka bacon -j$(nproc --all) 

# upload rom 
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
 
