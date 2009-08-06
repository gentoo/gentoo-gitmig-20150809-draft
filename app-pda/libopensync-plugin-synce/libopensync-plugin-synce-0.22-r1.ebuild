# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-pda/libopensync-plugin-synce/libopensync-plugin-synce-0.22-r1.ebuild,v 1.2 2009/08/06 15:17:48 mr_bones_ Exp $

inherit autotools

DESCRIPTION="OpenSync Synce Plugin"
HOMEPAGE="http://www.opensync.org/"
SRC_URI="http://www.opensync.org/download/releases/0.22/${P}.tar.bz2"

KEYWORDS="~amd64 ~x86"
SLOT="0"
LICENSE="LGPL-2.1"
IUSE=""

DEPEND="=app-pda/libopensync-${PV}*
	app-pda/synce-librra
	dev-libs/libmimedir"

RDEPEND="${DEPEND}"

src_unpack() {
	unpack ${A}
	cd "${S}"

	#patch wall werror
	epatch "${FILESDIR}/${P}-warning.patch"
	eautoreconf
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS ChangeLog NEWS README
}
