# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/gwydion-dylan-bin/gwydion-dylan-bin-2.4.0.ebuild,v 1.1 2005/08/02 02:11:01 araujo Exp $

DESCRIPTION="The Dylan Programming Language Compiler"
HOMEPAGE="http://www.gwydiondylan.org/"
SRC_URI="x86? ( mirror://gentoo/${P}-x86.tbz2 )"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

RESTRICT="nostrip"
LOC="/opt/gwydion-dylan"

DEPEND=""
RDEPEND=">=dev-libs/boehm-gc-6.4"

S="${WORKDIR}"

src_compile() {
  	mkdir -p ./${LOC}
	mv usr/* ./${LOC}
}

src_install() {
	cp -pr * ${D}
	insinto /etc/env.d
	doins ${FILESDIR}/20gwydion-dylan
}
