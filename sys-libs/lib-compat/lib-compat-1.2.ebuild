# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-libs/lib-compat/lib-compat-1.2.ebuild,v 1.7 2004/09/03 18:24:07 pvdabeel Exp $

IUSE=""

S=${WORKDIR}/${P}
DESCRIPTION="Compatibility C++ and libc5 and libc6 libraries for programs new and old"
HOMEPAGE="http://www.gentoo.org/"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc ~sparc ~alpha"

DEPEND="virtual/libc"

src_install() {
	into /usr
	dolib.so ${ARCH}/*.so*
	preplib /usr
}
