# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libtc/libtc-0.6.4.ebuild,v 1.1 2003/10/30 02:30:45 seemant Exp $

IUSE="static"

S=${WORKDIR}/${P}
DESCRIPTION="libtc is a library of useful functions and function often missing on some systems -- supplements libc functions."
HOMEPAGE="http://libtc.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~hppa ~mips ~arm ~ia64 ~amd64"

DEPEND="virtual/glibc"


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
