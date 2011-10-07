# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/lxde-base/lxlauncher/lxlauncher-0.2.2.ebuild,v 1.3 2011/10/07 18:37:30 hwoarang Exp $

EAPI="4"

DESCRIPTION="An open source clone of the Asus launcher for EeePC"
HOMEPAGE="http://lxde.sf.net/"
SRC_URI="mirror://sourceforge/lxde/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha amd64 ~ppc x86 ~x86-interix ~amd64-linux ~x86-linux"
IUSE=""

RDEPEND="dev-libs/glib:2
	x11-libs/gtk+:2
	gnome-base/gnome-menus
	x11-libs/startup-notification"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	dev-util/intltool
	sys-devel/gettext
	lxde-base/menu-cache
	!lxde-base/lxlauncher-gmenu"

src_install() {
	emake DESTDIR="${D}" install
	dodoc AUTHORS ChangeLog README
}
