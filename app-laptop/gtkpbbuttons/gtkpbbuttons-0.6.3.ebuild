# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-laptop/gtkpbbuttons/gtkpbbuttons-0.6.3.ebuild,v 1.4 2004/06/28 02:35:07 vapier Exp $

DESCRIPTION="program to monitor special Powerbook/iBook keys"
HOMEPAGE="http://www.cymes.de/members/joker/projects/pbbuttons/pbbuttons.html"
SRC_URI="http://www.cymes.de/members/joker/projects/pbbuttons/tar/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="-* ~ppc"
IUSE=""

DEPEND=">=x11-libs/gtk+-2.0
	>=media-libs/audiofile-0.1.9
	>=app-laptop/pbbuttonsd-0.6.0"

src_compile() {
	econf || die
	make || die "compile failed"
}

src_install() {
	make install DESTDIR=${D} || die
	dodoc README
}
