# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/gnome-office/gnumeric/gnumeric-0.57.ebuild,v 1.2 2000/11/04 18:43:06 achim Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="gnumeric"
SRC_URI="ftp://ftp.gnome.org/pub/GNOME/stable/sources/gnumeric/"${A}
HOMEPAGE="http://www.gnome.org/gnome-office/gnumeric.shtml"

DEPEND=">=sys-devel/perl-5
	|| ( >=sys-devel/python-basic-1.5 >=dev-lang/python-1.5 )
	>=gnome-base/gnome-print-0.24
	>=gnome-base/libglade-0.14
	>=gnome-libs/libunicode-0.4
	>=gnome-libs/gal-0.1
	>=gnome-apps/gb-0.0.12
	>=gnome-libs/libole2-0.1.6"

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




