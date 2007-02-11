# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-extra/xfce4-datetime/xfce4-datetime-0.5.0.ebuild,v 1.1 2007/02/11 00:06:07 drac Exp $

inherit xfce44

DESCRIPTION="Panel plugin displaying date, time and small calendar"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86"

xfce44
xfce44_gzipped
xfce44_goodies_panel_plugin

DOCS="AUTHORS ChangeLog NEWS README"
