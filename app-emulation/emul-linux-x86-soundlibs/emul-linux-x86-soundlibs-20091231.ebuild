# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/emul-linux-x86-soundlibs/emul-linux-x86-soundlibs-20091231.ebuild,v 1.1 2009/12/31 12:07:57 pacho Exp $

EAPI=1
inherit emul-linux-x86

LICENSE="as-is BSD GPL-2 LGPL-2 LGPL-2.1 gsm"
KEYWORDS="-* ~amd64"
IUSE="alsa"

RDEPEND="~app-emulation/emul-linux-x86-baselibs-${PV}
	~app-emulation/emul-linux-x86-medialibs-${PV}"

QA_DT_HASH="usr/lib32/.*"

src_unpack() {
	_ALLOWED="${S}/etc/env.d"

	if use alsa; then
		_ALLOWED="${_ALLOWED}|${S}/usr/bin/aoss"
	fi

	ALLOWED="(${_ALLOWED})"

	emul-linux-x86_src_unpack

	mv -f "${S}"/usr/bin/aoss{,32} || die
}
