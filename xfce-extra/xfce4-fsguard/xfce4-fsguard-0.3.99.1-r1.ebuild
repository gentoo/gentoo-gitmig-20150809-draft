# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-extra/xfce4-fsguard/xfce4-fsguard-0.3.99.1-r1.ebuild,v 1.1 2007/10/18 13:15:17 angelos Exp $

inherit xfce44 eutils

xfce44

DESCRIPTION="Filesystem guard panel plugin"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}/${PN}-size.patch"
}

xfce44_goodies_panel_plugin
