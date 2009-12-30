# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/emul-linux-x86-qtlibs/emul-linux-x86-qtlibs-20081109.ebuild,v 1.4 2009/12/30 19:50:50 pacho Exp $

EAPI="2"

inherit eutils emul-linux-x86

LICENSE="|| ( QPL-1.0 GPL-2 ) GPL-2 LGPL-2"
KEYWORDS="-* amd64"

DEPEND=""
RDEPEND="=app-emulation/emul-linux-x86-baselibs-${PV}
		=app-emulation/emul-linux-x86-soundlibs-${PV}[arts]
		=app-emulation/emul-linux-x86-xlibs-${PV}"

src_unpack() {
	emul-linux-x86_src_unpack
	NEEDED="(libDCOP.so|libkdecore.so|libkdefx.so|libqt-mt.so|libqt.so|libqui.so|libqt-mt.so.3)"
	find "${S}" -name '*.so*' | egrep -v "${NEEDED}" | xargs rm -f
}
