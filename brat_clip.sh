TMP_FILE='_TMP_crop.pdf'
FNAME=$1
OUT=`echo $FNAME | awk -F '.' '{print($1)}'`'-crop.pdf'
pdfcrop --margins "0 -30 0 0" $FNAME $TMP_FILE
pdfcrop $TMP_FILE $OUT
rm $TMP_FILE
