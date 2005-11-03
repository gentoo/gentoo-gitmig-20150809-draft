# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/suxpanel/suxpanel-0.4a.ebuild,v 1.2 2005/11/03 13:10:41 nelchael Exp $

inherit eutils

DESCRIPTION="SuxPanel is a complete rewrite of MacOS Style Panel, a light-weight X11 desktop panel"
SRC_URI="http://vivid.dat.pl/suxpanel/${P}.tar.bz2"
HOMEPAGE="http://www.gnomefiles.org/app.php?soft_id=84"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE=""

DEPEND=">=x11-libs/gtk+-2
		>=sys-apps/sed-4
		x11-libs/libwnck"

src_unpack() {
	unpack ${A}
	epatch "${FILESDIR}/${P}-Makefile.in.patch"
}

src_install () {
	make DESTDIR="${D}" install || die "Make install failed."
	dobin suxpanel-install.sh
	dodoc README
}
