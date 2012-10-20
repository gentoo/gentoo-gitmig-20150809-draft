# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-calculators/galculator/galculator-2.0.ebuild,v 1.2 2012/10/20 10:07:30 ssuominen Exp $

EAPI=4
inherit gnome2-utils

DESCRIPTION="GTK+ based algebraic and RPN calculator"
HOMEPAGE="http://galculator.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ppc ~x86 ~x86-fbsd ~x86-freebsd ~amd64-linux ~x86-linux ~ppc-macos"
IUSE=""

RDEPEND="x11-libs/gtk+:3"
DEPEND="${RDEPEND}
	dev-util/intltool
	sys-devel/flex
	sys-devel/gettext
	virtual/pkgconfig"

DOCS="AUTHORS ChangeLog NEWS README THANKS TODO doc/shortcuts"

src_prepare() {
	cat <<-EOF >> po/POTFILES.skip
	ui/about.ui
	ui/dispctrl_right_vertical.ui
	ui/main_frame_hildon.ui
	ui/prefs-ume.ui
	EOF
}

pkg_preinst() {	gnome2_icon_savelist; }
pkg_postinst() { gnome2_icon_cache_update; }
pkg_postrm() { gnome2_icon_cache_update; }
