# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/gtkpbbuttons/gtkpbbuttons-0.5.2.ebuild,v 1.9 2003/08/17 21:31:56 vapier Exp $

DESCRIPTION="PPC-only program to monitor special Powerbook/iBook keys in Linux"
HOMEPAGE="http://www.cymes.de/members/joker/projects/pbbuttons/pbbuttons.html"
SRC_URI="http://www.cymes.de/members/joker/projects/pbbuttons/tar/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="-* ppc"

DEPEND="=x11-libs/gtk+-1.2*
	media-libs/audiofile
	>=sys-apps/pbbuttonsd-0.5"

src_compile() {
	econf || die
	make || die "compile failed"
}

src_install() {
	make install DESTDIR=${D} || die
	dodoc README COPYING
}
