# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/dev-libs/gmp/gmp-3.1.ebuild,v 1.4 2000/11/01 04:44:15 achim Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="Library for arithmetic on arbitrary precision integers, rational numbers, and floating-point numbers"
SRC_URI="ftp://gatekeeper.dec.com/pub/GNU/gmp/${A}
	 ftp://prep.ai.mit.edu/gnu/gmp/${A}"
HOMEPAGE="http://www.gnu.org/software/gmp/gmp.html"
DEPEND=">=sys-libs/glibc-2.1.3"

src_unpack() {
  unpack ${A}
}

src_compile() {                           
  cd ${S}
  try ./configure --prefix=/usr
  try make
}

src_install() {                               
  cd ${S}
  try make prefix=${D}/usr install
  prepinfo 
  dodoc AUTHORS ChangeLog COPYING* NEWS README
  dodoc doc/assembly_code doc/configuration
  dodoc doc/isa_abi_headache doc/multiplication
  docinto html
  dodoc doc/*.html
}





