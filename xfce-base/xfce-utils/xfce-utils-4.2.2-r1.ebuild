# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-base/xfce-utils/xfce-utils-4.2.2-r1.ebuild,v 1.2 2005/11/06 00:02:01 dostrow Exp $

inherit xfce42

DESCRIPTION="Xfce 4 utilities"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86"
IUSE="gtkhtml"

RDEPEND="|| ( ( x11-libs/libX11
	x11-libs/libICE
	x11-libs/libSM
	x11-apps/xrdb )
	virtual/x11 )
	~xfce-base/xfce-mcs-manager-${PV}
	gtkhtml? ( gnome-extra/libgtkhtml )"
DEPEND="${RDEPEND}
	|| ( x11-libs/libXt virtual/x11 )"

XFCE_CONFIG="$(use_enable gtkhtml) --enable-gdm"
core_package
