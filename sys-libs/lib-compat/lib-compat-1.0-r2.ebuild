# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/sys-libs/lib-compat/lib-compat-1.0-r2.ebuild,v 1.7 2002/08/14 04:18:28 murphy Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Compatibility c++ and libc5 libraries for programs new and old"
SRC_URI="mirror://gentoo/${PN}.tar.gz"
HOMEPAGE="http://www.gentoo.org/"


SLOT="0"
KEYWORDS="x86 ppc sparc sparc64"
LICENSE="GPL"

DEPEND="virtual/glibc"

src_unpack () {
  mkdir ${S}
  cd ${S}
  unpack ${A}
}


src_install() {

    into /usr
    dolib.so *.so*
    preplib /usr

}
