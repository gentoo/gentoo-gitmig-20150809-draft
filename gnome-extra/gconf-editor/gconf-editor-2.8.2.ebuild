# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/gconf-editor/gconf-editor-2.8.2.ebuild,v 1.8 2005/04/02 04:52:20 geoman Exp $

inherit gnome2

DESCRIPTION="An editor to the GNOME 2 config system"
HOMEPAGE="http://www.gnome.org/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc alpha hppa amd64 ia64 mips"
IUSE=""

RDEPEND=">=gnome-base/gconf-2.8.1
	>=x11-libs/gtk+-2.0.2
	>=gnome-base/libgnome-2
	>=gnome-base/libgnomeui-2.6"

DEPEND="${RDEPEND}
	app-text/scrollkeeper
	sys-devel/gettext
	>=dev-util/intltool-0.29
	>=dev-util/pkgconfig-0.9"

DOCS="AUTHORS ChangeLog README NEWS"
