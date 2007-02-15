# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/gnome-icon-theme/gnome-icon-theme-2.14.2.ebuild,v 1.15 2007/02/15 16:05:14 compnerd Exp $

inherit gnome2

DESCRIPTION="GNOME 2 default icon themes"
HOMEPAGE="http://www.gnome.org/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ppc ppc64 sh sparc x86"
IUSE=""

RDEPEND="x11-themes/hicolor-icon-theme"
DEPEND="${RDEPEND}
	  sys-devel/gettext
	>=dev-util/pkgconfig-0.19
	>=x11-misc/icon-naming-utils-0.6.7
	>=dev-util/intltool-0.29"

DOCS="AUTHORS ChangeLog NEWS TODO"

# This ebuild does not install any binaries
RESTRICT="binchecks strip"
