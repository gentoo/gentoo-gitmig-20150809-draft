# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/tango-icon-theme/tango-icon-theme-0.8.1.ebuild,v 1.1 2007/09/20 20:22:49 drac Exp $

inherit eutils gnome2-utils

DESCRIPTION="SVG icon theme from the Tango project"
HOMEPAGE="http://tango-project.org"
SRC_URI="http://tango-project.org/releases/${P}.tar.gz"

LICENSE="CCPL-Attribution-ShareAlike-2.5"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE="png"

RESTRICT="binchecks strip"

RDEPEND=">=x11-misc/icon-naming-utils-0.8.2
	media-gfx/imagemagick
	>=gnome-base/librsvg-2.12.3
	>=x11-themes/hicolor-icon-theme-0.9"
DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.19
	>=dev-util/intltool-0.33
	sys-devel/gettext"

pkg_setup() {
	if use png && ! built_with_use media-gfx/imagemagick png; then
		die "Build media-gfx/imagemagick with USE=png."
	fi
}

src_compile() {
	econf $(use_enable png png-creation) \
		$(use_enable png icon-framing)
	emake || die "emake failed."
}

src_install() {
	addwrite "/root/.gnome2"

	emake DESTDIR=${D} install || die "emake install failed."
	dodoc AUTHORS ChangeLog NEWS README
}

pkg_postinst() {
	gnome2_icon_cache_update
}

pkg_postrm() {
	gnome2_icon_cache_update
}
