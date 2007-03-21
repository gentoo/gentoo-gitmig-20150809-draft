# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-chemistry/bodr/bodr-6.ebuild,v 1.2 2007/03/21 15:25:21 cryos Exp $

DESCRIPTION="The Blue Obelisk Data Repository listing element and isotope
properties."
HOMEPAGE="http://wiki.cubic.uni-koeln.de/bowiki/index.php/DataRepository"
SRC_URI="mirror://sourceforge/bodr/${P}.tar.bz2"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=">=dev-libs/libxslt-1.1.20"
RDEPEND=""

src_compile() {
	aclocal || die "aclocal failed"
	automake --gnu -a || die "automake failed"
	autoconf || die "autoconf failed"

	econf || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	make install DESTDIR=${D} || die "make install failed"
	mv ${D}/usr/share/doc/${PN} ${D}/usr/share/doc/${PF}
	rm ${D}/usr/share/doc/${PF}/COPYING
}
