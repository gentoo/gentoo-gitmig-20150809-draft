# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/gnome-office/gnumeric/gnumeric-0.59a.ebuild,v 1.1 2000/11/25 13:04:23 achim Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="gnumeric"
SRC_URI="ftp://ftp.gnome.org/pub/GNOME/stable/sources/gnumeric/"${A}
HOMEPAGE="http://www.gnome.org/gnome-office/gnumeric.shtml"

DEPEND=">=sys-devel/perl-5
	|| ( >=sys-devel/python-basic-1.5 >=dev-lang/python-1.5 )
	>=gnome-base/gnome-print-0.25
	>=gnome-base/libglade-0.15
	>=gnome-base/libunicode-0.4
	>=gnome-base/gal-0.2
	>=gnome-libs/gb-0.0.15
	>=gnome-libs/libole2-0.1.7"

src_compile() {                           
  cd ${S}
  LDFLAGS="-L/opt/gnome/lib -lunicode" try ./configure --host=${CHOST} --prefix=/opt/gnome \
	--with-bonobo --with-gb
  cd plugins/perl
  cp Makefile Makefile.orig
#  sed -e "s:perl Makefile\.PL:perl Makefile\.PL $PERLINSTALL:" \
#	Makefile.orig > Makefile
  cd ${S}
  try make
}

src_install() {                               
  cd ${S}
  try make prefix=${D}/opt/gnome PREFIX=${D}/usr install
  dodoc AUTHORS COPYING *ChangeLog HACKING NEWS README TODO

}






