# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/x11-misc/xdaf/xdaf-0.01.10.ebuild,v 1.3 2003/06/12 22:22:41 msterret Exp $

MY_P="${PN}-A.01.10"
S=${WORKDIR}/${MY_P}
DESCRIPTION="Small tool to provide visual feedback of local disks activity by changing the default X11 mouse pointer"
SRC_URI="http://ezix.sourceforge.net/software/${MY_P}.tar.gz"
HOMEPAGE="http://ezix.sourceforge.net/software/xdaf.html"
IUSE=""

DEPEND="virtual/x11"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86"

src_compile() {

	cd ${S}
	xmkmf
	emake || die
	
}

src_install () {

	make DESTDIR=${D} install || die
	dodoc COPYING README
}
