# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/tree/tree-1.4.ebuild,v 1.7 2004/03/12 08:30:02 mr_bones_ Exp $

NV="${PV}b3"
DESCRIPTION="Lists directories recursively, and produces an indented listing of files."
HOMEPAGE="http://mama.indstate.edu/users/ice/tree/"
SRC_URI="ftp://mama.indstate.edu/linux/tree/${PN}-${NV}.tgz"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="x86 ~ppc sparc alpha amd64"
IUSE=""

DEPEND="virtual/glibc"

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
