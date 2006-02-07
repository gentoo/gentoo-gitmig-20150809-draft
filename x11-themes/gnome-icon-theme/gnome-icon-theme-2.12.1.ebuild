# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/gnome-icon-theme/gnome-icon-theme-2.12.1.ebuild,v 1.9 2006/02/07 09:37:39 agriffis Exp $

inherit gnome2

DESCRIPTION="GNOME 2 default icon themes"
HOMEPAGE="http://www.gnome.org/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 ~arm hppa ia64 ~mips ppc ppc64 sparc x86"
IUSE=""

DEPEND="sys-devel/gettext
	x11-themes/hicolor-icon-theme
	>=dev-util/pkgconfig-0.19
	>=dev-util/intltool-0.28"

DOCS="AUTHORS ChangeLog NEWS TODO"
USE_DESTDIR="1"
