# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/dev-util/guile/guile-1.4-r1.ebuild,v 1.6 2000/11/01 04:44:16 achim Exp $

P=guile-1.4
A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="Guile is an interpreter for Scheme"
SRC_URI="ftp://gatekeeper.dec.com/pub/GNU/guile/${A}
	 ftp://prep.ai.mit.edu/gnu/guile/${A}"
HOMEPAGE="http://www.gnu.org/software/guile/"

DEPEND=">=sys-apps/bash-2.04 
	>=sys-apps/gawk-3.0.6 
	>=sys-libs/glibc-2.1.3 
	>=sys-libs/ncurses-5.1
	>=sys-libs/gpm-1.19.3"


src_unpack() {
  unpack ${A}
}

src_compile() {                           
  cd ${S}
  try ./configure --host=${CHOST} --prefix=/usr --with-threads --with-modules
  try make
}

src_install() {                               
  cd ${S}
  try make prefix=${D}/usr install
  dodoc AUTHORS COPYING ChangeLog GUILE-VERSION HACKING NEWS README SNAPSHOTS THANKS
}




