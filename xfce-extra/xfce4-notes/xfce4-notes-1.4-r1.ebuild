# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-extra/xfce4-notes/xfce4-notes-1.4-r1.ebuild,v 1.1 2007/01/21 17:44:07 nichoj Exp $

WANT_AUTOMAKE=1.9
WANT_AUTOCONF=latest

inherit xfce44 autotools eutils

DESCRIPTION="Xfce4 panel sticky notes plugin"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86"

xfce44_beta
xfce44_goodies_panel_plugin

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}-asneeded.patch
	eautomake
}
