# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/camstream/camstream-0.26.2.ebuild,v 1.6 2003/11/14 09:14:18 phosphan Exp $

DESCRIPTION="Collection of tools for webcams and other video devices"
HOMEPAGE="http://www.smcc.demon.nl/camstream/"
SRC_URI="http://www.smcc.demon.nl/camstream/download/${P}.tar.gz"
LICENSE="GPL-2"
KEYWORDS="x86"
SLOT="0"
IUSE="doc"

DEPEND="virtual/x11
	virtual/glibc
	>=x11-libs/qt-2.2.2*
	"

src_unpack() {
	unpack ${A}

	# Patch to fix an instance of a multi-line string which gcc-3.3.x dislikes greatly.
	# Closes Bug #30292
	epatch ${FILESDIR}/${P}-gcc33-multiline-string-fix.patch
}

src_install () {
	dobin camstream/camstream camstream/caminfo camstream/ftpput
	dodir /usr/share/${PN}/icons
	insinto /usr/share/${PN}/icons
	doins camstream/icons/*.png
	use doc && dohtml -r docs/*
}
