# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header $

IUSE="static"

DESCRIPTION="Modules for dev-libs/tc2."
HOMEPAGE="http://tc2.sourceforge.net"
SRC_URI="mirror://sourceforge/tc2/${P}.tar.gz"

SLOT="0"
LICENSE="MIT"
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~hppa ~mips ~ia64 ~amd64"


RDEPEND=">=dev-libs/tc2-0.6.0"


src_compile() {
	local myconf
	myconf="--with-gnu-ld"
	use static && myconf="${myconf} --enable-static"
	econf ${myconf} || die "configure failed"
	make || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS ChangeLog COPYING
}
