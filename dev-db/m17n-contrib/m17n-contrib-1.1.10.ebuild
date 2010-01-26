# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/m17n-contrib/m17n-contrib-1.1.10.ebuild,v 1.1 2010/01/26 15:27:16 matsuu Exp $

DESCRIPTION="Contribution database for the m17n library"
HOMEPAGE="http://www.m17n.org/m17n-lib/"
SRC_URI="http://www.m17n.org/m17n-lib-download/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-db/m17n-db"
RDEPEND="${DEPEND}"

src_install() {
	emake DESTDIR="${D}" install || die

	dodoc AUTHORS ChangeLog NEWS README || die
}
