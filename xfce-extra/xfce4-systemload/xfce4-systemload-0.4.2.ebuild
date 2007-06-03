# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-extra/xfce4-systemload/xfce4-systemload-0.4.2.ebuild,v 1.13 2007/06/03 17:47:38 drac Exp $

inherit xfce44

xfce44

RESTRICT="test"

DESCRIPTION="System load monitor panel plugin"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 sparc x86 ~x86-fbsd"

DOCS="AUTHORS ChangeLog NEWS README"

xfce44_goodies_panel_plugin
