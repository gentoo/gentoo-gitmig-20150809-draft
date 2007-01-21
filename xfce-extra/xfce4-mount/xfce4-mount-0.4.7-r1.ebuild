# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-extra/xfce4-mount/xfce4-mount-0.4.7-r1.ebuild,v 1.1 2007/01/21 17:25:43 nichoj Exp $

WANT_AUTOCONF="latest"
WANT_AUTOMAKE="1.9"
inherit xfce44 eutils autotools

DESCRIPTION="Xfce4 panel mount point plugin"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86"

xfce44_beta
xfce44_goodies_panel_plugin

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}-asneeded.patch
	eautomake
}
