# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author David Chamberlain <daybird@gentoo.org>

S=${WORKDIR}/${P}
DESCRIPTION="powerprefs is a PPC-only program to interface with special Powerbook/iBook keys in Linux"
SRC_URI="http://www.cymes.de/members/joker/projects/pbbuttons/tar/${P}.tar.gz"
HOMEPAGE="http://www.cymes.de/members/joker/projects/pbbuttons/pbbuttons.html"

DEPEND="x11-libs/gtk+ sys-apps/pbbuttonsd"

src_compile() {

	./configure --prefix=/usr || die "sorry, ppc-only package"
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
