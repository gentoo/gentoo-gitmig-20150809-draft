# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-util/valgrind/valgrind-1.0.3.ebuild,v 1.1 2002/09/29 19:47:47 blocke Exp $

S=${WORKDIR}/${P}
DESCRIPTION="An open-source memory debugger for x86-GNU/Linux"
HOMEPAGE="http://developer.kde.org/~sewardj"
SRC_URI="http://developer.kde.org/~sewardj/${P}.tar.bz2
		 http://developer.kde.org/~sewardj/valgrind-1.0.3-gcc3.1-and-above-patch1.txt"
DEPEND="virtual/glibc
	X? ( virtual/x11 )"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 -sparc -sparc64 -ppc -alpha"

src_unpack()
{
	unpack ${P}.tar.bz2

	cd ${S}
	patch -p1 < ${DISTDIR}/valgrind-1.0.3-gcc3.1-and-above-patch1.txt
}

src_compile() 
{	
	local myconf

	use X	&& myconf="--with-x"	|| myconf="--with-x=no" 

	# note: it does not appear safe to play with CFLAGS
	econf ${myconf} || die
	emake || die
}

src_install() 
{
	einstall docdir="${D}/usr/share/doc/${PF}" || die
	dodoc README* COPYING ChangeLog TODO ACKNOWLEDGEMENTS AUTHORS NEWS
}

