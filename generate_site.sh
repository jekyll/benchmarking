#!/bin/bash
function die()
{
    echo $@
    exit 1
}

if (( $# != 2 ))
then
  echo "Usage: $0 [Number of posts] [Output directory]"
  die "Not enough arguments"
fi

POST_COUNT=$1
SITE_DIR=$2

POST_CONTENT=$(< template/post.md)

POST_DIR=${SITE_DIR}/_posts
mkdir -p $POST_DIR

cp template/_config.yml ${SITE_DIR}/_config.yml
cp template/Gemfile ${SITE_DIR}/Gemfile
cp template/index.html ${SITE_DIR}/index.html

for (( post_number = 1; post_number <= POST_COUNT; ++post_number ))
do
    export POST_NUMBER=$post_number
    post_date=`date +%Y-%m-%d`
    post_file="$post_date-test_post_$post_number"
    cat >$POST_DIR/$post_file.md << EOF
---
layout: post
title: Testing Post $POST_NUMBER
---

$POST_CONTENT
EOF

done
