#!/bin/sh

# (cl)2019 ernierasta

# creates new directory with files for every map of given mod

# USAGE: script <PATH_TO_ORG_MOD> <PATH_TO_NEW_MOD>

ORIGINAL_MOD=$1
NEW_MOD=$2

# vars
MAP_DIR=maps

if [ -z $ORIGINAL_MOD ] || [ -z $NEW_MOD ]; then
	echo "USAGE: script <PATH_TO_ORG_MOD> <PATH_TO_NEW_MOD>"
	echo "Example: script ../../flare-game/mods/empyrean_campaign ../mods/MYMOD"
	exit 1 
fi

if [ -d "$NEW_MOD/$MAP_DIR" ]; then
	echo "Mod already exists remove $MAP_DIR or choose different name."
	exit 1
fi

for org_fp in $(find $ORIGINAL_MOD/$MAP_DIR/ -name *.txt); do
	music=$(grep 'music=' $org_fp)
	base_path=${org_fp#"$ORIGINAL_MOD/"}
	base_dir=$(dirname "$base_path")
	if [ ! -z "$music" ]; then
		mkdir -p $NEW_MOD/$base_dir
		cat << EOF > $NEW_MOD/$base_path
APPEND
# to $base_path

[header]
$music
EOF
		#echo "APPEND\n# to $base_path\n\n$music" > $NEW_MOD/$base_path 
	fi

done



