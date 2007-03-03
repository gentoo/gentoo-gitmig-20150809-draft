# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-extra/xfce4-weather/xfce4-weather-0.4.9-r2.ebuild,v 1.4 2007/03/03 14:44:12 nixnut Exp $

inherit xfce42 eutils

DESCRIPTION="Xfce panel weather monitor"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ppc ppc64 ~sparc x86"

goodies_plugin

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/scrollbox.c.patch
}
