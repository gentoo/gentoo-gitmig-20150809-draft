# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/valgrind/valgrind-2.1.1.ebuild,v 1.1 2004/04/05 18:30:40 caleb Exp $

inherit flag-o-matic

DESCRIPTION="An open-source memory debugger for x86-GNU/Linux"
HOMEPAGE="http://valgrind.kde.org"
SRC_URI="http://developer.kde.org/~sewardj/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 -sparc -ppc -alpha"
IUSE="X"

DEPEND="virtual/glibc
	sys-devel/autoconf
	X? ( virtual/x11 )"

src_compile() {
	local myconf

	filter-flags -fPIC

	use X && myconf="--with-x" || myconf="--with-x=no"
	# note: it does not appear safe to play with CFLAGS
	econf ${myconf} || die
	emake || die
}

src_install() {
	einstall docdir="${D}/usr/share/doc/${PF}" || die
	dodoc ACKNOWLEDGEMENTS AUTHORS INSTALL NEWS \
		PATCHES_APPLIED README* TODO ChangeLog FAQ.txt
}
