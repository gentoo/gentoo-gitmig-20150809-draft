# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/app-office/gnumeric/gnumeric-0.57.ebuild,v 1.1 2000/10/14 12:30:12 achim Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="gnumeric"
SRC_URI="ftp://ftp.gnome.org/pub/GNOME/stable/sources/gnumeric/"${A}
HOMEPAGE="http://www.gnome.org/gnome-office/gnumeric.shtml"

src_compile() {                           
  cd ${S}
  LDFLAGS="-L/opt/gnome/lib -lunicode" try ./configure --host=${CHOST} --prefix=/opt/gnome \
	--with-catgets --without-bonobo --with-gb
  cd plugins/perl
  cp Makefile Makefile.orig
  sed -e "s:perl Makefile\.PL:perl Makefile\.PL $PERLINSTALL:" \
	Makefile.orig > Makefile
  cd ${S}
  try make
}

src_install() {                               
  cd ${S}
  try make prefix=${D}/opt/gnome install
  dodoc AUTHORS COPYING *ChangeLog HACKING NEWS README TODO

}




