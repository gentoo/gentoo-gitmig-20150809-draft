# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-base/xfce-utils/xfce-utils-4.2.3.ebuild,v 1.8 2006/04/22 10:37:16 corsair Exp $

inherit xfce42

DESCRIPTION="Xfce 4 utilities"
KEYWORDS="~alpha amd64 ~arm hppa ~ia64 ~mips ppc ppc64 sparc x86"
IUSE="gtkhtml"

RDEPEND="|| ( ( x11-libs/libX11
	x11-libs/libICE
	x11-libs/libSM
	x11-apps/xrdb )
	virtual/x11 )
	~xfce-base/xfce-mcs-manager-${PV}
	gtkhtml? ( gnome-extra/gtkhtml )"
DEPEND="${RDEPEND}
	|| ( x11-libs/libXt virtual/x11 )"

XFCE_CONFIG="$(use_enable gtkhtml) --enable-gdm"
core_package
