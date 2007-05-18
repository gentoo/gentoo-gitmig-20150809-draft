# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/ctorrent/ctorrent-3_p20070427.ebuild,v 1.1 2007/05/18 17:46:46 armin76 Exp $

inherit autotools eutils versionator

MY_P="${PN}-1.3.4-dnh$(get_major_version)"
PATCH="${PN}-$(get_major_version)-patch-$(get_version_component_range 2-).diff"

DESCRIPTION="Enhanced CTorrent is a BitTorrent console client written in C and C++."
HOMEPAGE="http://www.rahul.net/dholmes/ctorrent/"
SRC_URI="http://www.rahul.net/dholmes/${PN}/${MY_P}.tar.gz
		 mirror://gentoo/${PATCH}.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc ~sparc ~x86 ~x86-fbsd"
IUSE=""

S="${WORKDIR}/${PN}-dnh$(get_major_version)"

DEPEND=">=sys-apps/sed-4
	dev-libs/openssl"

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${WORKDIR}"/${PATCH} \
		"${FILESDIR}"/${PN}-3_autoconf-fix.patch

	eautoreconf
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed."
	dodoc AUTHORS ChangeLog README-DNH.TXT README NEWS
}
