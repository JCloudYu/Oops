#!/usr/bin/env bash

cd $(dirname "$0");
rm -rf ./dist;



for BUILD_FILE in $(find . -name "*.build" ); do
	BUILD_FILE=$(basename $BUILD_FILE);
	EXTRACT_LEN=$(( ${#BUILD_FILE} - 6 ));
	OUTPUT_FILE=${BUILD_FILE:0:$EXTRACT_LEN};


	LIST=( $(cat "${BUILD_FILE}") );



	if [ ${OUTPUT_FILE:$(( EXTRACT_LEN - 2 ))} == "js" ]; then
		mkdir -p "./dist/js";
		OUTPUT_FILE=${OUTPUT_FILE:0:$(( EXTRACT_LEN - 3 ))};
		pipethru -v ${LIST[@]} > "./dist/js/${OUTPUT_FILE}.js";
		pipethru -v ${LIST[@]} | minify --js > "./dist/js/${OUTPUT_FILE}.min.js";
	elif [ ${OUTPUT_FILE:$(( EXTRACT_LEN - 3 ))} == "css" ]; then
		mkdir -p "./dist/css";
		OUTPUT_FILE=${OUTPUT_FILE:0:$(( EXTRACT_LEN - 4 ))};
		pipethru -v ${LIST[@]} > "./dist/css/${OUTPUT_FILE}.css";
		pipethru -v ${LIST[@]} | minify --css > "./dist/css/${OUTPUT_FILE}.min.css";
	else
		mkdir -p "./dist";
		pipethru -v ${LIST[@]} > "./dist/${OUTPUT_FILE}";
	fi
done;
