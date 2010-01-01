# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/hilite/hilite-1.5.ebuild,v 1.16 2010/01/01 18:26:57 ssuominen Exp $

inherit toolchain-funcs

HOMEPAGE="http://sourceforge.net/projects/hilite"
SRC_URI="mirror://gentoo/${P}.c"
DESCRIPTION="A utility which highlights stderr text in red"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~hppa ~ia64 mips ppc sparc x86"
IUSE=""

S=${WORKDIR}

src_unpack() {
	cp "${DISTDIR}"/${A} "${WORKDIR}"/
}

src_compile() {
	$(tc-getCC) ${LDFLAGS} ${CFLAGS} -o ${PN} ${P}.c || die
}

src_install() {
	dobin hilite || die
}
