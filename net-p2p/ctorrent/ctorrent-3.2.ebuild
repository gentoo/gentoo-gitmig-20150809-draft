# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/ctorrent/ctorrent-3.2.ebuild,v 1.3 2007/08/31 20:21:40 angelos Exp $

MY_P="${PN}-dnh${PV}"

DESCRIPTION="Enhanced CTorrent is a BitTorrent console client written in C and C++."
HOMEPAGE="http://www.rahul.net/dholmes/ctorrent/"
SRC_URI="http://www.rahul.net/dholmes/${PN}/${MY_P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="amd64 ~ppc ~sparc x86 ~x86-fbsd"
IUSE=""

S="${WORKDIR}/${MY_P}"

DEPEND=">=sys-apps/sed-4
	dev-libs/openssl"

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed."
	dodoc AUTHORS ChangeLog README-DNH.TXT README NEWS
}
