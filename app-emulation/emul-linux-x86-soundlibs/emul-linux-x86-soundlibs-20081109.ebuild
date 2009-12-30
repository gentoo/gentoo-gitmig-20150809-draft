# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/emul-linux-x86-soundlibs/emul-linux-x86-soundlibs-20081109.ebuild,v 1.5 2009/12/30 19:52:47 pacho Exp $

EAPI=1
inherit emul-linux-x86

LICENSE="as-is BSD GPL-2 LGPL-2 LGPL-2.1 Adobe-SourceCode"
KEYWORDS="-* amd64"
IUSE="+arts esd alsa"

RDEPEND="=app-emulation/emul-linux-x86-baselibs-${PV}
		=app-emulation/emul-linux-x86-medialibs-${PV}
		=app-emulation/emul-linux-x86-xlibs-${PV}"

QA_DT_HASH="usr/lib32/.*"

src_unpack() {
	_ALLOWED="${S}/etc/env.d"

	if use alsa; then
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

	mv -f "${S}"/usr/bin/aoss{,32}
	mv -f "${S}"/usr/kde/3.5/bin/artsdsp{,32}
	mv -f "${S}"/usr/bin/esddsp{,32}

	if ! use arts; then
		rm -rf "${S}"/usr/kde/
	fi
}
