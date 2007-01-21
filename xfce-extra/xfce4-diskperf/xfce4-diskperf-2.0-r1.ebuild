# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-extra/xfce4-diskperf/xfce4-diskperf-2.0-r1.ebuild,v 1.1 2007/01/21 17:51:20 nichoj Exp $

WANT_AUTOCONF="latest"
WANT_AUTOMAKE="latest"
inherit xfce44 eutils autotools

xfce44_beta
xfce44_goodies_panel_plugin

DESCRIPTION="Xfce4 panel disk usage/performance plugin"
KEYWORDS="~alpha ~amd64 ~arm ~ia64 ~ppc ~sparc ~x86"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}-asneeded.patch
	AT_M4DIR=/usr/share/xfce4/dev-tools/m4macros eautoreconf
}
