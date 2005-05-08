# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/tc2-modules/tc2-modules-0.5.2.ebuild,v 1.7 2005/05/08 22:19:17 agriffis Exp $

IUSE="static"

DESCRIPTION="Modules for tc2."
HOMEPAGE="http://tc2.sourceforge.net"
SRC_URI="mirror://sourceforge/tc2/${P}.tar.gz"

SLOT="0"
LICENSE="OpenSoftware"
KEYWORDS="alpha amd64 ~hppa ia64 ~mips ~ppc ~sparc ~x86"

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
