# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/sucs/sucs-1.0.0.ebuild,v 1.5 2007/12/18 19:57:56 dev-zero Exp $

inherit eutils

DESCRIPTION="The Simple Utility Classes are C++ libraries of common C-based algorithms and libraries"
HOMEPAGE="http://sucs.sourceforge.net/"
SRC_URI="mirror://sourceforge/sucs/${P}.tar.bz2"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="x86 ~amd64"
IUSE=""

DEPEND=">=dev-libs/libpcre-3.9
	>=dev-libs/expat-1.95.4"
RDEPEND="${DEPEND}"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${P}-various_fixes.diff"
}

src_install() {
	emake DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS ChangeLog README
}
