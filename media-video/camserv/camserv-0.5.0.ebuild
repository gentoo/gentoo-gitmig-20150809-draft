# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/media-video/camserv/camserv-0.5.0.ebuild,v 1.5 2002/09/17 22:24:17 raker Exp $

S=${WORKDIR}/${P}
DESCRIPTION="A streaming video server."
SRC_URI="http://cserv.sourceforge.net/current/${P}.tar.gz"
HOMEPAGE="http://cserv.sourceforge.net/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

DEPEND=">=media-libs/jpeg-6b-r2
	>=media-libs/imlib-1.9.13-r2"
RDEPEND="${DEPEND}"

src_compile() {

	econf || die
	emake || die

}

src_install () {

	einstall datadir=${D}/usr/share/${PN} || die

	dodoc AUTHORS BUGS ChangeLog COPYING NEWS README TODO javascript.txt
	dohtml defpage.html

}
