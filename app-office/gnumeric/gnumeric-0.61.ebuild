# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/app-office/gnumeric/gnumeric-0.61.ebuild,v 1.1 2000/12/21 19:19:19 achim Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="gnumeric"
SRC_URI="ftp://ftp.gnome.org/pub/GNOME/stable/sources/gnumeric/"${A}
HOMEPAGE="http://www.gnome.org/gnome-office/gnumeric.shtml"

DEPEND=">=sys-devel/perl-5
	>=virtual/python-1.5.2
	>=gnome-base/gal-0.2.2
	>=gnome-libs/gb-0.0.15
	>=gnome-libs/libole2-0.1.7
	bonobo? ( >=gnome-base/bonobo-0.28 
		  >=gnome-libs/libgda-0.2.0 ) "

src_compile() {                           
  cd ${S}
  local myconf
  if [ "`use bonobo`" ]
  then
    myconf="--with-bonobo"
  fi
  LDFLAGS="-L/opt/gnome/lib -lunicode" try ./configure --host=${CHOST} --prefix=/opt/gnome \
	${myconf}  --with-gb
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






