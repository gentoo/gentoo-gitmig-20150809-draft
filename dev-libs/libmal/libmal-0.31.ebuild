# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libmal/libmal-0.31.ebuild,v 1.12 2004/10/19 18:20:16 vapier Exp $

DESCRIPTION="convenience library of the functions malsync distribution"
HOMEPAGE="http://jasonday.home.att.net/code/libmal/libmal.html"
SRC_URI="http://jasonday.home.att.net/code/libmal/${P}.tar.gz"

LICENSE="MPL-1.0"
SLOT="0"
KEYWORDS="amd64 ia64 ppc sparc x86"
IUSE=""

DEPEND="virtual/libc
	>=app-pda/pilot-link-0.11.7-r1"

src_install () {
	make DESTDIR=${D} install || die
	dodoc AUTHORS ChangeLog INSTALL License.txt NEWS README
}
