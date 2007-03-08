# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-extra/xfce4-dict/xfce4-dict-0.2.1.ebuild,v 1.4 2007/03/08 22:42:08 gustavoz Exp $

inherit xfce44

xfce44

DESCRIPTION="Dict panel plugin"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 sparc ~x86 ~x86-fbsd"

DEPEND="dev-util/intltool"

xfce44_goodies_panel_plugin
