### Setup information
# Set to input file extension
in_ext=".MTS"
# Set to input folder
in_dir=~/convert/in
# Set to output folder
out_dir=~/convert/out

### Gets all files in the input directory
filelist=$(ls $in_dir)

### Start file counter at 1
var=1

### Run for each file in input folder
for filename in $filelist; do

    ### Parses the filename to establish an input file and an output file
    name_noext=$(basename $filename $in_ext)
    in_full_path="$in_dir/$filename"
    out_full_path="$out_dir/$name_noext.mp4"

    ### Prints file info
    echo "$var: $filename"
    echo "    $in_full_path"
    echo "    $out_full_path"
    echo ""

    ### Increment file counter
    var=$((var + 1))

    ### Converts the file from .MTS to .mp4
    ffmpeg -i $in_full_path -c:v copy -c:a aac -strict experimental -b:a 128k $out_full_path >/dev/null 2>&1

    ### Preserves the metadata's date modified date
    metadate=$(date -r $in_full_path +%Y%m%d%H%M.%S)
    touch $out_full_path -a -m -t $metadate

done
