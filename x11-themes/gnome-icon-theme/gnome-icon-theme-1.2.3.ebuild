# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/gnome-icon-theme/gnome-icon-theme-1.2.3.ebuild,v 1.10 2005/01/08 23:40:48 slarti Exp $

inherit gnome2

DESCRIPTION="GNOME 2 default icon themes"
HOMEPAGE="http://www.gnome.org/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc alpha arm hppa amd64 ia64 mips ~ppc64"
IUSE=""

DEPEND="sys-devel/gettext
	x11-themes/hicolor-icon-theme
	>=dev-util/intltool-0.29"

DOCS="AUTHORS README INSTALL NEWS ChangeLog"
