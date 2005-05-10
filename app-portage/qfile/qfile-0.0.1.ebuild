# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-portage/qfile/qfile-0.0.1.ebuild,v 1.1 2005/05/10 12:41:51 solar Exp $

inherit toolchain-funcs

DESCRIPTION="very small and fast c implementation of portage query file tool"
HOMEPAGE="http://www.gentoo.org/"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86"
IUSE=""
DEPEND="virtual/libc"

S=${WORKDIR}

src_compile() {
	cd ${S}
	$(tc-getCC) ${CFLAGS} -o qfile  \
		${FILESDIR}/qfile.c ${LDFLAGS} || die "compile"
}

src_install() {
	dodir /usr/bin
	exeinto /usr/bin
	newexe ${S}/qfile ${PN} || die
}
