# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libtc/libtc-1.0.3.ebuild,v 1.1 2004/02/28 14:20:34 zypher Exp $

IUSE="static"

S=${WORKDIR}/${P}
DESCRIPTION="libtc is a library of useful functions and function often missing on some systems -- supplements libc functions."
HOMEPAGE="http://libtc.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~hppa ~mips ~ia64 ~amd64"

RDEPEND="virtual/glibc"
DEPEND="${RDEPEND}"

src_compile() {

	local myconf
	myconf="--with-gnu-ld"

	use static && myconf="${myconf} --enable-static"

	econf ${myconf} || die "configure failed"

	make || die
}

src_install() {
	make DESTDIR=${D} install || die
}
