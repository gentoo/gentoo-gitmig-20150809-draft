# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-extra/xfce4-time-out/xfce4-time-out-0.1.1.ebuild,v 1.6 2007/09/01 16:48:37 nixnut Exp $

inherit xfce44

xfce44

DESCRIPTION="Panel plugin to take a break from computer work."
KEYWORDS="alpha amd64 ~arm hppa ia64 ppc ~ppc64 sparc x86"
IUSE="debug"

RDEPEND=""
DEPEND="${RDEPEND}
	dev-util/intltool
	dev-lang/perl"

DOCS="AUTHORS ChangeLog NEWS README THANKS TODO"

xfce44_goodies_panel_plugin
