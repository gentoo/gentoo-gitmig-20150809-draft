# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/tc2/tc2-0.5.6.ebuild,v 1.1 2004/02/28 14:26:35 zypher Exp $

IUSE="static debug"

S=${WORKDIR}/${P}
DESCRIPTION="TC2 is a library to simplify writing of modular programs."
HOMEPAGE="http://tc2.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

SLOT="0"
LICENSE="OpenSoftware"
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~hppa ~mips ~ia64 ~amd64"


DEPEND=">=dev-libs/libtc-1.0.3"


src_compile() {

	local myconf
	myconf="--with-gnu-ld"

	use debug && myconf="${myconf} --enable-debug"

	use static && myconf="${myconf} --enable-static"

	econf ${myconf} || die "configure failed"

	make || die

}

src_install() {
	make DESTDIR=${D} install || die
}
