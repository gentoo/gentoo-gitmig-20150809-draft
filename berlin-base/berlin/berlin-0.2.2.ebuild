# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Your Name <your email>
# $Header: /var/cvsroot/gentoo-x86/berlin-base/berlin/berlin-0.2.2.ebuild,v 1.1 2001/05/02 22:48:26 achim Exp $

A0=Berlin-${PV}.tar.bz2
A1=Prague-${PV}.tar.bz2
A2=Warsaw-${PV}.tar.bz2
A3=Babylon-${PV}.tar.bz2
A4=Berlin-Server-${PV}.tar.bz2
A5=Berlin-Clients-Perl-${PV}.tar.bz2
A6=Berlin-Clients-Python-${PV}.tar.bz2
A="$A0 $A1 $A2 $A3 $A4 $A5 $A6"
S=${WORKDIR}/Berlin-${PV}
DESCRIPTION="A new alternative to X"
SRC_URI="http://prdownloads.sourceforge.net/berlin/${A0}
         http://prdownloads.sourceforge.net/berlin/${A1}
         http://prdownloads.sourceforge.net/berlin/${A2}
         http://prdownloads.sourceforge.net/berlin/${A3}
         http://prdownloads.sourceforge.net/berlin/${A4}
         http://prdownloads.sourceforge.net/berlin/${A5}
         http://prdownloads.sourceforge.net/berlin/${A6}"

HOMEPAGE="http://www.berlin-consortium.org"

DEPEND=""

src_compile() {

    try	./configure --prefix=/opt/berlin  --host=${CHOST} \
	--with-directfb-prefix=/usr --with-omniorb-prefix=/opt/berlin
    try make
}

src_install () {

    try make DESTDIR=${D} install

}

