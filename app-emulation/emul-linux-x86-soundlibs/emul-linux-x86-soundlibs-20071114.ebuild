# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/emul-linux-x86-soundlibs/emul-linux-x86-soundlibs-20071114.ebuild,v 1.4 2007/11/24 01:27:24 kingtaco Exp $

inherit emul-linux-x86

LICENSE="as-is BSD GPL-2 LGPL-2 LGPL-2.1"
KEYWORDS="-* amd64"
IUSE="arts"

RDEPEND=">=app-emulation/emul-linux-x86-baselibs-20071114
		arts? ( >=app-emulation/emul-linux-x86-qtlibs-20071114 )
		>=app-emulation/emul-linux-x86-medialibs-20071114
		>=app-emulation/emul-linux-x86-xlibs-20071114"

src_unpack() {
	if use arts; then
		ALLOWED="(${S}/etc/env.d|${S}/usr/bin/esddsp|${S}/usr/kde/.*/bin/artsdsp|${S}/usr/bin/aoss)"
	else
		ALLOWED="(${S}/etc/env.d)"
	fi
	emul-linux-x86_src_unpack

	if use arts; then
		for f in ${S}/usr/bin/esddsp ${S}/usr/bin/aoss ${S}/usr/kde/*/bin/artsdsp ; do
			mv -f "$f"{,32}
		done
	fi
}
