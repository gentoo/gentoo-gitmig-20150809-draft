# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/httptype/httptype-1.3.9.ebuild,v 1.2 2004/08/04 09:30:23 dholm Exp $

DESCRIPTION="httptype is a program that returns the http host software of a website."

HOMEPAGE="http://httptype.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-1"

SLOT="0"
KEYWORDS="~x86 ~ppc"
IUSE=""
DEPEND="dev-lang/perl"
#RDEPEND=""
#S=${WORKDIR}/${P}

src_compile() {
	einfo "Stubbing so Makefile isn't called"
}

src_install() {
	#make PREFIX=${D}/usr install || die
	dobin httptype
	doman httptype.1
	dodoc Changelog Copying README
}
