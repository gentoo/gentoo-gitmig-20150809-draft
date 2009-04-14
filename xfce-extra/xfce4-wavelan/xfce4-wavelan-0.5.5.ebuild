# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-extra/xfce4-wavelan/xfce4-wavelan-0.5.5.ebuild,v 1.1 2009/04/14 08:16:22 angelos Exp $

inherit xfce4

DESCRIPTION="Wireless monitor panel plugin"
KEYWORDS="~amd64 ~arm ~hppa ~mips ~ppc ~ppc64 ~x86"
IUSE="debug"

DEPEND="dev-util/intltool"

xfce4_panel_plugin
