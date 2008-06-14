# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-chemistry/bodr/bodr-6.ebuild,v 1.5 2008/06/14 17:05:33 mr_bones_ Exp $

inherit eutils

DESCRIPTION="The Blue Obelisk Data Repository listing element and isotope properties."
HOMEPAGE="http://sourceforge.net/projects/bodr"
SRC_URI="mirror://sourceforge/bodr/${P}.tar.bz2"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=dev-libs/libxslt-1.1.20"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/bodr-6-install.patch
}

src_install() {
	make install DESTDIR="${D}" || die "make install failed"
}
