# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/gconf-editor/gconf-editor-2.10.0.ebuild,v 1.12 2005/08/25 23:40:59 agriffis Exp $

inherit gnome2

DESCRIPTION="An editor to the GNOME 2 config system"
HOMEPAGE="http://www.gnome.org/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 hppa ia64 mips ppc ppc64 sparc x86"
IUSE=""

RDEPEND=">=gnome-base/gconf-2.9.2
	>=x11-libs/gtk+-2.6
	>=gnome-base/libgnome-2
	>=gnome-base/libgnomeui-2.6"

DEPEND="${RDEPEND}
	app-text/scrollkeeper
	sys-devel/gettext
	>=dev-util/intltool-0.29
	>=dev-util/pkgconfig-0.9"

DOCS="AUTHORS ChangeLog README NEWS"
USE_DESTDIR="1"
