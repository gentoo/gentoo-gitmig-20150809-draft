# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/gnome-base/libglade/libglade-0.15.ebuild,v 1.2 2000/11/25 14:01:31 achim Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="libglade"
SRC_URI="ftp://ftp.gnome.org/pub/GNOME/stable/sources/${PN}/${A}"
HOMEPAGE="http://www.gnome.org/"

DEPEND=">=gnome-base/gnome-libs-1.2.4
	>=gnome-base/libxml-1.8.10
	bonobo? ( >=gnome-base/bonobo-0.28 )"

src_unpack() {
  unpack ${A}
  cd ${S}
  # Bonobo does not work at the moment
  #cp configure.in configure.in.orig
  #sed -e "s:have_bonobo=true:have_bonobo=false:" configure.in.orig > configure.in
  #autoconf configure.in > configure
}
src_compile() {                           
  cd ${S}
  local myopts
  if [ "`use bonobo`" ]
  then
     myopts="--enable-bonobo"
  else
     myopts="--disable-bonobo"
  fi
  try ./configure --host=${CHOST} --prefix=/opt/gnome ${myopts}
  try make 
}

src_install() {                               
  cd ${S}
  try make prefix=${D}/opt/gnome install
  dodoc AUTHORS COPYING* ChangeLog NEWS
  dodoc doc/*.txt
}









