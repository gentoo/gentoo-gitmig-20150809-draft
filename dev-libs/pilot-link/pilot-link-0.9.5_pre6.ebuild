# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# AJ Lewis <aj@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/dev-libs/pilot-link/pilot-link-0.9.5_pre6.ebuild,v 1.1 2001/06/12 01:51:52 aj Exp $

A=${PN}.0.9.5-pre6.tar.gz
S=${WORKDIR}/${PN}.0.9.5-pre6
DESCRIPTION="A suite of tools contains a series of conduits for moving
information to and from your Palm device and your desktop or workstation
system."

SRC_URI="http://www.gnu-designs.com/pilot-link/source/${A}"
HOMEPAGE="http://www.gnu-designs.com/pilot-link/"
DEPEND="virtual/glibc"

src_compile() {
   try ./configure --prefix=/usr/ --mandir=/usr/share/man \
       --infodir=/usr/share/info  --with-itcl=no --with-tk=no \
       --with-python=no --with-java=no --with-perl5=no
   try make clean
   try make ${MAKEOPTS}
}

src_install() {
   try make prefix=${D}/usr/ mandir=${D}/usr/share/man infodir=${D}/usr/share/info install
   dodoc COPYING COPYING.LIB ChangeLog README TODO doc/syncabs.sgml
}

