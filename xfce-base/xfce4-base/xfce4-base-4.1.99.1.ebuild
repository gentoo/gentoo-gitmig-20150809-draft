# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-base/xfce4-base/xfce4-base-4.1.99.1.ebuild,v 1.1 2004/11/25 05:22:07 bcowan Exp $

DESCRIPTION="Xfce 4 base ebuild"
HOMEPAGE="http://www.xfce.org/"
SRC_URI=""

LICENSE="GPL-2 BSD LGPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

RDEPEND="virtual/x11
	>=x11-libs/gtk+-2.2*
	dev-libs/libxml2
	x11-libs/startup-notification
	>=dev-libs/dbh-1.0.20
	=xfce-base/libxfce4util-${PV}
	=xfce-base/libxfcegui4-${PV}
	=xfce-base/libxfce4mcs-${PV}
	=xfce-base/xfce-mcs-manager-${PV}
	=x11-themes/gtk-engines-xfce-2.2.0"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"
