#!/bin/sh

. "$UZBL_UTIL_DIR/uzbl-dir.sh"

>> "$UZBL_BOOKMARKS_FILE" || exit 1

name="$1"
jot bookmark --skip-editor --notes "$name" $UZBL_URI

# Adding to the rss feed
rss="/home/LOG1/.bookmarks_feed"
content="<item><title>$name</title><link>$UZBL_URI</link><description>$name -- $UZBL_URI</description></item>"
tmp=/tmp/uzbl_bookmark
sed -e "s~</channel>~$content\n</channel>~g" $rss > $tmp
mv $tmp $rss

# TODO remove when using inly jotmuch
line=`cat $UZBL_BOOKMARKS_FILE | grep $UZBL_URI`
[ -n "$line" ] && exit 1
echo "$UZBL_URI $name" >> "$UZBL_BOOKMARKS_FILE"

