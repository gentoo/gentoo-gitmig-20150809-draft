# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header $

IUSE="static"

DESCRIPTION="Modules for tc2."
HOMEPAGE="http://tc2.sourceforge.net"
SRC_URI="mirror://sourceforge/tc2/${P}.tar.gz"

SLOT="0"
LICENSE="OpenSoftware"
KEYWORDS="~x86 ~ppc ~sparc alpha ~hppa ~mips ~amd64 ~ia64"

DEPEND=">=dev-libs/tc2-0.5.6"


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
