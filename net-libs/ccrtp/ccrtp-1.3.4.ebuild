# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/ccrtp/ccrtp-1.3.4.ebuild,v 1.1 2005/08/21 04:22:57 dragonheart Exp $

DESCRIPTION="GNU ccRTP is an implementation of RTP, the real-time transport protocol from the IETF"
HOMEPAGE="http://www.gnu.org/software/ccrtp/"
SRC_URI="mirror://gnu/${PN}/${P}.tar.gz"

KEYWORDS="~x86 ~ppc"
LICENSE="GPL-2"
IUSE=""
SLOT="0"

DEPEND=">=dev-cpp/commoncpp2-1.3.0"
RDEPEND="${DEPEND}"

src_install() {
	emake DESTDIR=${D} install || die
	dodoc README ChangeLog INSTALL AUTHORS COPYING NEWS TODO
}
