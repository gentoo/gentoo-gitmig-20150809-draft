# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# /home/cvsroot/gentoo-x86/gnome-office/gnumeric/gnumeric-0.64-r1.ebuild,v 1.1 2001/05/17 13:29:30 achim Exp

A=Guppi-${PV}.tar.gz
S=${WORKDIR}/Guppi-${PV}
DESCRIPTION="GNOME Plottin Tool"
SRC_URI="ftp://ftp.gnome.org/pub/GNOME/stable/sources/Guppi/${A}"
HOMEPAGE="http://www.gnome.org/guppi/"

DEPEND="nls? ( sys-devel/gettext )
	>=dev-util/guile-1.4
	>=gnome-office/gnumeric-0.65
        >=dev-util/xml-i18n-tools-0.8.4
	python? ( >=dev-lang/python-2.0 )
	bonobo? ( >=gnome-base/bonobo-0.37 )"

RDEPEND=">=gnome-base/gdk-pixbuf-0.11.0 
	>=dev-util/guile-1.4
        >=gnome-base/gnome-print-0.29
	bonobo? ( >=gnome-base/bonobo-0.37 )"

src_compile() {                           
  local myconf

  if [ "`use bonobo`" ]
  then
    myconf="--enable-bonobo"
  else
    myconf="--disable-bonobo"
  fi

  if [ "`use python`" ]
  then
    myconf="--enable-python"
  else
    myconf="--disable-python"
  fi
  if [ -z "`use nls`" ] ; then
    myconf="$myconf --disable-nls"
  fi
  if [ -z "`use readline`" ] ; then
    myconf="$myconf --disable-guile-readline"
  fi

  try ./configure --host=${CHOST} --prefix=/opt/gnome --enable-gnumeric \
	${myconf}

  try make  # Doesn't work with -j 4 (hallski)
}

src_install() {                               
  try make prefix=${D}/opt/gnome PREFIX=${D}/usr install
  dodoc AUTHORS COPYING ChangeLog NEWS README TODO
}






