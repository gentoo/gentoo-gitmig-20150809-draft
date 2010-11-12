# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libots/libots-2.2.7-r2.ebuild,v 1.8 2010/11/12 03:35:15 mattst88 Exp $

inherit rpm toolchain-funcs

DESCRIPTION="Compaq's Optimized Runtime Library for the Alpha Platform"
HOMEPAGE="ftp://ftp.compaq.com/pub/products/C-CXX/linux/"
SRC_URI="ftp://ftp.compaq.com/pub/products/C-CXX/linux/libots-2.2.7-2.alpha.rpm"

LICENSE="compaq-sdla"
SLOT="0"
KEYWORDS="-* alpha"
IUSE=""
RESTRICT="strip"

DEPEND=""
RDEPEND=""

S=${WORKDIR}/usr/lib/compaq/libots-2.2.7

src_install() {
	dolib.a ${PN}.a
	dodoc README
	into /
	dolib.so ${PN}.so
	gen_usr_ldscript ${PN}.so
}
