# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/hilite/hilite-1.5.ebuild,v 1.10 2005/01/01 15:06:55 eradicator Exp $

inherit toolchain-funcs

HOMEPAGE="http://sourceforge.net/projects/hilite"
SRC_URI="mirror://gentoo/${PN}-${PV}.c"
DESCRIPTION="A utility which highlights stderr text in red"

SLOT="0"

LICENSE="GPL-2"
KEYWORDS="sparc mips ~amd64 x86 ~hppa ppc ~ppc-macos"
S=${WORKDIR}

IUSE=""
DEPEND=""

src_unpack() {
	cp ${DISTDIR}/${A} ${WORKDIR}/
}

src_compile() {
	$(tc-getCC ) ${CFLAGS} -o ${PN} ${PN}-${PV}.c \
		|| die "compile failed"
}

src_install() {
	dobin ${WORKDIR}/hilite
}

