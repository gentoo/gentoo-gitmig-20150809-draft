# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-pda/libopensync-plugin-palm/libopensync-plugin-palm-0.22.ebuild,v 1.2 2011/03/19 08:07:33 dirtyepic Exp $

EAPI="3"

inherit autotools

DESCRIPTION="OpenSync Palm Plugin"
HOMEPAGE="http://www.opensync.org/"
SRC_URI="http://www.opensync.org/download/releases/${PV}/${P}.tar.bz2"

KEYWORDS="~amd64 ~x86"
SLOT="0"
LICENSE="LGPL-2.1"
IUSE=""

RDEPEND="~app-pda/libopensync-${PV}
	>=app-pda/pilot-link-0.11.8
	dev-libs/glib:2
	dev-libs/libxml2"
DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.9.0"

src_prepare() {
	# Patch fixing includedir for pisock
	epatch "${FILESDIR}/${PN}-include_pisock.patch"
	sed -i -e 's: -Werror::g' src/Makefile.am
	eautoreconf
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	find "${D}" -name '*.la' -exec rm -f {} + || die
	dodoc AUTHORS README
}
