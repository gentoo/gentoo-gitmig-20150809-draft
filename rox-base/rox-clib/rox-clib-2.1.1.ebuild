# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/rox-base/rox-clib/rox-clib-2.1.1.ebuild,v 1.2 2005/03/06 00:08:29 josejx Exp $

DESCRIPTION="A library for ROX applications written in C."

HOMEPAGE="http://rox.sourceforge.net/"

MY_PN="ROX-CLib"

SRC_URI="http://www.kerofin.demon.co.uk/rox/${MY_PN}-${PV}.tar.gz"

LICENSE="GPL-2"

SLOT="0"

KEYWORDS="~x86 ~ppc"

IUSE=""

RDEPEND=">=rox-base/rox-2.1.0"

DEPEND=$RDEPEND

S=${WORKDIR}/ROX-CLib

src_compile() {
	./AppRun --compile || die
}

src_install() {
	rm -rf src || die
	dodir /usr/lib/ROX-CLib
	cp -rf * ${D}/usr/lib/ROX-CLib
	cp -rf .* ${D}/usr/lib/ROX-CLib
}
