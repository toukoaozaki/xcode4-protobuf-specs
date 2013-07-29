#!/bin/bash

#  Created by Alex Karahalios on 6/12/11
#  Edited by Brian Reinhart on 08/02/2012
#  Edited by Eunsoo Roh on 07/28/2013
#  Last edited 07/28/2013
#
# Updates Xcode 4 to support Protocol Buffer for syntax highlighting
#

# Path were this script is located
#
SCRIPT_PATH="$(dirname "$BASH_SOURCE")"

# Set up path for PlistBuddy helper application which can add elements to Plist files
#
PLISTBUDDY=/usr/libexec/PlistBuddy

# Filename path private framework we need to modify
#
#DVTFOUNDATION_PATH="/Developer/Library/PrivateFrameworks/DVTFoundation.framework/Versions/A/Resources/"
#DVTFOUNDATION_PATH="/XCode4.3/Library/PrivateFrameworks/DVTFoundation.framework/Versions/A/Resources/"

# This framework is found withing the Xcode.app package and is used when Xcode is a monolithic
# install (all contained in Xcode.app)
#
DVTFOUNDATION_PATH="/Applications/Xcode.app/Contents/SharedFrameworks/DVTFoundation.framework/Versions/A/Resources/"

# Create Plist file of additional languages to add to 'DVTFoundation.xcplugindata'
#
cat >AdditionalLanguages.plist <<EOF
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
  <key>Xcode.SourceCodeLanguage.protobuf</key>
  <dict>
    <key>languageSpecification</key>
    <string>xcode.lang.protobuf</string>
    <key>fileDataType</key>
    <array>
      <dict>
        <key>identifier</key>
        <string>com.google.protobuf-source</string>
      </dict>
    </array>
    <key>id</key>
    <string>Xcode.SourceCodeLanguage.protobuf</string>
    <key>point</key>
    <string>Xcode.SourceCodeLanguage</string>
    <key>languageName</key>
    <string>Protocol Buffer</string>
    <key>version</key>
    <string>1.0</string>
    <key>conformsTo</key>
    <array>
      <dict>
        <key>identifier</key>
        <string>Xcode.SourceCodeLanguage.Generic</string>
      </dict>
    </array>
    <key>name</key>
    <string>Protocol Buffer</string>
  </dict>
</dict>
</plist>
EOF

# Now merge in the additonal languages to DVTFoundation.xcplugindata
#
$PLISTBUDDY "$DVTFOUNDATION_PATH/DVTFoundation.xcplugindata"  -c 'Delete :plug-in:extensions:Xcode.SourceCodeLanguage.protobuf'
$PLISTBUDDY "$DVTFOUNDATION_PATH/DVTFoundation.xcplugindata"  -c 'Merge AdditionalLanguages.plist plug-in:extensions'

# Get rid of the AdditionalLanguages.plist since it was just temporary
#
rm -f AdditionalLanguages.plist

# Copy in the xclangspecs for the languages (assumes in same directory as this shell script)
#
cp "$SCRIPT_PATH/protobuf.xclangspec" "$DVTFOUNDATION_PATH"

# Remove any cached Xcode plugins
#
rm -f /private/var/folders/*/*/*/com.apple.DeveloperTools/*/Xcode/PlugInCache.xcplugincache
