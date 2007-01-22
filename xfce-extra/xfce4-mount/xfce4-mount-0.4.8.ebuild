# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-extra/xfce4-mount/xfce4-mount-0.4.8.ebuild,v 1.1 2007/01/22 14:24:54 nichoj Exp $

WANT_AUTOCONF=latest
WANT_AUTOMAKE=1.9

inherit xfce44 eutils autotools

xfce44_beta
xfce44_goodies_panel_plugin

DESCRIPTION="Xfce4 panel mount point plugin"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86"

src_unpack() {
	unpack ${A}
	cd ${S}
	# TODO:  Report to upstream.
	epatch ${FILESDIR}/${PN}-asneeded.patch
	eautomake
}
