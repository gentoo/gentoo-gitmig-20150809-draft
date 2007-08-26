# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-extra/xfce4-screenshooter/xfce4-screenshooter-1.0.0-r1.ebuild,v 1.3 2007/08/26 20:13:42 armin76 Exp $

inherit eutils xfce44

xfce44

DESCRIPTION="Xfce4 panel screenshooter plugin"
KEYWORDS="alpha amd64 ~arm ~hppa ia64 ~mips ~ppc ~ppc64 ~sparc x86 ~x86-fbsd"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-cancel-save.patch
}

DOCS="AUTHORS ChangeLog NEWS README"

xfce44_goodies_panel_plugin
