# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-laptop/pbbuttonsd/pbbuttonsd-0.4.10a.ebuild,v 1.5 2004/06/28 02:35:55 vapier Exp $

DESCRIPTION="program to map special Powerbook/iBook keys"
HOMEPAGE="http://www.cymes.de/members/joker/projects/pbbuttons/pbbuttons.html"
SRC_URI="http://www.cymes.de/members/joker/projects/pbbuttons/tar/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="-* ppc"
IUSE=""

DEPEND="virtual/libc"
RDEPEND=""

src_compile() {
	./configure \
		--prefix=/usr \
		--sysconfdir=/etc \
		|| die "sorry, ppc-only package"
	make || die "sorry, failed to compile pbbuttons"
}

src_install() {
	make sysconfdir=${D}/etc DESTDIR=${D} install || die "failed to install"
	exeinto /etc/init.d ; newexe ${FILESDIR}/pbbuttonsd.rc5 pbbuttonsd
	dodoc README
}
