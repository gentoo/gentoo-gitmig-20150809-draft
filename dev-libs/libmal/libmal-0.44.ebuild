# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libmal/libmal-0.44.ebuild,v 1.2 2007/09/18 05:04:54 philantrop Exp $

DESCRIPTION="convenience library of the functions malsync distribution"
HOMEPAGE="http://jasonday.home.att.net/code/libmal/libmal.html"
SRC_URI="http://jasonday.home.att.net/code/libmal/${P}.tar.gz"

LICENSE="MPL-1.0"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~sparc ~x86"
IUSE=""

DEPEND=">=app-pda/pilot-link-0.12.2"

src_install () {
	make DESTDIR="${D}" install || die "make failed"
	dodoc AUTHORS ChangeLog INSTALL COPYING NEWS README TODO || die "installing docs failed"
}
