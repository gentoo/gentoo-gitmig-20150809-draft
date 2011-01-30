# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/tango-icon-theme/tango-icon-theme-0.8.90.ebuild,v 1.12 2011/01/30 18:22:50 armin76 Exp $

EAPI=2
inherit gnome2-utils

DESCRIPTION="SVG and PNG icon theme from the Tango project"
HOMEPAGE="http://tango.freedesktop.org"
SRC_URI="http://tango.freedesktop.org/releases/${P}.tar.gz"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ppc ppc64 sparc x86 ~x86-fbsd ~x86-freebsd ~amd64-linux ~x86-linux ~sparc-solaris ~sparc64-solaris ~x64-solaris ~x86-solaris"
IUSE="png"

RDEPEND=">=x11-themes/hicolor-icon-theme-0.12"
DEPEND="${RDEPEND}
	dev-util/intltool
	dev-util/pkgconfig
	>=gnome-base/librsvg-2.12.3
	|| ( media-gfx/imagemagick[png?] media-gfx/graphicsmagick[imagemagick,png?] )
	sys-devel/gettext
	>=x11-misc/icon-naming-utils-0.8.90"

RESTRICT="binchecks strip"

src_configure() {
	econf \
		$(use_enable png png-creation) \
		$(use_enable png icon-framing)
}

src_install() {
	addwrite /root/.gnome2
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog README
}

pkg_preinst() {	gnome2_icon_savelist; }
pkg_postinst() { gnome2_icon_cache_update; }
pkg_postrm() { gnome2_icon_cache_update; }
