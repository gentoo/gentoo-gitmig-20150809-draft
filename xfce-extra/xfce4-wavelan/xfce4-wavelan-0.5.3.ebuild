# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-extra/xfce4-wavelan/xfce4-wavelan-0.5.3.ebuild,v 1.1 2006/12/13 23:51:41 nichoj Exp $

inherit xfce44

xfce44_goodies_panel_plugin

DESCRIPTION="Xfce4 wireless monitor panel plugin"

KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86"
IUSE="debug"

DEPEND="dev-util/intltool
	>=xfce-base/xfce4-panel-4.3.20
	>=x11-libs/gtk+-2.6.0"
RDEPEND=""

XFCE_CONFIG="$(use_enable debug)"
