# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/dev-perl/gtk-perl/gtk-perl-0.7004.ebuild,v 1.1 2001/02/16 20:01:14 achim Exp $

A=Gtk-Perl-${PV}.tar.gz
S=${WORKDIR}/Gtk-Perl-${PV}
DESCRIPTION="Perl bindings for GTK"
SRC_URI="ftp://ftp.rz.ruhr-uni-bochum.de/pub/CPAN/authors/id/L/LU/LUPUS/${A}"
HOEMPAGE="http://www.perl.org/"

DEPEND=">=x11-libs/gtk+-1.2.8"


src_compile() {                           
  cd ${S}
  perl Makefile.PL 
  try make
}

src_install() {                               
  cd ${S}
  try make PREFIX=${D}/usr install
  dodoc ChangeLog MANIFEST NOTES README VERSIONS WARNING
}





