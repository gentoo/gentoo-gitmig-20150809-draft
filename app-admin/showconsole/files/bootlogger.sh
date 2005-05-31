# /lib/rcscripts/addons/bootlogger.sh:  Handle logging of output at boot
# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/showconsole/files/bootlogger.sh,v 1.1 2005/05/31 22:54:29 vapier Exp $

if [[ -x /sbin/blogd ]] ; then

bootlog() {
	local opt=$1
	shift
	case ${opt} in
	start) blogd_start "$@";;
	sync)  blogd_sync "$@";;
	quit)  blogd_quit "$@";;
	esac
}

blogd_start() {
	/sbin/blogd >/dev/null
}

blogd_sync() {
	echo > /var/log/boot.msg
	killall -IO blogd
}

blogd_quit() {
	killall -QUIT blogd
}

fi
