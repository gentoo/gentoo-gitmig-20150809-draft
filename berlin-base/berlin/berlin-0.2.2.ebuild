# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/berlin-base/berlin/berlin-0.2.2.ebuild,v 1.5 2002/08/01 11:58:59 seemant Exp $

A0=Berlin-${PV}.tar.bz2
A1=Prague-${PV}.tar.bz2
A2=Warsaw-${PV}.tar.bz2
A3=Babylon-${PV}.tar.bz2
A4=Berlin-Server-${PV}.tar.bz2
A5=Berlin-Clients-Perl-${PV}.tar.bz2
A6=Berlin-Clients-Python-${PV}.tar.bz2
S=${WORKDIR}/Berlin-${PV}
DESCRIPTION="A new alternative to X"
SRC_URI="mirror://sourceforge/berlin/${A0}
		 mirror://sourceforge/berlin/${A1}
		 mirror://sourceforge/berlin/${A2}
		 mirror://sourceforge/berlin/${A3}
		 mirror://sourceforge/berlin/${A4}
		 mirror://sourceforge/berlin/${A5}
		 mirror://sourceforge/berlin/${A6}"

HOMEPAGE="http://www.berlin-consortium.org"

src_compile() {

	./configure --prefix=/opt/berlin  --host=${CHOST} \
	--with-directfb-prefix=/usr --with-omniorb-prefix=/opt/berlin || die
	make || die
}

src_install () {

	make DESTDIR=${D} install || die

}
