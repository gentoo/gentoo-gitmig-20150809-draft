# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/dev-libs/gmp/gmp-3.1.1-r1.ebuild,v 1.2 2001/05/29 17:28:19 achim Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="Library for arithmetic on arbitrary precision integers, rational numbers, and floating-point numbers"
SRC_URI="ftp://gatekeeper.dec.com/pub/GNU/gmp/${A}
	 ftp://prep.ai.mit.edu/gnu/gmp/${A}"
HOMEPAGE="http://www.gnu.org/software/gmp/gmp.html"
DEPEND="virtual/glibc
	>=sys-devel/m4-1.4o"
RDEPEND="virtual/glibc"

src_compile() {                           
  try ./configure --prefix=/usr --infodir=/usr/share/info --host=${CHOST} \
	--enable-mpfr --enable-mpbsd
  try make
}

src_install() {                               

  try make prefix=${D}/usr infodir=${D}/usr/share/info install

  dodoc AUTHORS ChangeLog COPYING* NEWS README
  dodoc doc/assembly_code doc/configuration
  dodoc doc/isa_abi_headache doc/multiplication
  docinto html
  dodoc doc/*.html

}



