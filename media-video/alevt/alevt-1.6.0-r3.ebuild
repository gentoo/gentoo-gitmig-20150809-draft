# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/alevt/alevt-1.6.0-r3.ebuild,v 1.9 2004/08/14 14:45:46 swegener Exp $

inherit eutils

DESCRIPTION="Teletext viewer for X11"
HOMEPAGE="http://www.goron.de/~froese/"
SRC_URI="http://www.ibiblio.org/pub/Linux/apps/video/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~amd64"
IUSE="gnome"
LICENSE="GPL-2"

DEPEND="virtual/x11
	>=media-libs/libpng-1.0.12"

src_unpack() {
	unpack ${P}.tar.gz
	epatch ${FILESDIR}/${P}-gentoo.diff # Parallel make patch
}

src_compile() {
	emake || die
}

src_install() {
	dobin alevt alevt-cap alevt-date
	doman alevt.1x alevt-date.1 alevt-cap.1
	dodoc CHANGELOG COPYRIGHT README

	if use gnome ; then
		insinto /usr/share/pixmaps
		newins contrib/mini-alevt.xpm alevt.xpm
		insinto /usr/share/applications
		doins ${FILESDIR}/alevt.desktop
	fi
}
