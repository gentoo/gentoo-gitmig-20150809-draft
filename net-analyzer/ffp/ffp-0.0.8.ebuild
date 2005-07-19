# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/ffp/ffp-0.0.8.ebuild,v 1.2 2005/07/19 13:05:12 dholm Exp $

DESCRIPTION="a tool to do fuzzy fingerprinting for man-in-the-middle attacks"
HOMEPAGE="http://www.thc.org/thc-ffp/"
SRC_URI="http://www.thc.org/releases/${P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

DEPEND="dev-libs/openssl"

src_install() {
	make install DESTDIR="${D}" || die
	dodoc README TODO doc/ffp.pdf
	dohtml doc/ffp.html
}
