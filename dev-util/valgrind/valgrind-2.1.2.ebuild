# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/valgrind/valgrind-2.1.2.ebuild,v 1.4 2005/02/13 15:55:25 griffon26 Exp $

inherit flag-o-matic eutils

DESCRIPTION="An open-source memory debugger for x86-GNU/Linux"
HOMEPAGE="http://valgrind.kde.org"
SRC_URI="http://developer.kde.org/~sewardj/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 -sparc -ppc -alpha"
IUSE="X"
RESTRICT="nostrip"

RDEPEND="virtual/libc
	X? ( virtual/x11 )"
DEPEND="${RDEPEND}
	sys-devel/autoconf"

src_unpack() {
	unpack ${A}
	#ugly but working workaround
	if has_version '>=sys-kernel/linux26-headers-2.6.7' ; then
		epatch "${FILESDIR}/${P}-kernel-headers.patch"
	fi
}
src_compile() {
	local myconf

	filter-flags -fPIC

	use X && myconf="--with-x" || myconf="--with-x=no"
	# note: it does not appear safe to play with CFLAGS
	econf ${myconf} || die
	emake || die "emake failed"
}

src_install() {
	einstall docdir="${D}/usr/share/doc/${PF}/html" || die
	dodoc ACKNOWLEDGEMENTS AUTHORS FAQ.txt NEWS README* TODO
}
