#!/bin/sh
# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

# store persistent-rules that got created while booting
# when / was still read-only
store_persistent_rules() {
	local file dest

	for file in /dev/.udev/tmp-rules--*; do
		dest=${file##*tmp-rules--}
		[ "$dest" = '*' ] && break
		type=${dest##70-persistent-}
		type=${type%%.rules}
		einfo "Saving udev persistent ${type} rules to /etc/udev/rules.d"
		cat "$file" >> /etc/udev/rules.d/"$dest"
		rm -f "$file"
	done
}

store_persistent_rules

# vim:ts=4
