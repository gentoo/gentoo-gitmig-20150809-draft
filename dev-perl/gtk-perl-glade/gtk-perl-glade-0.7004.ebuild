# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/dev-perl/gtk-perl-glade/gtk-perl-glade-0.7004.ebuild,v 1.3 2001/05/18 20:00:39 achim Exp $

A=Gtk-Perl-${PV}.tar.gz
S=${WORKDIR}/Gtk-Perl-${PV}
DESCRIPTION="Perl bindings for GTK"
SRC_URI="ftp://ftp.rz.ruhr-uni-bochum.de/pub/CPAN/authors/id/L/LU/LUPUS/${A}"
HOEMPAGE="http://www.perl.org/"

DEPEND=">=x11-libs/gtk+-1.2.8
        =dev-perl/gtk-perl-${PV}
	gnome-apps/glade"


src_compile() {            
  perl Makefile.PL
  try make
  cd Glade               
  perl Makefile.PL 
  try make
}

src_install() {                               
  cd Glade
  try make PREFIX=${D}/usr INSTALLMAN3DIR=${D}/usr/share/man/man3 install
}





