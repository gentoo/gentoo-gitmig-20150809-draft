# Copyright 2006-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/matchbox-themes-extra/matchbox-themes-extra-0.3.ebuild,v 1.3 2007/09/26 04:04:43 jer Exp $

inherit versionator

DESCRIPTION="Extra themes for the matchbox window manager"
HOMEPAGE="http://projects.o-hand.com/matchbox/"
SRC_URI="http://projects.o-hand.com/matchbox/sources/${PN}/$(get_version_component_range 1-2)/${P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"

KEYWORDS="~arm ~hppa ~x86"
IUSE=""

DEPEND=""

DEPEND="x11-wm/matchbox-window-manager"

src_compile() {
	econf || die "Configuration failed"

	emake || die "Compilation failed"
}

src_install() {
	make DESTDIR=${D} install || die "Installation failed"

	dodoc AUTHORS Changelog INSTALL NEWS README
}
