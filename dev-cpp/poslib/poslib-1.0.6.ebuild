# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-cpp/poslib/poslib-1.0.6.ebuild,v 1.9 2008/06/16 20:30:53 dev-zero Exp $

inherit flag-o-matic eutils

DESCRIPTION="A library for creating C++ programs using the Domain Name System"
HOMEPAGE="http://posadis.sourceforge.net/"
SRC_URI="mirror://sourceforge/posadis/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE="ipv6"

DEPEND=""
RDEPEND=""

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${PV}-missing_includes.patch"
}

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
