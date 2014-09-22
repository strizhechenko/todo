#!/bin/bash

headers() {
	grep '^# ' /var/www/index.md
}

main() {
	cat /var/www/static/header.html
	cat /var/www/static/body.html

	headcount=0
	while read line; do
		echo "<li><a href='#_page_$((headcount++))'>${line###}</a></li>"
	done <<< "$(headers)"

	cat /var/www/static/body2.html

	headcount=0
	while read line; do
		echo "<div class="frame" id='_page_$((headcount++))'>"
		grep -A 10000 "^$line$"  /var/www/index.md | egrep -m 2 -B 10000 "^#" | head -n -2 | tail -n +3 | markdown
		echo "</div>"
	done <<< "$(headers)"

	cat /var/www/static/body3.html
}

main > /var/www/index.html
