# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libcdio/libcdio-0.69.ebuild,v 1.9 2004/12/11 14:39:06 kloeri Exp $

DESCRIPTION="A library to encapsulate CD-ROM reading and control"
HOMEPAGE="http://www.gnu.org/software/libcdio/"
SRC_URI="mirror://gnu/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 ~ia64 ~ppc ~ppc64 sparc x86"
IUSE="cddb"

DEPEND="dev-util/pkgconfig
	dev-libs/popt
	cddb? ( >=media-libs/libcddb-0.9.4 )"

src_compile() {
	econf $(use_enable cddb) || die
	# had problem with parallel make (phosphan@gentoo.org)
	emake -j1 || die
}

src_install() {
	make DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog INSTALL NEWS README THANKS
}
