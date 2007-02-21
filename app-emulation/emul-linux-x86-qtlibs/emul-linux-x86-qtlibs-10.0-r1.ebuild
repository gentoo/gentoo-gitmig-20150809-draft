# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/emul-linux-x86-qtlibs/emul-linux-x86-qtlibs-10.0-r1.ebuild,v 1.1 2007/02/21 09:36:35 blubb Exp $

inherit emul-libs

SRC_URI="mirror://gentoo/qt-3.3.6-r4.tbz2
		mirror://gentoo/kdelibs-3.5.5-r8.tbz2"

LICENSE="|| ( QPL-1.0 GPL-2 ) GPL-2 LGPL-2"
KEYWORDS="-* ~amd64"

DEPEND=""
RDEPEND=">=app-emulation/emul-linux-x86-baselibs-10.0
		>=app-emulation/emul-linux-x86-xlibs-7.0-r7"

src_unpack() {
	emul-libs_src_unpack
	NEEDED="(libDCOP.so|libkdecore.so|libkdefx.so|libqt-mt.so|libqt.so|libqui.so)"
	find ${S} -name '*.so*' | egrep -v "${NEEDED}" | xargs rm -f
}
