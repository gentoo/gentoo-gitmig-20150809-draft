# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/tree/tree-1.3.ebuild,v 1.12 2004/07/01 12:09:02 eradicator Exp $

DESCRIPTION="Lists directories recursively, and produces an indented listing of files."
HOMEPAGE="http://mama.indstate.edu/users/ice/tree/"
SRC_URI="ftp://mama.indstate.edu/linux/tree/tree-1.3.tgz"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="x86 ppc sparc alpha"
IUSE=""

DEPEND="virtual/libc"

src_compile() {
	emake || die
}

src_install () {
	insinto /usr/bin
	dobin tree
	doman tree.1
	dodoc CHANGES LICENSE README*
}
