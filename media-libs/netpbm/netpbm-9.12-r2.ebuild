# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/media-libs/netpbm/netpbm-9.12-r2.ebuild,v 1.7 2002/07/23 00:12:55 seemant Exp $

S=${WORKDIR}/${P}
DESCRIPTION="A set of utilities for converting to/from the netpbm (and related) formats"
SRC_URI="http://download.sourceforge.net/netpbm/${P}.tgz"
HOMEPAGE="http://netpbm.sourceforge.net/"

DEPEND=">=media-libs/jpeg-6b
	>=media-libs/tiff-3.5.5
	>=media-libs/libpng-1.2.1"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc"

src_unpack() {
    unpack ${A}
    cd ${S}
    cp ${FILESDIR}/${PV}/Makefile.config .
}

src_compile() {
    make || die
}

src_install () {
    make INSTALL_PREFIX="${D}/usr/" install || die
    insinto /usr/include/pbm
    doins pnm/{pam,pnm}.h ppm/{ppm,pgm,pbm}.h
    doins pbmplus.h shopt/shopt.h
    dodoc COPYRIGHT.PATENT GPL_LICENSE.txt HISTORY \
		Netpbm.programming README README.CONFOCAL README.DJGPP \
		README.JPEG README.VMS netpbm.lsm
}
