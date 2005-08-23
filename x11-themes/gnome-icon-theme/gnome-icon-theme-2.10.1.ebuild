# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/gnome-icon-theme/gnome-icon-theme-2.10.1.ebuild,v 1.8 2005/08/23 21:52:08 agriffis Exp $

inherit gnome2

DESCRIPTION="GNOME 2 default icon themes"
HOMEPAGE="http://www.gnome.org/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha amd64 ~arm hppa ia64 ~mips ppc ppc64 sparc x86"
IUSE=""

DEPEND=">=x11-libs/gtk+-2.6.0
	sys-devel/gettext
	x11-themes/hicolor-icon-theme
	>=dev-util/intltool-0.29"

DOCS="AUTHORS README NEWS ChangeLog"
USE_DESTDIR="1"

pkg_postinst() {
	einfo "Updating icon cache"

	gtk-update-icon-cache -qf /usr/share/icons/gnome
	gtk-update-icon-cache -qf /usr/share/icons/hicolor
}

