# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/sys-apps/pbbuttonsd/pbbuttonsd-0.4.9-r1.ebuild,v 1.4 2002/07/14 19:20:18 aliz Exp $

S=${WORKDIR}/${P}
DESCRIPTION="PBButtons is a PPC-only program to map special Powerbook/iBook keys in Linux"
SRC_URI="http://www.cymes.de/members/joker/projects/pbbuttons/tar/${P}.tar.gz"
HOMEPAGE="http://www.cymes.de/members/joker/projects/pbbuttons/pbbuttons.html"
KEYWORDS="x86"
SLOT="0"
LICENSE="GPL-2"

DEPEND=""

src_compile() {

	./configure \
		--prefix=/usr \
		--sysconfdir=/etc || die "sorry, ppc-only package"
	make || die "sorry, failed to compile pbbuttons"
}

src_install() {

	make sysconfdir=${D}/etc DESTDIR=${D} install || die "failed to install"
	dodoc README COPYING

}
