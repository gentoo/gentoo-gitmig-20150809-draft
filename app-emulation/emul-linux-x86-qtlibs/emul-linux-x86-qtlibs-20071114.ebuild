# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/emul-linux-x86-qtlibs/emul-linux-x86-qtlibs-20071114.ebuild,v 1.2 2007/11/24 01:23:45 kingtaco Exp $

inherit emul-linux-x86

LICENSE="|| ( QPL-1.0 GPL-2 ) GPL-2 LGPL-2"
KEYWORDS="-* amd64"

DEPEND=""
RDEPEND=">=app-emulation/emul-linux-x86-baselibs-20071114
		>=app-emulation/emul-linux-x86-soundlibs-20071114
		>=app-emulation/emul-linux-x86-xlibs-20071114"

src_unpack() {
	emul-linux-x86_src_unpack
	NEEDED="(libDCOP.so|libkdecore.so|libkdefx.so|libqt-mt.so|libqt.so|libqui.so)"
	find ${S} -name '*.so*' | egrep -v "${NEEDED}" | xargs rm -f
}
