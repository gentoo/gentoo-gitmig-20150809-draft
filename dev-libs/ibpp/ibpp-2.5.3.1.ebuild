# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/ibpp/ibpp-2.5.3.1.ebuild,v 1.5 2008/06/13 07:35:49 opfer Exp $

inherit eutils autotools

MY_P=${P//./-}-src

DESCRIPTION="IBPP, a C++ client API for firebird 1.0"
HOMEPAGE="http://www.ibpp.org/"
SRC_URI="mirror://sourceforge/ibpp/${MY_P}.zip"
LICENSE="MPL-1.1"
SLOT="0"
KEYWORDS="~amd64 x86"
IUSE=""

RDEPEND=">=dev-db/firebird-1.5.1"
DEPEND="${RDEPEND}
	app-arch/unzip"

S="${WORKDIR}"

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch \
		"${FILESDIR}/${P}-gentoo.patch" \
		"${FILESDIR}/${P}-missing_include.patch"

	eautoreconf
}

src_install() {
	emake DESTDIR="${D}" install || die "make install failed."
}
