# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-extra/xfce4-time-out/xfce4-time-out-0.1.0-r1.ebuild,v 1.2 2007/06/08 17:04:14 drac Exp $

inherit eutils xfce44

xfce44

DESCRIPTION="Panel plugin for taking break from computer work."
KEYWORDS="~arm ~alpha ~amd64 ~ia64 ~ppc64 ~sparc ~x86"
IUSE="debug"

RDEPEND=""
DEPEND="${RDEPEND}
	dev-util/intltool
	dev-lang/perl"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-save-settings.patch
}

DOCS="AUTHORS ChangeLog NEWS README THANKS TODO"

xfce44_goodies_panel_plugin
