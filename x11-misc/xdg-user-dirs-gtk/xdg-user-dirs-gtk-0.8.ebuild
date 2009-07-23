# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/xdg-user-dirs-gtk/xdg-user-dirs-gtk-0.8.ebuild,v 1.2 2009/07/23 23:08:30 eva Exp $

GCONF_DEBUG="no"

inherit gnome2

DESCRIPTION="xdg-user-dirs-gtk integrates xdg-user-dirs into the Gnome desktop and Gtk+ applications"
HOMEPAGE="http://www.freedesktop.org/wiki/Software/xdg-user-dirs"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=x11-misc/xdg-user-dirs-0.8
	>=x11-libs/gtk+-2"
DEPEND="${RDEPEND}
	>=dev-util/intltool-0.35.5
	  dev-util/pkgconfig"

DOCS="AUTHORS ChangeLog INSTALL NEWS README"

pkg_postinst() {
	elog
	elog " This package tries to automatically use some sensible default "
	elog " directories for you documents, music, video and other stuff "
	elog
	elog " If you want to change those directories to your needs, see "
	elog " the settings in ~/.config/user-dir.dirs "
	elog
}
