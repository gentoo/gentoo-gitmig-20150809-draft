# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/dev-perl/gtk-perl/gtk-perl-0.7000-r1.ebuild,v 1.6 2000/11/04 12:54:30 achim Exp $

P=gtk-perl-0.7000
A=Gtk-Perl-0.7000.tar.gz
S=${WORKDIR}/Gtk-Perl-0.7000
DESCRIPTION="Perl bindings for GTK"
SRC_URI="ftp://ftp.rz.ruhr-uni-bochum.de/pub/CPAN/authors/id/K/KJ/KJALB/"${A}
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





