# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/xdaf/xdaf-0.01.10.ebuild,v 1.6 2004/01/26 17:03:03 pyrania Exp $

MY_P="${PN}-A.01.10"
S=${WORKDIR}/${MY_P}
DESCRIPTION="Small tool to provide visual feedback of local disks activity by changing the default X11 mouse pointer"
SRC_URI="mirror://sourceforge/ezix/${MY_P}.tar.gz"
HOMEPAGE="http://ezix.sourceforge.net/software/xdaf.html"
IUSE=""

DEPEND="virtual/x11"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

src_compile() {

	cd ${S}
	xmkmf
	emake || die

}

src_install () {

	make DESTDIR=${D} install || die
	dodoc COPYING README
}
