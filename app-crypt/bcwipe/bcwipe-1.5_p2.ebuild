# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/bcwipe/bcwipe-1.5_p2.ebuild,v 1.5 2004/09/04 14:17:08 slarti Exp $

DESCRIPTION="BCWipe secure file removal utility"
HOMEPAGE="http://www.jetico.com/"
SRC_URI="http://www.jetico.com/linux/BCWipe-${PV/_p/-}.tgz
	http://www.jetico.com/linux/BCWipe.doc.tgz"

LICENSE="bestcrypt"
SLOT="0"
IUSE=""
KEYWORDS="~x86 ~ppc ~amd64"

DEPEND="virtual/libc"
RDEPEND=""

S=${WORKDIR}/${PN}

src_compile() {
	emake CFLAGS="${CFLAGS}" CXXFLAGS="${CXXFLAGS}" || die "Make failed"
}

src_install() {
	dobin bcwipe || die
	doman bcwipe.1
	cd ../bcwipe-help
	dodir /usr/share/doc/${PF}
	cp -r * ${D}/usr/share/doc/${PF}
}
