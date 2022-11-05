#!/system/bin/sh

MARK=/data/.FACTORY_RESET
PKGS=/system/vendor/preinstall
RECOVERY=cwm-recovery.img

# disable SAGE AirMouse
am broadcast -a "disablesagesoundoutput.broadcast" -c android.intent.category.HOME -n com.android.settings/.DisableSageSoundOutput
if [ ! -e $MARK ]; then
  if [ -e $PKGS/$RECOVERY ] ; then
    flash_image recovery $PKGS/$RECOVERY
    mount -o remount,rw /dev/block/mtdblock8
    rm $PKGS/$RECOVERY
    mount -o remount,ro /dev/block/mtdblock8
  fi
  busybox find $PKGS -name "*\.apk" -exec sh /system/bin/pm install {} \;
  touch $MARK
fi
