# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-extra/xfce4-cpugraph/xfce4-cpugraph-0.4.0.ebuild,v 1.8 2009/08/23 16:43:58 ssuominen Exp $

inherit xfce44

xfce44
xfce44_gzipped

DESCRIPTION="CPU load panel plugin"
KEYWORDS="alpha amd64 arm hppa ia64 ppc ppc64 sparc x86 ~x86-fbsd"
DOCS="AUTHORS ChangeLog NEWS README TODO"

xfce44_goodies_panel_plugin
