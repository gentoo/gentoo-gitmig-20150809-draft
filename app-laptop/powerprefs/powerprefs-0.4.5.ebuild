# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-laptop/powerprefs/powerprefs-0.4.5.ebuild,v 1.4 2004/06/14 08:36:08 kloeri Exp $

DESCRIPTION="powerprefs is a program to interface with pbbuttonsd (Powerbook/iBook) keys in Linux"
SRC_URI="http://www.cymes.de/members/joker/projects/pbbuttons/tar/${P}.tar.gz"
HOMEPAGE="http://www.cymes.de/members/joker/projects/pbbuttons/pbbuttons.html"
KEYWORDS="~ppc"
IUSE=""
SLOT="0"
LICENSE="GPL-2"

DEPEND=">=x11-libs/gtk+-2.0
		>=app-laptop/pbbuttonsd-0.6.0"

src_compile() {
	econf --prefix=/usr || die "powerprefs configure failed"
	make || die "sorry, powerprefs compile failed"
}

src_install() {
	make \
		prefix=${D}/usr \
		datadir=${D}/usr/share \
		mandir=${D}/usr/share/man \
		infodir=${D}/usr/share/info \
		install || die "sorry, failed to install powerprefs"
	dodoc README COPYING
}
