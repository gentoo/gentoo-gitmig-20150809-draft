# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/valgrind/valgrind-2.1.1-r1.ebuild,v 1.5 2005/02/13 15:55:25 griffon26 Exp $

inherit flag-o-matic eutils
RESTRICT="nostrip"

DESCRIPTION="An open-source memory debugger for x86-GNU/Linux"
HOMEPAGE="http://valgrind.kde.org"
SRC_URI="http://developer.kde.org/~sewardj/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 -sparc -ppc -alpha -amd64"
IUSE="X"

DEPEND="virtual/libc
	sys-devel/autoconf
	sys-devel/automake
	X? ( virtual/x11 )"

src_unpack() {
	unpack ${A}
	cd ${S}
	# add pic aware cpuid patch from cvs. Bug #54068
	epatch ${FILESDIR}/${PN}-2.1.1-pic.patch
	einfo "Running aclocal/automake"
	aclocal && automake
}

src_compile() {
	local myconf

	#filter-flags -fPIC

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
