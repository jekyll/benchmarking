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

POST_DATE=$(date +%Y-%m-%d)
export POST_CONTENT=`cat <<EOF

Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce bibendum neque
eget nunc mattis eu sollicitudin enim tincidunt. Vestibulum lacus tortor,
ultricies id dignissim ac, bibendum in velit.

## Some great heading (h2)

Proin convallis mi ac felis pharetra aliquam. Curabitur dignissim accumsan
rutrum. In arcu magna, aliquet vel pretium et, molestie et arcu.

Mauris lobortis nulla et felis ullamcorper bibendum. Phasellus et hendrerit
mauris. Proin eget nibh a massa [vestibulum pretium][ref]. Suspendisse eu nisl a ante
aliquet bibendum quis a nunc. Praesent varius interdum vehicula. Aenean risus
libero, placerat at vestibulum eget, ultricies eu enim. Praesent nulla tortor,
malesuada adipiscing adipiscing sollicitudin, adipiscing eget est.

## Another great heading (h2)

Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce bibendum neque
eget nunc mattis eu sollicitudin enim tincidunt. Vestibulum lacus tortor,
ultricies id dignissim ac, bibendum in velit.

### Some great subheading (h3)

Proin convallis mi ac felis pharetra aliquam. Curabitur dignissim accumsan
rutrum. In arcu magna, aliquet vel pretium et, molestie et arcu. Mauris lobortis
nulla et felis ullamcorper bibendum.

Phasellus et hendrerit mauris. Proin eget nibh a massa vestibulum pretium.
Suspendisse eu nisl a ante aliquet bibendum quis a nunc.

### Some great subheading (h3)

Praesent varius interdum vehicula. Aenean risus libero, placerat at vestibulum
eget, ultricies eu enim. Praesent nulla tortor, malesuada adipiscing adipiscing
sollicitudin, adipiscing eget est.

> This quote will change your life. It will reveal the secrets of the universe,
and all the wonders of humanity. Don't misuse it.

Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce bibendum neque
eget nunc mattis eu sollicitudin enim tincidunt.

### Some great subheading (h3)

Vestibulum lacus tortor, ultricies id dignissim ac, bibendum in velit. Proin
convallis mi ac felis pharetra aliquam. Curabitur dignissim accumsan rutrum.

{% highlight ruby %}
def foo
  puts 'foo'
end
{% endhighlight %}

In arcu magna, aliquet vel pretium et, molestie et arcu. Mauris lobortis nulla
et felis ullamcorper bibendum. Phasellus et hendrerit mauris.

#### You might want a sub-subheading (h4)

In arcu magna, aliquet vel pretium et, molestie et arcu. Mauris lobortis nulla
et felis ullamcorper bibendum. Phasellus et hendrerit mauris.

In arcu magna, aliquet vel pretium et, molestie et arcu. Mauris lobortis nulla
et felis ullamcorper bibendum. Phasellus et hendrerit mauris.

#### But it's probably overkill (h4)

In arcu magna, aliquet vel pretium et, molestie et arcu. Mauris lobortis nulla
et felis ullamcorper bibendum. Phasellus et hendrerit mauris.

### Oh hai, an unordered list!!

In arcu magna, aliquet vel pretium et, molestie et arcu. Mauris lobortis nulla
et felis ullamcorper bibendum. Phasellus et hendrerit mauris.
- First item, yo
- Second item, dawg
- Third item, what what?!
- Fourth item, fo sheezy my neezy

### Oh hai, an ordered list!!

In arcu magna, aliquet vel pretium et, molestie et arcu. Mauris lobortis nulla et felis ullamcorper bibendum. Phasellus et hendrerit mauris.

1. First item, yo
2. Second item, dawg
3. Third item, what what?!
4. Fourth item, fo sheezy my neezy

Quisque a molestie urna. [Vestibulum ante][ref] ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Nulla velit velit, luctus ut nisi a, porta consequat tellus. Fusce finibus massa in arcu rhoncus, vel suscipit nisl cursus. Nunc sodales ligula sed ante dapibus tincidunt. Nunc vestibulum mattis urna, sodales tristique lorem imperdiet vel. Curabitur euismod dignissim aliquet. Fusce non feugiat justo, vel bibendum sem. Curabitur dictum, massa eget cursus mattis, augue libero tincidunt sem, eget laoreet magna enim ut arcu.

[ref]: https://jekyllrb.com

EOF`

POST_DIR=${SITE_DIR}/_posts
mkdir -p $POST_DIR

cat >${SITE_DIR}/_config.yml << EOF
url: https://example.com
baseurl: /baseURL
theme: minima
EOF

cat >${SITE_DIR}/Gemfile << EOF
gem "jekyll", git: "https://github.com/jekyll/jekyll"
gem "minima"
EOF

cat >${SITE_DIR}/index.html << EOF
---
layout: home
title: Jekyll Test Site
---

EOF

for (( post_number = 1; post_number <= POST_COUNT; ++post_number ))
do
    post_file="$POST_DATE-test_post_$post_number"
    cat >$POST_DIR/$post_file.md << EOF
---
layout: post
title: Testing Post $post_number
---

$POST_CONTENT
EOF

done
