# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/dev-perl/gtk-perl/gtk-perl-0.7000-r1.ebuild,v 1.3 2000/09/15 20:08:51 drobbins Exp $

P=gtk-perl-0.7000
A=Gtk-Perl-0.7000.tar.gz
S=${WORKDIR}/Gtk-Perl-0.7000
DESCRIPTION="Perl bindings for GTK"
SRC_URI="ftp://ftp.rz.ruhr-uni-bochum.de/pub/CPAN/authors/id/K/KJ/KJALB/"${A}
HOEMPAGE="http://www.perl.org/"

src_unpack() {
  unpack ${A}
}

src_compile() {                           
  cd ${S}
  perl Makefile.PL $PERLINSTALL
  try make
}

src_install() {                               
  cd ${S}
  try make prefix=${D}/usr install
  prepman
  dodoc ChangeLog MANIFEST NOTES README VERSIONS WARNING
}





