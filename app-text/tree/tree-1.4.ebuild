# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/tree/tree-1.4.ebuild,v 1.6 2004/01/07 22:26:41 ciaranm Exp $

DESCRIPTION="Lists directories recursively, and produces an indented listing of files."

NV="${PV}b3"
SRC_URI="ftp://mama.indstate.edu/linux/tree/${PN}-${NV}.tgz"
HOMEPAGE="http://mama.indstate.edu/users/ice/tree/"
LICENSE="Artistic"
KEYWORDS="x86 ~ppc sparc alpha amd64"
DEPEND="virtual/glibc"
SLOT="0"

src_unpack() {
	unpack ${PN}-${NV}.tgz
	cd ${S} && \
	sed -i \
		-e "s/-O2 -Wall -fomit-frame-pointer/${CFLAGS}/" Makefile || \
		die "sed Makefile failed"
}

src_compile() {
	emake || die
}

src_install () {
	insinto /usr/bin
	dobin tree
	doman tree.1
	dodoc CHANGES LICENSE README*
}
