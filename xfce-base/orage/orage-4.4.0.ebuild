# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-base/orage/orage-4.4.0.ebuild,v 1.4 2007/01/28 14:30:21 welp Exp $

inherit xfce44

xfce44

DESCRIPTION="Calendar"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86"
IUSE="debug"

RDEPEND=">=dev-libs/glib-2.6
	>=x11-libs/gtk+-2.6
	>=xfce-base/libxfce4mcs-${XFCE_MASTER_VERSION}
	>=xfce-base/libxfce4util-${XFCE_MASTER_VERSION}
	>=xfce-base/libxfcegui4-${XFCE_MASTER_VERSION}
	>=xfce-base/xfce4-panel-${XFCE_MASTER_VERSION}
	!xfce-extra/xfcalendar"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	dev-util/intltool"

DOCS="AUTHORS ChangeLog NEWS README"

xfce44_core_package
