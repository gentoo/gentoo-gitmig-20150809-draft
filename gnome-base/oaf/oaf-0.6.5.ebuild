# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/gnome-base/oaf/oaf-0.6.5.ebuild,v 1.3 2001/06/04 03:33:03 achim Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="Object Activation Framework for GNOME"
SRC_URI="ftp://ftp.gnome.org/pub/GNOME/unstable/sources/${PN}/${A}
         ftp://gnome.eazel.com/pub/gnome/unstable/sources/${PN}/${A}"

DEPEND="virtual/glibc >=sys-devel/perl-5
        >=app-arch/rpm-3.0.6
	>=gnome-base/gnome-env-1.0
	>=gnome-base/ORBit-0.5.7
	>=gnome-base/libxml-1.8.11
        nls? ( sys-devel/gettext )"

RDEPEND="virtual/glibc
        >=app-arch/rpm-3.0.6
	>=gnome-base/gnome-env-1.0
	>=gnome-base/ORBit-0.5.7
	>=gnome-base/libxml-1.8.11"

src_unpack() {
  unpack ${A}
  cd ${S}
  cp -a configure configure.orig
  sed -e "s:perl5\.00404:perl5.6.1:" configure.orig > configure
}

src_compile() {
  local myconf
  if [ -z "`use nls`" ]
  then
    myconf="--disable-nls"
  fi
  try ./configure --host=${CHOST} --prefix=/opt/gnome --sysconfdir=/etc/opt/gnome --datadir=/opt/gnome/share ${myconf}
  try make
}

src_install() {
  
  try make prefix=${D}/opt/gnome sysconfdir=${D}/etc/opt/gnome \
  	datadir=${D}/opt/gnome/share install
  dodoc AUTHORS COPYING* ChangeLog README
  dodoc NEWS TODO
}

pkg_postinst() {
	ldconfig -r ${ROOT}
}



