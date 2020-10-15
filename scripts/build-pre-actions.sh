# Set Version Number

if [ "$CONFIGURATION" == "Release" ] ; then

PLISTPATH="$SRCROOT/$INFOPLIST_FILE"

VERSIONNUM=$(/usr/libexec/PlistBuddy -c "Print CFBundleShortVersionString" "$PLISTPATH")
if [ "$VERSIONNUM" == '$(MARKETING_VERSION)' ] ; then
    VERSIONNUM=$MARKETING_VERSION
fi
FIRSTCOMPONENT=`echo $VERSIONNUM | awk -F "." '{print $1}'`
SECONDCOMPONENT=`echo $VERSIONNUM | awk -F "." '{print $2}'`
THIRDCOMPONENT=`echo $VERSIONNUM | awk -F "." '{print $3}'`
DATESTRING=`date +"%y%m%d%H%M"`
if [ "$SECONDCOMPONENT" == "" ] ; then
    SECONDCOMPONENT="0"
fi
if [ "$THIRDCOMPONENT" == "" ] ; then
    THIRDCOMPONENT="0"
fi
BUILDNUMBER="$FIRSTCOMPONENT.$SECONDCOMPONENT.$THIRDCOMPONENT.$DATESTRING"
/usr/libexec/PlistBuddy -c "Set :CFBundleVersion $BUILDNUMBER" "$PLISTPATH"

fi

# Set CFBuildDate

if [ "$CONFIGURATION" == "Release" ] ; then

PLISTPATH="$SRCROOT/$INFOPLIST_FILE"

DATESTRING=`date +"%d.%m.%Y %H:%M:%S %z"`

OLDBUILDDATE=$(/usr/libexec/PlistBuddy -c "Print CFBuildDate" "$PLISTPATH" 2>/dev/null)

if [ "$OLDBUILDDATE" == "" ] ; then

/usr/libexec/PlistBuddy -c "Add :CFBuildDate String $DATESTRING" "$PLISTPATH"

else

/usr/libexec/PlistBuddy -c "Set :CFBuildDate $DATESTRING" "$PLISTPATH"

fi

fi
