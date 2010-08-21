# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libmal/libmal-0.44.1.ebuild,v 1.4 2010/08/21 14:15:40 tomjbe Exp $

EAPI=2

DESCRIPTION="convenience library of the functions malsync distribution"
HOMEPAGE="http://www.jlogday.com/code/libmal/index.html"
SRC_URI="http://www.jlogday.com/code/libmal/${P}.tar.gz"

LICENSE="MPL-1.0"
SLOT="0"
KEYWORDS="~alpha amd64 ~hppa ~ia64 ~ppc ppc64 ~sparc ~x86"
IUSE="static-libs"

DEPEND=">=app-pda/pilot-link-0.12.3"

src_configure() {
	econf \
		--disable-dependency-tracking \
		$(use_enable static-libs static)
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc ChangeLog README || die

	docinto malsync
	dodoc malsync/{ChangeLog,README,Doc/README*} || die

	find "${D}" -name '*.la' -delete
}
