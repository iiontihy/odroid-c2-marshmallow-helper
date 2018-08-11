#!/bin/bash

## Script to patch up diff reated by `repo diff`
## based on https://groups.google.com/forum/#!topic/repo-discuss/43juvD1qGIQ

if [ -z "$1" ] || [ ! -e "$1" ]; then
    echo "Usages: $0 <absolute path to the folder with repo diff files to apply> <absolute path to the project root folder>";
    exit 0;
fi

rm -fr _tmp_splits*

for each_diff in `ls $1/*.diff`
do
	name=$(basename "$each_diff" ".php")
    cat $each_diff | csplit -qzf '' -b "_tmp_splits.$name.%d.diff" - '/\n+^project.*\/$/' '{*}'
done

working_dir=`pwd`
                                
for proj_diff in `ls _tmp_splits.*.diff`
do
    chg_dir=$2/`cat $proj_diff | grep '^project.*\/$' | cut -d " " -f 2`
    echo "FILE: $proj_diff $chg_dir"
    if [ -e $chg_dir ]; then
        ( cd $chg_dir; \
            cat $working_dir/$proj_diff | grep -v '^project.*\/$' | patch -Np1;);
    else
        echo "$0: Project directory $chg_dir don't exists.";
    fi
done