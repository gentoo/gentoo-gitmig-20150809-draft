# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libots/libots-2.2.7-r2.ebuild,v 1.5 2004/07/14 14:45:13 agriffis Exp $

inherit eutils rpm

At="libots-2.2.7-2.alpha.rpm"
HOMEPAGE="http://www.support.compaq.com/alpha-tools/"
DESCRIPTION="Compaq Linux optimized runtime for Alpha/Linux/GNU"
SRC_URI="ftp://ftp.compaq.com/pub/products/linuxdevtools/latest/${At}"

DEPEND="virtual/libc"
LICENSE="compaq-sdla"
SLOT="2.2.7"
KEYWORDS="-* alpha"
IUSE=""

S=${WORKDIR}/usr/lib/compaq/libots-2.2.7

RESTRICT="nostrip"

src_unpack() {
	rpm_src_unpack
}

src_install () {
	into /
	dolib.so libots.so
	dolib.a libots.a

	dodoc README
}
