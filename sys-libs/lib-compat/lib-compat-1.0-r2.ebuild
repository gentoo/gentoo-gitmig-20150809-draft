# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-libs/lib-compat/lib-compat-1.0-r2.ebuild,v 1.10 2002/10/05 05:39:27 drobbins Exp $

IUSE="x86"

S=${WORKDIR}/${P}
DESCRIPTION="Compatibility c++ and libc5 libraries for programs new and old"
SRC_URI="x86? ( mirror://gentoo/${PN}.tar.gz )"
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
    use x86 && {
        into /usr
        dolib.so *.so*
        preplib /usr
    }
}
