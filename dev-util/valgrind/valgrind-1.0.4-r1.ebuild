# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/valgrind/valgrind-1.0.4-r1.ebuild,v 1.4 2003/09/06 20:28:41 msterret Exp $

IUSE="X"

S=${WORKDIR}/${P}
DESCRIPTION="An open-source memory debugger for x86-GNU/Linux"
HOMEPAGE="http://developer.kde.org/~sewardj"
SRC_URI="http://developer.kde.org/~sewardj/${P}.tar.bz2
	kcachegrind.sourceforge.net/patch-0.2b-valgrind-1.0.4.gz"
DEPEND="virtual/glibc
	X? ( virtual/x11 )"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 -sparc -ppc -alpha"

src_unpack() {
	unpack ${P}.tar.bz2
	cd $S
	gzip -cd ${DISTDIR}/patch-0.2b-valgrind-1.0.4.gz | patch -p1
}

src_compile() {
	local myconf

	use X	&& myconf="--with-x"	|| myconf="--with-x=no"

	# note: it does not appear safe to play with CFLAGS
	econf ${myconf} || die
	emake || die
}

src_install() {
	einstall docdir="${D}/usr/share/doc/${PF}" || die
	dodoc README* COPYING ChangeLog TODO ACKNOWLEDGEMENTS AUTHORS NEWS
}
