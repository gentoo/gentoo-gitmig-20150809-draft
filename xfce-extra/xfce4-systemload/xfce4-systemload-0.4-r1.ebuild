# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-extra/xfce4-systemload/xfce4-systemload-0.4-r1.ebuild,v 1.1 2007/01/21 18:10:32 nichoj Exp $

WANT_AUTOCONF=latest
WANT_AUTOMAKE=1.9

inherit xfce44 eutils autotools

xfce44_beta
xfce44_goodies_panel_plugin

DESCRIPTION="Xfce system load monitor"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86"
SRC_URI="http://goodies.xfce.org/_media/projects/panel-plugins/${MY_P}${COMPRESS}"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}-asneeded.patch
	eautomake
}
