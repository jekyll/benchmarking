#!/bin/sh
function die()
{
    echo $@
    exit 1
}

[[ $# -ne 2 ]] && die "Not enough arguments"
POST_COUNT=$1
SITE_DIR=$2
export POST_CONTENT=`cat <<EOF
Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed lorem leo, lacinia id consequat sit amet, interdum nec erat. Suspendisse dapibus tristique libero ac tincidunt. Interdum et malesuada fames ac ante ipsum primis in faucibus. Duis est sapien, gravida et lobortis ac, pharetra sit amet diam. Vivamus at sapien a mauris consequat interdum at pharetra sem. Phasellus ultricies, nisi a mattis ornare, odio metus auctor velit, ac aliquam ante ipsum id sem. Nullam sodales tortor commodo purus bibendum pharetra.

Quisque a molestie urna. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Nulla velit velit, luctus ut nisi a, porta consequat tellus. Fusce finibus massa in arcu rhoncus, vel suscipit nisl cursus. Nunc sodales ligula sed ante dapibus tincidunt. Nunc vestibulum mattis urna, sodales tristique lorem imperdiet vel. Curabitur euismod dignissim aliquet. Fusce non feugiat justo, vel bibendum sem. Curabitur dictum, massa eget cursus mattis, augue libero tincidunt sem, eget laoreet magna enim ut arcu.
EOF`

POST_DIR=${SITE_DIR}/_posts
LAYOUT_DIR=${SITE_DIR}/_layouts
mkdir -p $POST_DIR
mkdir -p $LAYOUT_DIR

cp ./default_layout.html $LAYOUT_DIR/default.html
cp ./post_layout.html $LAYOUT_DIR/post.html

cat >${SITE_DIR}/_config.yml << EOF
markdown: redcarpet
EOF

cat >${SITE_DIR}/index.html << EOF
---
layout: default
title: Jekyll Test Site
---
<h1>Blog Posts</h1>
<ul class="posts">
    {% for post in site.posts %}
    <li><span>{{ post.date | date_to_string }}</span> &raquo; <a href="{{ post.url }}">{{ post.title }}</a></li>
    {% endfor %}
</ul>
EOF

for (( post_number = 1; post_number <= POST_COUNT; ++post_number )); do
do
    export POST_NUMBER=$post_number
    post_date=`date +%Y-%m-%d`
    post_file="$post_date-test_post_$post_number"
    cat >$POST_DIR/$post_file.md << EOF
---
title: Testing Post $POST_NUMBER
---

$POST_CONTENT
EOF

done

