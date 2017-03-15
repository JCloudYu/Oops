#!/usr/bin/env bash

cd $(dirname "$0");
rm -rf ./dist;
mkdir ./dist;



for BUILD_FILE in $(find . -name "*.build" ); do
	BUILD_FILE=$(basename $BUILD_FILE);
	EXTRACT_LEN=$(( ${#BUILD_FILE} - 6 ));
	OUTPUT_FILE=${BUILD_FILE:0:$EXTRACT_LEN};


	LIST=( $(cat "${BUILD_FILE}") );



	if [ ${OUTPUT_FILE:$(( EXTRACT_LEN - 2 ))} == "js" ]; then
		OUTPUT_FILE=${OUTPUT_FILE:0:$(( EXTRACT_LEN - 3 ))};
		pipethru -v ${LIST[@]} > "./dist/${OUTPUT_FILE}.js";
		pipethru -v ${LIST[@]} | minify --js > "./dist/${OUTPUT_FILE}.min.js";
	elif [ ${OUTPUT_FILE:$(( EXTRACT_LEN - 3 ))} == "css" ]; then
		OUTPUT_FILE=${OUTPUT_FILE:0:$(( EXTRACT_LEN - 4 ))};
		echo \"${LIST[@]}\"
		pipethru -v ${LIST[@]} > "./dist/${OUTPUT_FILE}.css";
		pipethru -v ${LIST[@]} | minify --css > "./dist/${OUTPUT_FILE}.min.css";
	else
		pipethru -v ${LIST[@]} > "./dist/${OUTPUT_FILE}";
	fi
done;
