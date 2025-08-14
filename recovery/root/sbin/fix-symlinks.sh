#!/sbin/sh

PATH=/sbin:/system/sbin:/system/bin:/system/xbin

CURRENT_SLOT=`getprop ro.boot.slot_suffix 2>/dev/null`

REAL_BOOT_A=`readlink -f /dev/block/platform/mtk-msdc.0/by-name/boot_a_x`
REAL_BOOT_B=`readlink -f /dev/block/platform/mtk-msdc.0/by-name/boot_a_b`
AMONET_BOOT_A=`readlink -f /dev/block/platform/mtk-msdc.0/by-name/boot_a`
REAL_LK_A=`readlink -f /dev/block/platform/mtk-msdc.0/by-name/lk_a`
REAL_LK_B=`readlink -f /dev/block/platform/mtk-msdc.0/by-name/lk_b`
REAL_TEE1=`readlink -f /dev/block/platform/mtk-msdc.0/by-name/tee1`
REAL_TEE2=`readlink -f /dev/block/platform/mtk-msdc.0/by-name/tee2`

rm /dev/block/platform/mtk-msdc.0/by-name/boot_a
rm /dev/block/platform/mtk-msdc.0/by-name/boot_b
rm /dev/block/platform/mtk-msdc.0/by-name/lk_a
rm /dev/block/platform/mtk-msdc.0/by-name/lk_b
rm /dev/block/platform/mtk-msdc.0/by-name/tee1
rm /dev/block/platform/mtk-msdc.0/by-name/tee2

ln -s $REAL_BOOT_A /dev/block/platform/mtk-msdc.0/by-name/boot_a
ln -s $REAL_BOOT_B /dev/block/platform/mtk-msdc.0/by-name/boot_b
ln -s $AMONET_BOOT_A /dev/block/platform/mtk-msdc.0/by-name/boot_a_amonet
ln -s $AMONET_BOOT_B /dev/block/platform/mtk-msdc.0/by-name/boot_b_amonet
ln -s $REAL_LK_A /dev/block/platform/mtk-msdc.0/by-name/lk_a_real
ln -s $REAL_LK_B /dev/block/platform/mtk-msdc.0/by-name/lk_b_real
ln -s $REAL_TEE1 /dev/block/platform/mtk-msdc.0/by-name/tee1_real
ln -s $REAL_TEE2 /dev/block/platform/mtk-msdc.0/by-name/tee2_real

ln -s /dev/null /dev/block/platform/mtk-msdc.0/by-name/lk_a
ln -s /dev/null /dev/block/platform/mtk-msdc.0/by-name/lk_b
ln -s /dev/null /dev/block/platform/mtk-msdc.0/by-name/tee1
ln -s /dev/null /dev/block/platform/mtk-msdc.0/by-name/tee2

ln -s /dev/null /dev/block/other-lk
ln -s /dev/block/platform/mtk-msdc.0/by-name/system${CURRENT_SLOT} /dev/block/other-system
ln -s /dev/block/platform/mtk-msdc.0/by-name/boot${CURRENT_SLOT} /dev/block/other-boot