# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-extra/xfce4-appfinder/xfce4-appfinder-4.4.0.ebuild,v 1.1 2007/01/22 02:14:46 nichoj Exp $

inherit xfce44

xfce44

DESCRIPTION="Xfce4 application finder"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86"
IUSE="debug"

RDEPEND=">=dev-libs/glib-2
	>=x11-libs/gtk+-2.4
	>=xfce-base/libxfce4util-${PV}
	>=xfce-base/libxfcegui4-${PV}"

xfce44_core_package
