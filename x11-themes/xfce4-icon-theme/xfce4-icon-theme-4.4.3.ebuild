# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/xfce4-icon-theme/xfce4-icon-theme-4.4.3.ebuild,v 1.8 2011/01/30 18:32:43 ssuominen Exp $

EAPI=3
inherit gnome2-utils

DESCRIPTION="Icon theme called Rodent"
HOMEPAGE="http://www.xfce.org/"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 sparc x86 ~x86-fbsd ~x86-freebsd ~x86-interix ~amd64-linux ~x86-linux"
IUSE="minimal"

RDEPEND="x11-themes/hicolor-icon-theme
	minimal? ( || ( x11-themes/tango-icon-theme x11-themes/gnome-icon-theme ) )"
DEPEND="dev-util/pkgconfig
	dev-util/intltool
	sys-devel/gettext"

RESTRICT="binchecks strip"

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog NEWS README TODO
}

pkg_preinst() { gnome2_icon_savelist; }
pkg_postinst() { gnome2_icon_cache_update; }
pkg_postrm() { gnome2_icon_cache_update; }
