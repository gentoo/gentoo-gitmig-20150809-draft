# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/sys-libs/lib-compat/lib-compat-1.0-r2.ebuild,v 1.5 2002/07/17 00:45:39 seemant Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Compatibility c++ and libc5 libraries for programs new and old"
SRC_URI="mirror://gentoo/${PN}.tar.gz"
HOMEPAGE="http://www.gentoo.org/"


SLOT="0"
KEYWORDS="x86 ppc"
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
