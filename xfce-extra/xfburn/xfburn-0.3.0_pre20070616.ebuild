# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-extra/xfburn/xfburn-0.3.0_pre20070616.ebuild,v 1.1 2007/06/16 18:47:22 drac Exp $

inherit xfce44

xfce44

DESCRIPTION="a GTK+ cd burning application"
HOMEPAGE="http://www.xfce.org/projects/xfburn"
SRC_URI="http://dev.gentooexperimental.org/~drac/distfiles/${P}.tar.bz2"

KEYWORDS="~x86"
IUSE="debug minimal"

RDEPEND=">=dev-libs/libburn-0.3
	>=dev-libs/libisofs-0.2.3
	>=xfce-extra/exo-0.3.2
	!minimal? ( >=xfce-base/thunar-${THUNAR_MASTER_VERSION} )
	>=xfce-base/libxfcegui4-${XFCE_MASTER_VERSION}"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	dev-util/intltool"

XFCE_CONFIG="${XFCE_CONFIG} --enable-final --enable-largefile --disable-dependency-tracking"

if use minimal; then
		XFCE_CONFIG="${XFCE_CONFIG} --disable-thunar-vfs"
	else
		XFCE_CONFIG="${XFCE_CONFIG} --enable-thunar-vfs"
fi

DOCS="AUTHORS ChangeLog NEWS README TODO"
