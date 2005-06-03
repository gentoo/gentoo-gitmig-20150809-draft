# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-portage/qfile/qfile-0.0.3.ebuild,v 1.1 2005/06/03 01:24:36 solar Exp $

inherit toolchain-funcs

DESCRIPTION="A very small and fast c implementation of misc portage helper tools"
HOMEPAGE="http://www.gentoo.org/"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86"
IUSE=""
DEPEND="virtual/libc"

S=${WORKDIR}

src_compile() {
	$(tc-getCC) ${CFLAGS} -DPORTDIR=\"${PORTDIR}\" -o ${S}/q  \
		${FILESDIR}/qfile.c ${LDFLAGS} || die "compile"
}

src_install() {
	dodir /usr/bin
	exeinto /usr/bin
	newexe ${S}/q q || die
	for applet in q{file,search,use,list}; do
		dosym /usr/bin/q /usr/bin/${applet} || die "symlinking $applet"
	done
}
