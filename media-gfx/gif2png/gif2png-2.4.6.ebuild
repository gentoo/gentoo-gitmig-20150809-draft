# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/gif2png/gif2png-2.4.6.ebuild,v 1.1 2003/03/16 21:39:10 malverian Exp $

IUSE=""

S=${WORKDIR}/${P}
DESCRIPTION="gif2png"
SRC_URI="http://www.ibiblio.org/pub/Linux/apps/graphics/convert/${PN}-${PV}.tar.gz"
HOMEPAGE="http://www.tuxedo.org/~esr/gif2png/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc"

DEPEND="media-libs/libpng"
RDEPEND=${DEPEND}

src_compile() {
	econf --prefix=/usr || die "econf failed"
	emake || die "emake failed"
}


src_install() {
	dodir ${D}/usr/bin
	make \
		DESTDIR=${D} \
		install || die "make install failed"
}

