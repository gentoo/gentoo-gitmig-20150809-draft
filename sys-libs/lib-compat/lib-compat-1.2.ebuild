# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-libs/lib-compat/lib-compat-1.2.ebuild,v 1.3 2003/06/22 05:10:31 seemant Exp $

IUSE=""

S=${WORKDIR}/${P}
DESCRIPTION="Compatibility C++ and libc5 and libc6 libraries for programs new and old"
HOMEPAGE="http://www.gentoo.org/"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~sparc ~alpha"

DEPEND="virtual/glibc"

src_install() {
	into /usr
	dolib.so ${ARCH}/*.so*
	preplib /usr
}
