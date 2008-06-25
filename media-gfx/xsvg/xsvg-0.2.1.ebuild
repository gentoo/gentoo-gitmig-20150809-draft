# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/xsvg/xsvg-0.2.1.ebuild,v 1.12 2008/06/25 18:00:48 maekke Exp $

inherit autotools eutils

DESCRIPTION="a command line viewer for SVG files"
HOMEPAGE="http://cairographics.org"
SRC_URI="http://cairographics.org/snapshots/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 hppa ppc ~sparc x86"
IUSE=""

RDEPEND="x11-libs/libsvg-cairo"
DEPEND="${RDEPEND}
	x11-libs/libXt
	x11-libs/libXcursor"

pkg_setup() {
	if ! built_with_use x11-libs/cairo X ; then
		eerror "x11-libs/cairo needs to be built with USE=\"X\""
		die "remerge x11-libs/cairo with USE=\"X\""
	fi
}

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-asneeded.patch
	eautoreconf
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed."
	dodoc AUTHORS ChangeLog NEWS README
}
