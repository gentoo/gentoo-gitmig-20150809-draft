# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/tree/tree-1.3.ebuild,v 1.10 2004/03/12 08:30:02 mr_bones_ Exp $

DESCRIPTION="Lists directories recursively, and produces an indented listing of files."
HOMEPAGE="http://mama.indstate.edu/users/ice/tree/"
SRC_URI="ftp://mama.indstate.edu/linux/tree/tree-1.3.tgz"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="x86 ppc sparc alpha"
IUSE=""

DEPEND="virtual/glibc"

src_compile() {
	emake || die
}

src_install () {
	insinto /usr/bin
	dobin tree
	doman tree.1
	dodoc CHANGES LICENSE README*
}
