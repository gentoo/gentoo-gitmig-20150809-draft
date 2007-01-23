# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-base/orage/orage-4.4.0.ebuild,v 1.3 2007/01/23 16:46:19 welp Exp $

inherit xfce44

xfce44

DESCRIPTION="Calendar for Xfce4"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86"
IUSE="debug"

RDEPEND=">=dev-libs/glib-2.2
	>=x11-libs/gtk+-2.2
	>=xfce-base/libxfce4mcs-${XFCE_MASTER_VERSION}
	>=xfce-base/libxfce4util-${XFCE_MASTER_VERSION}
	>=xfce-base/libxfcegui4-${XFCE_MASTER_VERSION}
	>=xfce-base/xfce4-panel-${XFCE_MASTER_VERSION}
	dev-libs/atk
	media-libs/libpng
	sys-libs/zlib
	x11-libs/cairo
	x11-libs/pango
	!xfce-extra/xfcalendar"
DEPEND="${RDEPEND}
	>=xfce-base/xfce-mcs-manager-${XFCE_MASTER_VERSION}"

xfce44_core_package
