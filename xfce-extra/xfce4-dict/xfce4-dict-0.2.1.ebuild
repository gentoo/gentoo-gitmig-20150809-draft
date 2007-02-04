# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-extra/xfce4-dict/xfce4-dict-0.2.1.ebuild,v 1.2 2007/02/04 16:59:31 nichoj Exp $

inherit xfce44

DESCRIPTION="Xfce4 panel dict plugin"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"

xfce44
xfce44_goodies_panel_plugin

DEPEND="dev-util/intltool"
