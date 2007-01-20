# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/ctorrent/ctorrent-2.2.ebuild,v 1.2 2007/01/20 14:17:55 armin76 Exp $

WANT_AUTOCONF="latest"
WANT_AUTOMAKE="latest"
inherit eutils autotools

MY_P="${PN}-1.3.4-dnh${PV}"

DESCRIPTION="Enhanced CTorrent is a BitTorrent console client written in C and C++."
HOMEPAGE="http://www.rahul.net/dholmes/ctorrent/"
SRC_URI="http://www.rahul.net/dholmes/${PN}/${MY_P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc ~sparc ~x86 ~x86-fbsd"
IUSE=""
S="${WORKDIR}/${PN}-dnh${PV}"

DEPEND=">=sys-apps/sed-4
	dev-libs/openssl"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/as-needed.patch
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc README-DNH.TXT README NEWS
}
