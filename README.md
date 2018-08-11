# odroid-c2-marshmallow-helper

## Overview
This project provides helper shell scripts which allow to build Android Marshmallow for the **[Odroid-C2 board](https://www.hardkernel.com/main/products/prdt_info.php?g_code=G145457216438)**  on Ubuntu 18.04 from the source provided by Hardkernel. The sequence of actions follows the **[guidelines provided for building Android image](https://wiki.odroid.com/odroid-c2/software/building_android)** for this board, but they were extended so that the build process could be successful on the chosed OS and verson.

The implemented process downloads tools and sources in the directory you cloned this repository in and uses them to allows you completing the build process in fairly isolated manner.

## Sequence of use
Assumptions:
- you have cloned this source locally ( I'm assuming in this example under **'./odroid-c2-marshmallow-helper'**) and you are inside it.
- (if necessary) you have made all **.sh** files executable (**'chmod 755 ./*.sh'**).

Suggested sequence of use for the helper scripts is:
```
user@host odroid-c2-marshmallow-helper> ./preconfigure.sh
user@host odroid-c2-marshmallow-helper> ./init-marshmallow.sh
user@host odroid-c2-marshmallow-helper> ./build-marshmallow.sh
```
## Content description

### preconfigure.sh
This script takes care of:
- downloading and extracting necessary toolchains for u-boot and kernel compilation - placed under **./toolchain** sub-folder.
- downloading, extracting and configuring standalone OpenJDK 1.7 - placed under **./openjdk7-7u171-x64** sub-folder. The source of this package comes from the Slackware package repository since it was easier to extract, configure and use it in standalone form.
- downloading and extracting the **'repo'** CLI tool - placed under **./repo** sub-folder.

### init-marshmallow.sh
This script takes care of:
- downloading the Odroid-C2 source for Android Marshmallow - placed under **./marshmallow** sub-folder. Currently this action is done using **'anonymous' identity** for Git operations. Please, change this in the script if you need to.
- applying all __*.diff__ files it finds in the root repository folder over the **./marshmallow** sub-folder. The __*.diff__ files are assumed to be produced by the **repo diff** command and appied using the **apply_repo_diff.sh** script.

### build-marshmallow.sh
This script requires for the **preconfigure.sh** and **init-marshmallow.sh** scripts to have been executed and completed sucessfully.

This script takes care of:
- setting/extending the appropriate environment variables for the build process.
- cleaning the build tree after a previous run.
- triggering the build process as described in the **[guidelines for building Android](https://wiki.odroid.com/odroid-c2/software/building_android)**. The **'make'** build is triggered explicitly with a single job CLI option (**'-j 1'**) to avoid parallel jobs, since the latter leads to failures in my environment.

### clean-marshmallow.sh
This script requires for the **preconfigure.sh** and **init-marshmallow.sh** scripts to have been executed and completed sucessfully.

This script takes care of manually cleaning the build tree after **build-marshmallow.sh** has run.

### apply_repo_diff.sh
This script provides automation for applying **.diff** files produced by the **repo diff** command. It can be invoked by:
```
apply_repo_diff.sh <absolute path to the folder with repo diff files to apply> <absolute path to the project root folder>
```
Each **.diff** file is split into pieces through the lines, containing **'project'** definitions and then these splits are applied to the Android source tree under the **./marshmallow** sub-folder.

### List of patches
- **001-force-single-threaded-make-build.diff**
- **002-fix-recovery-busybox.diff**
- **003-force-full-range-color-hdmi.diff**
