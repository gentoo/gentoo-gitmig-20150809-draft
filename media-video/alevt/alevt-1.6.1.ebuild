# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/alevt/alevt-1.6.1.ebuild,v 1.5 2004/11/15 10:35:04 phosphan Exp $

inherit eutils

DESCRIPTION="Teletext viewer for X11"
HOMEPAGE="http://www.goron.de/~froese/"
SRC_URI="http://www.ibiblio.org/pub/Linux/apps/video/${P}.tar.gz
	http://fresh.t-systems-sfr.com/linux/src/${P}.tar.gz"

IUSE="gnome"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc"

DEPEND="virtual/x11
	>=media-libs/libpng-1.0.12"

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -i -e "s:^OPT=.*:OPT = ${CFLAGS} -s:" Makefile
	epatch ${FILESDIR}/${P}-gentoo.diff
}

src_compile() {
	emake || die
}

src_install() {
	dobin alevt alevt-cap alevt-date
	doman alevt.1x alevt-date.1 alevt-cap.1
	dodoc CHANGELOG COPYRIGHT README

	if use gnome; then
		insinto /usr/share/pixmaps
		newins contrib/mini-alevt.xpm alevt.xpm
		insinto /usr/share/applications
		doins ${FILESDIR}/alevt.desktop
	fi
}
