# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/camstream/camstream-0.26.2.ebuild,v 1.7 2003/11/19 11:18:30 phosphan Exp $

inherit kde-functions

DESCRIPTION="Collection of tools for webcams and other video devices"
HOMEPAGE="http://www.smcc.demon.nl/camstream/"
SRC_URI="http://www.smcc.demon.nl/camstream/download/${P}.tar.gz"
LICENSE="GPL-2"
KEYWORDS="x86"
SLOT="0"
IUSE="doc"

need-qt 3

# camstream configure script gets it wrong, sometimes

DEPEND="virtual/x11"

src_unpack() {
	unpack ${A}
	cd ${S}
	# Patch to fix an instance of a multi-line string which gcc-3.3.x dislikes greatly.
	# Closes Bug #30292
	epatch ${FILESDIR}/${P}-gcc33-multiline-string-fix.patch

	# configure script sometimes can't fund uic/moc, see bug 31940
	epatch ${FILESDIR}/uicmocpath.patch
}

src_install () {
	dobin camstream/camstream camstream/caminfo camstream/ftpput
	dodir /usr/share/${PN}/icons
	insinto /usr/share/${PN}/icons
	doins camstream/icons/*.png
	use doc && dohtml -r docs/*
}
