# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/dev-libs/librep/librep-0.14.ebuild,v 1.1 2001/07/29 00:55:42 hallski Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="Shared library implementing a Lisp dialect"
SRC_URI="ftp://librep.sourceforge.net/pub/librep/${A}"
HOMEPAGE="http://librep.sourceforge.net/"

DEPEND="virtual/glibc
	>=sys-libs/gdbm-1.8.0
	>=dev-libs/gmp-3.1.1
        readline? ( >=sys-libs/readline-4.1 >=sys-libs/ncurses-5.2 )
        sys-apps/texinfo"

src_compile() {

  local myconf

  if [ "`use readline`" ]
  then
    myconf="--with-readline"
  else
    myconf="--without-readline"
  fi

  try ./configure --host=${CHOST} --prefix=/usr --libexecdir=/usr/lib \
        --infodir=/usr/share/info
  try make
}

src_install() {
  try make DESTDIR=${D} install
	#	prefix=${D}/usr aclocaldir=/${D}/usr/share/aclocal \
	#   libexecdir=${D}/usr/lib infodir=${D}/usr/share/info \
	#   datadir=${D}/usr/share install

  insinto /usr/include
  doins src/rep_config.h
  dodoc AUTHORS BUGS COPYING ChangeLog NEWS README THANKS TODO DOC
  docinto doc
  dodoc doc/*
}

