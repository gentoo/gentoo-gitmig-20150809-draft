# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/gnome-base/bonobo/bonobo-1.0.6.ebuild,v 1.2 2001/07/01 23:45:58 achim Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="A set of language and system independant CORBA interfaces"
SRC_URI="ftp://ftp.gnome.org/pub/GNOME/stable/sources/${PN}/${A}
         ftp://gnome.eazel.com/pub/gnome/stable/sources/${PN}/${A}"
HOMEPAGE="http://www.gnome.org/"

DEPEND="nls? ( sys-devel/gettext ) sys-devel/perl
        >=gnome-base/oaf-0.6.5
        >=dev-util/xml-i18n-tools-0.8.4
	>=gnome-base/gnome-print-0.25
	>=sys-devel/libtool-1.3.55555"

RDEPEND=">=gnome-base/oaf-0.6.5
	>=gnome-base/gnome-print-0.25"

src_compile() {
  local myconf
  if [ -z "`use nls`" ]
  then
    myconf="--disable-nls"
  fi
  
  # on of the samples in the package need to be regenerated from the idl files
  rm -f ${S}/samples/bonobo-class/Bonobo_Sample_Echo.h
  rm -f ${S}/samples/bonobo-class/Bonobo_Sample_Echo-*.c

  try ./configure --host=${CHOST} --prefix=/opt/gnome --sysconfdir=/etc/opt/gnome ${myconf}
  try pmake
}

src_install() {

  try make prefix=${D}/opt/gnome sysconfdir=${D}/etc/opt/gnome install

  dodoc AUTHORS COPYING* ChangeLog README
  dodoc NEWS TODO
}







