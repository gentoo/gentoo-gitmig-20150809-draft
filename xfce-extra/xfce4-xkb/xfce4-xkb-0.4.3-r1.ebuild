# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-extra/xfce4-xkb/xfce4-xkb-0.4.3-r1.ebuild,v 1.2 2007/02/04 01:33:05 drac Exp $

inherit xfce44

xfce44
xfce44_goodies_panel_plugin

DESCRIPTION="XKB layout switching panel plugin"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86"
RDEPEND=">=xfce-base/xfce4-panel-${XFCE_MASTER_VERSION}
	>=dev-libs/glib-2.6
	>=x11-libs/gtk+-2.6"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	dev-util/intltool
	x11-proto/kbproto"

DOCS="AUTHORS ChangeLog NEWS README"
