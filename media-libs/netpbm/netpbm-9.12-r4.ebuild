# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/netpbm/netpbm-9.12-r4.ebuild,v 1.6 2003/04/17 16:42:53 lostlogic Exp $

S=${WORKDIR}/${P}
DESCRIPTION="A set of utilities for converting to/from the netpbm (and related) formats"
SRC_URI="mirror://sourceforge/${PN}/${P}.tgz"
HOMEPAGE="http://netpbm.sourceforge.net/"

DEPEND=">=media-libs/jpeg-6b
	>=media-libs/tiff-3.5.5
	>=media-libs/libpng-1.2.1"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc sparc "

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -e "s:-O3:${CFLAGS}" ${FILESDIR}/${PV}/Makefile.config >Makefile.config
}

src_compile() {
	MAKEOPTS="${MAKEOPTS} -j1"
	emake CC="${CC}" CXX="${CXX}"|| die "Make failed"
}

src_install () {
	make INSTALL_PREFIX="${D}/usr/" install || die "Install failed"
	
	# fix broken symlinks
	dosym /usr/bin/gemtopnm /usr/bin/gemtopbm
	dosym /usr/bin/pnmtoplainpnm /usr/bin/pnmnoraw
	
	insinto /usr/include
	doins pnm/{pam,pnm}.h ppm/{ppm,pgm,pbm}.h
	doins pbmplus.h shhopt/shhopt.h
	dodoc COPYRIGHT.PATENT GPL_LICENSE.txt HISTORY \
		Netpbm.programming README* netpbm.lsm
}
