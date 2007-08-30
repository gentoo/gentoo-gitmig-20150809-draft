# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-extra/xfce4-places/xfce4-places-0.3.0.ebuild,v 1.7 2007/08/30 03:21:33 jer Exp $

inherit xfce44

xfce44

DESCRIPTION="Rewrite of GNOME Places menu for panel"
KEYWORDS="alpha amd64 arm hppa ia64 ~ppc ~ppc64 sparc x86 ~x86-fbsd"
IUSE="debug"
RESTRICT="test"

RDEPEND=">=xfce-base/thunar-${THUNAR_MASTER_VERSION}"
DEPEND="${RDEPEND}
	dev-util/intltool"

DOCS="AUTHORS ChangeLog NEWS README TODO"

xfce44_goodies_panel_plugin
