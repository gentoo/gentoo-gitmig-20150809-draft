# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/valgrind/valgrind-1.9.6.ebuild,v 1.1 2003/05/12 10:38:24 mkennedy Exp $

DESCRIPTION="An open-source memory debugger for x86-GNU/Linux"
HOMEPAGE="http://developer.kde.org/~sewardj"
SRC_URI="http://developer.kde.org/~sewardj/${P}.tar.bz2"
DEPEND="virtual/glibc
	X? ( virtual/x11 )"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 -sparc -ppc -alpha"
IUSE="X"

S=${WORKDIR}/${P}

src_compile() {	
	local myconf
	use X && myconf="--with-x" || myconf="--with-x=no" 
	# note: it does not appear safe to play with CFLAGS
	econf ${myconf} || die
	emake || die
}

src_install() {
	einstall docdir="${D}/usr/share/doc/${PF}" || die
	dodoc README* COPYING ChangeLog TODO ACKNOWLEDGEMENTS AUTHORS NEWS
}
