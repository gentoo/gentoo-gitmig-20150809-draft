# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/gnome-base/bonobo/bonobo-1.0.8-r1.ebuild,v 1.2 2001/08/23 10:05:13 hallski Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="A set of language and system independant CORBA interfaces"
SRC_URI="ftp://ftp.gnome.org/pub/GNOME/stable/sources/${PN}/${A}"
HOMEPAGE="http://www.gnome.org/"

DEPEND="nls? ( sys-devel/gettext ) sys-devel/perl
        >=gnome-base/oaf-0.6.5
        >=dev-util/xml-i18n-tools-0.8.4
	>=gnome-base/ORBit-0.5.8
	>=gnome-base/gnome-print-0.25"

RDEPEND=">=gnome-base/oaf-0.6.5
	 >=gnome-base/ORBit-0.5.8
	 >=gnome-base/gnome-print-0.25"

src_unpack() {
  unpack ${A}
  cd ${S}/po
  cp pl.po pl.po.orig
  sed -e "s:\\\\\"::g" pl.po.orig > pl.po
  rm pl.po.orig
}

src_compile() {
  local myconf
  if [ -z "`use nls`" ]
  then
    myconf="--disable-nls"
  fi
  
  # on of the samples in the package need to be regenerated from the idl files
  rm -f ${S}/samples/bonobo-class/Bonobo_Sample_Echo.h
  rm -f ${S}/samples/bonobo-class/Bonobo_Sample_Echo-*.c

  ./configure --host=${CHOST} --prefix=/opt/gnome --sysconfdir=/etc/opt/gnome ${myconf} || die
  make || die # make -j 4 didn't work
}

src_install() {

  make prefix=${D}/opt/gnome sysconfdir=${D}/etc/opt/gnome install || die

  dodoc AUTHORS COPYING* ChangeLog README
  dodoc NEWS TODO
}







