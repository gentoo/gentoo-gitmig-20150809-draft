# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-base/libxfce4mcs/libxfce4mcs-4.4.0.ebuild,v 1.2 2007/01/23 16:40:51 welp Exp $

inherit xfce44

xfce44

DESCRIPTION="Libraries for Xfce4"
LICENSE="LGPL-2"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86"
IUSE="debug"

RDEPEND=">=xfce-base/libxfce4util-${XFCE_MASTER_VERSION}
	>=dev-libs/glib-2
	>=x11-libs/gtk+-2.4
	x11-libs/libX11
	x11-libs/libICE
	x11-libs/libSM"
DEPEND="${RDEPEND}
	x11-proto/xproto"

xfce44_core_package
