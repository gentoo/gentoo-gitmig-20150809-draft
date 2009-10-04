# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/emul-linux-x86-qtlibs/emul-linux-x86-qtlibs-20091004_rc1.ebuild,v 1.1 2009/10/04 17:59:06 kingtaco Exp $

EAPI="2"

inherit eutils emul-linux-x86

LICENSE="|| ( QPL-1.0 GPL-2 ) GPL-2 LGPL-2"
KEYWORDS="-* ~amd64"

DEPEND=""
RDEPEND=">=app-emulation/emul-linux-x86-baselibs-20091004_rc1
	>=app-emulation/emul-linux-x86-soundlibs-20091004_rc1[arts]
	>=app-emulation/emul-linux-x86-xlibs-20091004_rc1"

src_unpack() {
	emul-linux-x86_src_unpack
	NEEDED="(libDCOP.so|libkdecore.so|libkdefx.so|libqt-mt.so|libqt.so|libqui.so|libqt-mt.so.3)"
	find "${S}" -name '*.so*' | egrep -v "${NEEDED}" | xargs rm -f
}
