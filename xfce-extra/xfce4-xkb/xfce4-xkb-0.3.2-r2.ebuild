# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-extra/xfce4-xkb/xfce4-xkb-0.3.2-r2.ebuild,v 1.1 2005/10/06 07:53:04 bcowan Exp $

inherit xfce42

DESCRIPTION="Xfce4 panel xkb layout switching plugin"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86"
RDEPEND="|| ( ( x11-libs/libX11
	x11-libs/libXpm
	x11-libs/libXext )
	virtual/x11 )"
DEPEND="${RDEPEND}
	|| ( x11-libs/libX11 virtual/x11 )"

goodies_plugin