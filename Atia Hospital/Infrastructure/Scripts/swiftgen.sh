#!/bin/sh

#  swiftgen.sh
#  Atia Hospital
#
#  Created by Kerim Njuhovic on 10/02/2020.
#  Copyright © 2020 Kerim Njuhovic. All rights reserved.

# ******************************************
# ** Swift Gen tool used to generate code **
# *** from assets and *.storyboard files ***
# ******************************************


# ------------------------------------
# Generating enum from asset catlogue
# Uncomment script to update the UIImage+Assets.swift file with new items.
# ------------------------------------

if which swiftgen >/dev/null; then
    swiftgen xcassets -t swift4 "${SRCROOT}/${TARGET_NAME}/Resources/Assets.xcassets" --output "${TARGET_NAME}/Infrastructure/Extensions/UIKit/UIImage+Assets.swift"
else
    echo "warning: SwiftGen not installed"
fi

# ---------------------------------------
# Generating enum from *.storyboard files
# ---------------------------------------

if which swiftgen >/dev/null; then
    swiftgen storyboards -t scenes-swift4 "${SRCROOT}/${TARGET_NAME}" --output "${TARGET_NAME}/Infrastructure/Extensions/UIKit/UIStoryboard+UIViewController.swift"
else
    echo "warning: SwiftGen not installed"
fi
