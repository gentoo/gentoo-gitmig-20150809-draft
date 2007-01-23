# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-extra/xfce4-timer/xfce4-timer-0.5.1.ebuild,v 1.1 2007/01/23 23:01:19 welp Exp $

inherit xfce44

DESCRIPTION="Xfce4 panel timer plugin"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"

xfce44_beta
xfce44_goodies_panel_plugin

DEPEND="dev-util/intltool"
