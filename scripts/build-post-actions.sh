# Reset Version Number

PLISTPATH="$SRCROOT/$INFOPLIST_FILE"
SHORTVERSION=$(/usr/libexec/PlistBuddy -c "Print CFBundleShortVersionString" "$PLISTPATH")
BUNDLEVERSION=$(/usr/libexec/PlistBuddy -c "Print CFBundleVersion" "$PLISTPATH")

if [ "$SHORTVERSION" != "$BUNDLEVERSION" ] ; then
    /usr/libexec/PlistBuddy -c "Set :CFBundleVersion $SHORTVERSION" "$PLISTPATH"
fi

# Reset CFBuildDate

PLISTPATH="$SRCROOT/$INFOPLIST_FILE"
OLDBUILDDATE=$(/usr/libexec/PlistBuddy -c "Print CFBuildDate" "$PLISTPATH" 2>/dev/null)

if [ "$OLDBUILDDATE" != "" ] ; then
    /usr/libexec/PlistBuddy -c "Delete :CFBuildDate" "$PLISTPATH"
fi
