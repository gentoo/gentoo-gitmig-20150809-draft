# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-extra/xfce4-xkb/xfce4-xkb-0.4.3-r1.ebuild,v 1.4 2007/03/02 22:52:16 welp Exp $

inherit xfce44

xfce44

DESCRIPTION="XKB layout switching panel plugin"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"

DEPEND="dev-util/pkgconfig
	dev-util/intltool
	x11-proto/kbproto"

DOCS="AUTHORS ChangeLog NEWS README"

xfce44_goodies_panel_plugin
