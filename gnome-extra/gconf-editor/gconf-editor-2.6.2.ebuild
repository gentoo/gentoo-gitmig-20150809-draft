# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/gconf-editor/gconf-editor-2.6.2.ebuild,v 1.3 2004/07/31 03:45:16 spider Exp $

inherit gnome2

DESCRIPTION="An editor to the GNOME 2 config system"
HOMEPAGE="http://www.gnome.org/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~ppc ~sparc ~alpha ~hppa ~amd64 ~ia64 ~mips"
IUSE=""

RDEPEND=">=gnome-base/gconf-1.2
	>=x11-libs/gtk+-2.0.2"

DEPEND="${RDEPEND}
	sys-devel/gettext
	>=dev-util/intltool-0.29
	>=dev-util/pkgconfig-0.9"

DOCS="AUTHORS ChangeLog COPYING README INSTALL NEWS"
