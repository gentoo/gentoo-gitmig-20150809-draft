# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-extra/xfce4-genmon/xfce4-genmon-3.1.ebuild,v 1.12 2007/05/18 11:49:12 armin76 Exp $

inherit xfce44

xfce44

DESCRIPTION="Generic monitor panel plugin"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 sparc x86 ~x86-fbsd"

DEPEND="dev-util/pkgconfig
	dev-util/intltool"

DOCS="AUTHORS ChangeLog NEWS README"

xfce44_goodies_panel_plugin
