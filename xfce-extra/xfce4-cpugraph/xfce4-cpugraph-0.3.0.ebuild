# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-extra/xfce4-cpugraph/xfce4-cpugraph-0.3.0.ebuild,v 1.1 2007/01/22 00:48:43 nichoj Exp $

WANT_AUTOCONF=latest
WANT_AUTOMAKE=latest

inherit xfce44 eutils autotools

xfce44_beta
xfce44_goodies_panel_plugin

DESCRIPTION="Xfce4 panel cpugraph plugin"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86"

DEPEND=">=xfce-extra/xfce4-dev-tools-4.3.99"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch ${FILESDIR}/${P}-asneeded.patch
	AT_M4DIR=/usr/share/xfce4/dev-tools/m4macros eautoreconf
}
