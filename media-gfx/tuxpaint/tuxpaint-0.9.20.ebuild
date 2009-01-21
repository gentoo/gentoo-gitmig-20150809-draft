# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/tuxpaint/tuxpaint-0.9.20.ebuild,v 1.2 2009/01/21 23:13:09 maekke Exp $

EAPI="2"

inherit eutils gnome2-utils multilib toolchain-funcs

DESCRIPTION="Drawing program designed for young children"
HOMEPAGE="http://www.tuxpaint.org/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"

IUSE="nls"

DEPEND="
	app-text/libpaper
	gnome-base/librsvg
	>=media-libs/libpng-1.2
	>=media-libs/freetype-2
	media-libs/libsdl
	media-libs/sdl-image[png]
	media-libs/sdl-mixer
	media-libs/sdl-pango
	media-libs/sdl-ttf
	x11-libs/cairo
	nls? ( sys-devel/gettext )"

src_prepare() {
	# Sanitize the Makefile and correct a few other issues.
	epatch "${FILESDIR}/${P}-gentoo.patch"
	sed -i -e "s|linux_PREFIX:=/usr/local|linux_PREFIX:=/usr|" Makefile || die

	# Make multilib-strict compliant, see bug #200740
	sed -i -e "s:/lib/:/$(get_libdir)/:" Makefile || die
}

src_compile() {
	local myopts=""

	use nls && myopts="${myopts} ENABLE_GETTEXT=1"

	# emake may break things
	make CC="$(tc-getCC)" ${myopts} || die "Compilation failed"
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

	elog ""
	elog "For additional graphic stamps, you can emerge the"
	elog "media-gfx/tuxpaint-stamps package."
	elog ""
}
