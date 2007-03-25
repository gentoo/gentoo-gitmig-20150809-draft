# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/tuxpaint/tuxpaint-0.9.16-r1.ebuild,v 1.2 2007/03/25 20:18:49 ticho Exp $

inherit eutils gnome2-utils

DESCRIPTION="Drawing program designed for young children"
HOMEPAGE="http://www.tuxpaint.org/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc x86"

IUSE="nls"

DEPEND="media-libs/libsdl
	media-libs/sdl-image
	media-libs/sdl-ttf
	media-libs/sdl-mixer
	>=media-libs/libpng-1.2
	>=media-libs/freetype-2
	media-libs/netpbm
	nls? ( sys-devel/gettext )"


src_unpack() {
	unpack "${A}"
	cd "${S}"

	# Sanitize the Makefile and correct a few other issues.
	epatch "${FILESDIR}"/${P}-gentoo-r1.patch
}

src_compile() {
	local myopts=""

	use nls && myopts="${myopts} ENABLE_GETTEXT=1"

	# emake may break things
	make ${myopts} || die "Compilation failed"
}

src_install () {
	local myopts=""

	use nls && myopts="${myopts} ENABLE_GETTEXT=1"

	make PKG_ROOT="${D}" ${myopts} install || die "Installation failed"

	rm -f docs/COPYING.txt docs/INSTALL.txt
	dodoc docs/*.txt
}

pkg_postinst() {
	gnome2_icon_cache_update

	einfo ""
	einfo "For additional graphic stamps, you can emerge the"
	einfo "media-gfx/tuxpaint-stamps package."
	einfo ""
}
