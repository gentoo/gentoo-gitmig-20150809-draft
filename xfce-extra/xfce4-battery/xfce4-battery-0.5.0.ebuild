# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-extra/xfce4-battery/xfce4-battery-0.5.0.ebuild,v 1.3 2007/01/29 19:50:49 welp Exp $

inherit eutils xfce44

xfce44_beta
xfce44_goodies_panel_plugin

DESCRIPTION="Battery status panel plugin"

KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86"
IUSE="debug"

DEPEND="dev-util/intltool"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${P}-freebsd.patch"
}
