# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-base/libxfce4menu/libxfce4menu-4.5_pre20070325.ebuild,v 1.1 2007/03/25 14:17:28 drac Exp $

inherit xfce44

xfce44

DESCRIPTION="Menu implementation library"
HOMEPAGE="http://www.xfce.org/projects/libraries"
SRC_URI="http://dev.gentoo.org/~drac/distfiles/${P}.tar.bz2"

KEYWORDS="~x86"
IUSE="debug doc"

RDEPEND=">=dev-libs/glib-2.6
	>=x11-libs/gtk+-2.6
	>=xfce-base/libxfce4util-${XFCE_MASTER_VERSION}"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	dev-util/intltool
	doc? ( dev-util/gtk-doc )"

DOCS="AUTHORS ChangeLog HACKING NEWS README STATUS THANKS TODO"
