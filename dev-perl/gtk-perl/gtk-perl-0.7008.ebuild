# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/dev-perl/gtk-perl/gtk-perl-0.7008.ebuild,v 1.1 2001/10/15 05:44:57 achim Exp $

A=Gtk-Perl-${PV}.tar.gz
S=${WORKDIR}/Gtk-Perl-${PV}
DESCRIPTION="Perl bindings for GTK"
SRC_URI="ftp://ftp.rz.ruhr-uni-bochum.de/pub/CPAN/authors/id/L/LU/LUPUS/${A}"
HOMEPAGE="http://www.perl.org/"

DEPEND=">=x11-libs/gtk+-1.2.10-r4 sys-devel/perl gnome? ( >=gnome-base/gnome-core-1.4 )"


src_compile() {                           
  perl Makefile.PL 
  try make
}

src_install() {                               
  try make PREFIX=${D}/usr INSTALLMAN3DIR=${D}/usr/share/man/man3 install
  dodoc ChangeLog MANIFEST NOTES README VERSIONS WARNING
}





