# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/dev-libs/librep/librep-0.13.4.ebuild,v 1.2 2001/01/20 01:13:36 achim Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="Shared library implementing a Lisp dialect"
SRC_URI="ftp://librep.sourceforge.net/pub/librep/"${A}
HOMEPAGE="http://librep.sourceforge.net/"

DEPEND=">=sys-apps/bash-2.04
	>=sys-libs/gdbm-1.8.0
	>=sys-libs/glibc-2.1.3
	>=sys-libs/gpm-1.19.3
	>=sys-libs/ncurses-5.1
	>=dev-libs/gmp-3.1.1"

src_unpack() {
  unpack ${A}
}

src_compile() {                           
  cd ${S}
  try ./configure --host=${CHOST} --prefix=/usr --libexecdir=/usr/lib
  try make
}

src_install() {                               
  cd ${S}
  try make prefix=${D}/usr aclocaldir=/${D}/usr/share/aclocal \
	   libexecdir=${D}/usr/lib install
  prepinfo
  insinto /usr/include
  doins src/rep_config.h
  dodoc AUTHORS BUGS COPYING ChangeLog NEWS README THANKS TODO DOC
  docinto doc
  dodoc doc/*
}

pkg_postinst() {
	/usr/sbin/env-update
}
