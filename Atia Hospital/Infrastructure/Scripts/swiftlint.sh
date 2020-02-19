#!/bin/sh

#  swiftlint.sh
#  Atia Hospital
#
#  Created by Kerim Njuhovic on 10/02/2020.
#  Copyright © 2020 Kerim Njuhovic. All rights reserved.

# *****************************************
# ** SwiftLint tool to force code styles **
# *****************************************

if which swiftlint >/dev/null; then
    swiftlint lint --config $SRCROOT/${TARGET_NAME}/Infrastructure/Configuration/Swiftlint/.swiftlint.yml
else
    echo "warning: SwiftLint not installed, download from https://github.com/realm/SwiftLint"
fi
