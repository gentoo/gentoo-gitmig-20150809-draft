# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-scheme/tinyscheme/tinyscheme-1.40.ebuild,v 1.1 2011/02/28 16:45:17 hkbst Exp $

EAPI="3"

DESCRIPTION="Lightweight scheme interpreter"
HOMEPAGE="http://tinyscheme.sourceforge.net"
SRC_URI="mirror://sourceforge/tinyscheme/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

DEPEND=""
RDEPEND=""

#S=${WORKDIR}/${MY_P}

src_prepare() {
#	cp makefile makefile.old

	#separate lines, because shell comments are weak
	sed 's/CC = gcc -fpic/CC = gcc -fpic ${CFLAGS}/' -i makefile
	sed 's/LDFLAGS/LOCAL_LDFLAGS/g' -i makefile
	sed 's/LOCAL_LDFLAGS = -shared/LOCAL_LDFLAGS = -shared ${LDFLAGS}/' -i makefile

	sed 's/DEBUG=-g -Wno-char-subscripts -O/DEBUG=/' -i makefile
	sed "s/LD)/& -Wl,-soname,lib${PN}.so.${PV}/" -i makefile

#	diff -u makefile.old makefile
}

src_install() {
	newbin scheme ${PN} || die "newbin failed"
	dolib libtinyscheme.a libtinyscheme.so || die "dolib failed"
	dodoc Manual.txt || die "dodoc failed"

	# Bug 328967: dev-scheme/tinyscheme-1.39-r1 doesn't install header file
	insinto /usr/include/
	newins scheme.h tinyscheme.h || die "newins scheme.h tinyscheme.h failed"

	local INIT_DIR=/usr/share/${PN}/
	insinto ${INIT_DIR}
	doins init.scm || die "doins failed"
	dodir /etc/env.d/ && echo "TINYSCHEMEINIT=\"${INIT_DIR}init.scm\"" > "${D}"/etc/env.d/50tinyscheme
}
