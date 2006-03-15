# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/ccrtp/ccrtp-1.3.6.ebuild,v 1.2 2006/03/15 15:01:31 deltacow Exp $

inherit eutils

DESCRIPTION="GNU ccRTP is an implementation of RTP, the real-time transport protocol from the IETF"
HOMEPAGE="http://www.gnu.org/software/ccrtp/"
SRC_URI="mirror://gnu/${PN}/${P}.tar.gz"

KEYWORDS="~amd64 ~ppc ~x86"
LICENSE="GPL-2"
IUSE=""
SLOT="0"

DEPEND=">=dev-cpp/commoncpp2-1.3.0"
RDEPEND="${DEPEND}"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PN}-1.3.5-amd64.patch
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc README ChangeLog AUTHORS NEWS TODO
}
