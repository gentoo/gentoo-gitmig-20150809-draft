# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/powerprefs/powerprefs-0.3.1.ebuild,v 1.5 2003/04/30 20:56:00 vladimir Exp $

S=${WORKDIR}/${P}
DESCRIPTION="powerprefs is a program to interface with pbbuttonsd (Powerbook/iBook) keys in Linux"
SRC_URI="http://www.cymes.de/members/joker/projects/pbbuttons/tar/${P}.tar.gz"
HOMEPAGE="http://www.cymes.de/members/joker/projects/pbbuttons/pbbuttons.html"
KEYWORDS="ppc ~x86"
SLOT="0"
LICENSE="GPL-2"

DEPEND="x11-libs/gtk+ >=sys-apps/pbbuttonsd-0.5" 

src_compile() {
	./configure --prefix=/usr || die "sorry, powerprefs configure failed"
	make || die "sorry, powerprefs compile failed"
}

src_install() {
	make \
		prefix=${D}/usr \
		mandir={D}/usr/share/man \
		infodir={D}/usr/share/info \
		install || die "sorry, failed to install powerprefs"

	dodoc README COPYING
}
