# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-extra/xfce4-genmon/xfce4-genmon-3.0-r1.ebuild,v 1.2 2007/01/23 22:05:39 welp Exp $

WANT_AUTOCONF="latest"
WANT_AUTOMAKE="latest"

inherit xfce44 eutils autotools

xfce44_beta
xfce44_goodies_panel_plugin

DESCRIPTION="Xfce4 panel generic monitor plugin"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86"

DEPEND="xfce-extra/xfce4-dev-tools
	dev-util/intltool"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}-asneeded.patch
	AT_M4DIR=/usr/share/xfce4/dev-tools/m4macros eautoreconf
	intltoolize --automake --copy --force || die "intltoolize failed"
}

