# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/app-text/a2ps/a2ps-4.13b-r3.ebuild,v 1.2 2001/06/03 09:54:22 achim Exp $

P=a2ps-4.13b
A=${P}.tar.gz
S=${WORKDIR}/a2ps-4.13
DESCRIPTION="a2ps is an Any to PostScript filter"
SRC_URI="ftp://ftp.enst.fr/pub/unix/a2ps/"${A}
HOMEPAGE="http://www-inf.enst.fr/~demaille/a2ps"

DEPEND="virtual/glibc
	nls? ( sys-devel/gettext )
	>=app-text/ghostscript-6.23
	>=app-text/psutils-1.17
	tex? ( >=app-text/tetex-1.0.7 )"

RDEPEND="virtual/glibc
	>=app-text/ghostscript-6.23
	>=app-text/psutils-1.17
	tex? ( >=app-text/tetex-1.0.7 )"

src_compile() {

  local myconf

  if [ -z "`use nls`" ]
  then
    myconf="--disable-nls"
  fi

  try ./configure --host=${CHOST} --prefix=/usr --sysconfdir=/etc/a2ps \
	--mandir=/usr/share/man --infodir=/usr/share/info --enable-shared --enable-static \
	${myconf}

  try make
}

src_install() {                               

  dodir /usr/share/emacs/site-lisp

  try make prefix=${D}/usr sysconfdir=${D}/etc/a2ps \
	   mandir=${D}/usr/share/man infodir=${D}/usr/share/info \
	   lispdir=${D}/usr/share/emacs/site-lisp install

  dodoc ANNOUNCE AUTHORS ChangeLog COPYING FAQ NEWS README THANKS TODO

}





