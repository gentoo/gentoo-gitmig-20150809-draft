# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Mark Guertin <gerk@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-apps/pbbuttonsd/pbbuttonsd-0.4.9-r2.ebuild,v 1.1 2002/06/04 03:15:05 gerk Exp $

S=${WORKDIR}/${P}
DESCRIPTION="PBButtons is a PPC-only program to map special Powerbook/iBook keys in Linux"
SRC_URI="http://www.cymes.de/members/joker/projects/pbbuttons/tar/${P}.tar.gz"
HOMEPAGE="http://www.cymes.de/members/joker/projects/pbbuttons/pbbuttons.html"
DEPEND="virtual/glibc"
RDEPEND=""
SLOT=0
LICENSE=GPL

src_compile() {

	./configure \
		--prefix=/usr \
		--sysconfdir=/etc || die "sorry, ppc-only package"
	make || die "sorry, failed to compile pbbuttons"
}

src_install() {

	make sysconfdir=${D}/etc DESTDIR=${D} install || die "failed to install"
	exeinto /etc/init.d ; newexe ${FILESDIR}/pbbuttonsd.rc5 pbbuttonsd
	dodoc README COPYING

}
