# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/tree/tree-1.4.ebuild,v 1.12 2004/10/28 02:36:03 josejx Exp $

MY_PV="${PV}b3"
DESCRIPTION="Lists directories recursively, and produces an indented listing of files."
HOMEPAGE="http://mama.indstate.edu/users/ice/tree/"
SRC_URI="ftp://mama.indstate.edu/linux/tree/${PN}-${MY_PV}.tgz"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="x86 ppc sparc alpha amd64 ~mips"
IUSE=""

RDEPEND="virtual/libc"
DEPEND="${RDEPEND}
	>=sys-apps/sed-4"

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -i \
		-e 's/-O2 -Wall -fomit-frame-pointer/$(E_CFLAGS)/' Makefile \
			|| die "sed Makefile failed"
	# fix for bug #49210
	sed -i \
		-e '1085 s/$/;/' tree.c \
			|| die "sed tree.c failed"
}

src_compile() {
	emake E_CFLAGS="${CFLAGS}" || die "emake failed"
}

src_install() {
	dobin tree || die "dobin failed"
	doman tree.1
	dodoc CHANGES README*
}
