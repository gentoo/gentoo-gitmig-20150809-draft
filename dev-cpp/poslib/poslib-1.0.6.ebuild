# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-cpp/poslib/poslib-1.0.6.ebuild,v 1.6 2006/10/21 10:55:53 dertobi123 Exp $

inherit flag-o-matic

DESCRIPTION="A library for creating C++ programs using the Domain Name System"
HOMEPAGE="http://www.posadis.org/poslib"
SRC_URI="mirror://sourceforge/posadis/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ppc x86"
IUSE="ipv6"

DEPEND=""

src_compile() {
	append-flags -funsigned-char

	econf \
		--with-cxxflags="${CXXFLAGS}" \
		`use_enable ipv6` || die
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS ChangeLog INSTALL NEWS README TODO
}
