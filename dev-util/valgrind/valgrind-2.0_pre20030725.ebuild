# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/valgrind/valgrind-2.0_pre20030725.ebuild,v 1.1 2003/08/09 15:27:53 solar Exp $

IUSE="X"

MY_P=${P/2.0_pre/}
S=${WORKDIR}/${MY_P}

DESCRIPTION="An open-source memory debugger for x86-GNU/Linux"
HOMEPAGE="http://developer.kde.org/~sewardj"
SRC_URI="http://developer.kde.org/~sewardj/${MY_P}.tar.bz2"
DEPEND="virtual/glibc
	X? ( virtual/x11 )"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 -sparc -ppc -alpha"

src_compile() {
	local myconf
	use X && myconf="--with-x" || myconf="--with-x=no"
	# note: it does not appear safe to play with CFLAGS
	econf ${myconf} || die
	emake || die
}

src_install() {
	einstall docdir="${D}/usr/share/doc/${PF}" || die
	dodoc ACKNOWLEDGEMENTS AUTHORS COPYING INSTALL NEWS \
		PATCHES_APPLIED README* TODO ChangeLog FAQ.txt
}

