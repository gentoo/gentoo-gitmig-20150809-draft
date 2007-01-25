# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-base/libxfcegui4/libxfcegui4-4.4.0.ebuild,v 1.3 2007/01/25 19:26:07 welp Exp $

inherit xfce44

xfce44

DESCRIPTION="Libraries for Xfce4"
LICENSE="LGPL-2"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86"
IUSE="debug startup-notification"

RDEPEND="x11-libs/libICE
	x11-libs/libSM
	x11-libs/libX11
	>=dev-libs/glib-2
	>=dev-libs/libxml2-2.4
	>=x11-libs/gtk+-2.2
	x11-libs/pango
	startup-notification? ( >=x11-libs/startup-notification-0.5 )
	>=xfce-base/libxfce4util-${XFCE_MASTER_VERSION}
	dev-libs/atk
	sys-libs/zlib
	x11-libs/cairo"
DEPEND="${RDEPEND}
	!=xfce-base/xfce-mcs-plugins-4.3*
	!=xfce-base/xfce4-panel-4.3*
	>=dev-util/gtk-doc-1
	x11-proto/xproto"

XFCE_CONFIG="${XFCE_CONFIG} $(use_enable startup-notification)"

xfce44_core_package
