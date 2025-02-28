#Generate vck190 platform

export CUR_DIR=$PWD
cd $CUR_DIR/vck190_platform
make all

#Generate Pre-processor xo file
cd $CUR_DIR/../../../../plugins/blobfromimage/pl
make cleanall
make xo TARGET=hw BLOB_CHANNEL_SWAP_EN=0 BLOB_CROP_EN=0 BLOB_LETTERBOX_EN=1 BLOB_JPEG_EN=0 BLOB_NPC=XF_NPPC4

#Generate SD card files
cd $CUR_DIR/vitis_prj
make all BLOB_ACCEL=../../../../../plugins/blobfromimage/pl XVDPU_PATH=../../../../../../dsa/DPUCVDX8G-XO
