# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/app-office/gnumeric/gnumeric-0.65.ebuild,v 1.2 2001/06/06 16:55:51 achim Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="gnumeric"
SRC_URI="ftp://ftp.gnome.org/pub/GNOME/stable/sources/gnumeric/"${A}
HOMEPAGE="http://www.gnome.org/gnome-office/gnumeric.shtml"

DEPEND=">=gnome-base/gnome-print-0.29
        >=gnome-base/gal-0.8.0
	>=gnome-libs/libole2-0.2.3
        >=dev-util/xml-i18n-tools-0.8.4
        perl? ( >=sys-devel/perl-5 )
	python? ( >=dev-lang/python-2.0 )
        gb? ( >=gnome-libs/gb-0.0.19 )
        libgda? ( >=gnome-libs/libgda-0.2.9 )
        nls? ( sys-devel/gettext )
	bonobo? ( >=gnome-base/bonobo-1.0 )"

RDEPEND=">=gnome-base/gnome-print-0.29
        >=gnome-base/gal-0.8.0
        gb? ( >=gnome-libs/gb-0.0.19 )
        libgda? ( >=gnome-libs/libgda-0.2.9 )
	bonobo? ( >=gnome-base/bonobo-1.0 ) "

src_unpack() {
  unpack ${A}
  cd ${S}
  cp configure configure.orig
  sed -e 's:"%d,:"%d",:' configure.orig > configure
}

src_compile() {
  local myconf
  if [ -z "`use nls`" ] ; then
    myconf="--disable-nls"
  fi
  if [ "`use bonobo`" ] ; then
    myconf="$myconf --with-bonobo"
  else
    myconf="$myconf --without-bonobo"
  fi
  if [ "`use gb`" ]; then
    #does not work atm
    myconf="$myconf --without-gb"
  else
    myconf="$myconf --without-gb"
  fi
  if [ "`use perl`" ]; then
    myconf="$myconf --with-perl"
  else
    myconf="$myconf --without-perl"
  fi
  if [ "`use python`" ]; then
    myconf="$myconf --with-python"
  else
    myconf="$myconf --without-python"
  fi
  if [ "`use libgda`" ]; then
    myconf="$myconf --with-gda"
  else
    myconf="$myconf --without-gda"
  fi
  try ./configure --host=${CHOST} --prefix=/opt/gnome ${myconf}
  cd ${S}
  try make
}

src_install() {
  try make prefix=${D}/opt/gnome PREFIX=${D}/usr install
  dodoc AUTHORS COPYING *ChangeLog HACKING NEWS README TODO

}






