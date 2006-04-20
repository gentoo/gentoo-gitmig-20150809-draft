# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-base/orage/orage-4.3.90.1.ebuild,v 1.1 2006/04/20 05:50:08 dostrow Exp $

inherit xfce44

xfce44_beta

DESCRIPTION="Xfce4 calendar"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86"

IUSE="berkdb"

RDEPEND="|| ( x11-libs/libX11
	virtual/x11 )
	>=dev-libs/glib-2.2
	gnome-extra/evolution-data-server
	berkdb? ( sys-libs/db )
	>=x11-libs/gtk+-2.2
	~xfce-base/libxfce4mcs-${PV}
	~xfce-base/libxfce4util-${PV}
	~xfce-base/libxfcegui4-${PV}
	dev-libs/atk
	media-libs/libpng
	sys-libs/zlib
	x11-libs/cairo
	x11-libs/pango
	!xfce-extra/xfcalendar"
DEPEND="${RDEPEND}
	~xfce-base/xfce-mcs-manager-${PV}"

if use berkdb; then
	XFCE_CONFIG="--with-bdb4"
fi

xfce44_core_package
