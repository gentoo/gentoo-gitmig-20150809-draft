# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/netpbm/netpbm-9.12-r3.ebuild,v 1.2 2002/10/04 05:49:45 vapier Exp $

S=${WORKDIR}/${P}
DESCRIPTION="A set of utilities for converting to/from the netpbm (and related) formats"
SRC_URI="http://download.sourceforge.net/netpbm/${P}.tgz"
HOMEPAGE="http://netpbm.sourceforge.net/"

DEPEND=">=media-libs/jpeg-6b
	>=media-libs/tiff-3.5.5
	>=media-libs/libpng-1.2.1"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc sparc sparc64"

src_unpack() {
	unpack ${A}
	cd ${S}
	sed <${FILESDIR}/${PV}/Makefile.config >Makefile.config \
		-e "s|-O3|${CFLAGS}|"
}

src_compile() {
	make || die
}

src_install () {
	make INSTALL_PREFIX="${D}/usr/" install || die
	insinto /usr/include
	doins pnm/{pam,pnm}.h ppm/{ppm,pgm,pbm}.h
	doins pbmplus.h shhopt/shhopt.h
	dodoc COPYRIGHT.PATENT GPL_LICENSE.txt HISTORY \
		Netpbm.programming README* netpbm.lsm
}
