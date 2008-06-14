# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-chemistry/bodr/bodr-8.ebuild,v 1.1 2008/06/14 14:24:28 markusle Exp $

DESCRIPTION="The Blue Obelisk Data Repository listing element and isotope properties."
HOMEPAGE="http://sourceforge.net/projects/bodr"
SRC_URI="mirror://sourceforge/bodr/${P}.tar.bz2"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=dev-libs/libxslt-1.1.20"

src_compile() {
	econf --docdir="/usr/share/doc/${P}" || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	make install DESTDIR="${D}" || die "make install failed"
}
