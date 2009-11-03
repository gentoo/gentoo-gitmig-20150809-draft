# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/emul-linux-x86-qtlibs/emul-linux-x86-qtlibs-20081109.ebuild,v 1.3 2009/11/03 21:13:16 ssuominen Exp $

EAPI="2"

inherit eutils emul-linux-x86

LICENSE="|| ( QPL-1.0 GPL-2 ) GPL-2 LGPL-2"
KEYWORDS="-* amd64"

DEPEND=""
RDEPEND=">=app-emulation/emul-linux-x86-baselibs-20081109
		>=app-emulation/emul-linux-x86-soundlibs-20081109[arts]
		>=app-emulation/emul-linux-x86-xlibs-20081109"

src_unpack() {
	emul-linux-x86_src_unpack
	NEEDED="(libDCOP.so|libkdecore.so|libkdefx.so|libqt-mt.so|libqt.so|libqui.so|libqt-mt.so.3)"
	find "${S}" -name '*.so*' | egrep -v "${NEEDED}" | xargs rm -f
}
