#!/sbin/sh 
#ramdisk_gov_sed.sh by show-p1984 
#Features: extracts ramdisk finds 
#busbox in /system or sets default location if it cannot be found add init.d 
#support if not already supported removes governor overrides removes min 
#freq overrides



mkdir /tmp/ramdisk
cp /tmp/boot.img-ramdisk.gz /tmp/ramdisk/
cd /tmp/ramdisk/
gunzip -c /tmp/ramdisk/boot.img-ramdisk.gz | cpio -i
cd /


rm /tmp/ramdisk/boot.img-ramdisk.gz
rm /tmp/boot.img-ramdisk.gz
cd /tmp/ramdisk/
find . | cpio -o -H newc | gzip > ../boot.img-ramdisk.gz
cd /
rm -rf /tmp/ramdisk
