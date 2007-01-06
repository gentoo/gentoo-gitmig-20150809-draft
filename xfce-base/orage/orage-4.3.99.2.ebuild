# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-base/orage/orage-4.3.99.2.ebuild,v 1.2 2007/01/06 19:06:33 nichoj Exp $

inherit xfce44

xfce44_beta

DESCRIPTION="Xfce4 calendar"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86"
IUSE="debug berkdb"

RDEPEND="|| ( x11-libs/libX11
	virtual/x11 )
	>=dev-libs/glib-2.2
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
