# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-cpp/poslib/poslib-1.0.6.ebuild,v 1.8 2008/04/04 01:19:21 halcy0n Exp $

inherit flag-o-matic

DESCRIPTION="A library for creating C++ programs using the Domain Name System"
HOMEPAGE="http://posadis.sourceforge.net/"
SRC_URI="mirror://sourceforge/posadis/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
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
	make DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog INSTALL NEWS README TODO
}
