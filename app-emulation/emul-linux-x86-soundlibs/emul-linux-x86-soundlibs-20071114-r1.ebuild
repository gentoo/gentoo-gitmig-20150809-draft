# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/emul-linux-x86-soundlibs/emul-linux-x86-soundlibs-20071114-r1.ebuild,v 1.1 2007/11/24 19:47:04 kingtaco Exp $

inherit emul-linux-x86

LICENSE="as-is BSD GPL-2 LGPL-2 LGPL-2.1"
KEYWORDS="-* ~amd64"
IUSE="arts esd oss"

RDEPEND=">=app-emulation/emul-linux-x86-baselibs-20071114
		arts? ( >=app-emulation/emul-linux-x86-qtlibs-20071114 )
		>=app-emulation/emul-linux-x86-medialibs-20071114
		>=app-emulation/emul-linux-x86-xlibs-20071114"

src_unpack() {
	_ALLOWED="${S}/etc/env.d"

	if use oss; then
		_ALLOWED="${_ALLOWED}|${S}/usr/bin/aoss"
	fi

	if use esd; then
		_ALLOWED="${_ALLOWED}|${S}/usr/bin/esddsp"
	fi

	if use arts; then
		_ALLOWED="${_ALLOWED}|${S}/usr/kde/.*/bin/artsdsp"
	fi
	ALLOWED="(${_ALLOWED})"

	emul-linux-x86_src_unpack

	mv -f ${S}/usr/bin/aoss{,32}
	mv -f ${S}/usr/kde/*/bin/artsdsp{,32}
	mv -f ${S}/usr/bin/esddsp{,32}

	if ! use arts; then
		rm -rf ${S}/usr/kde/
	fi
}
