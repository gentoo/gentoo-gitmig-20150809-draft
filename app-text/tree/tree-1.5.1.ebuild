# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/tree/tree-1.5.1.ebuild,v 1.8 2007/06/27 13:59:45 pylon Exp $

inherit toolchain-funcs bash-completion

DESCRIPTION="Lists directories recursively, and produces an indented listing of files."
HOMEPAGE="http://mama.indstate.edu/users/ice/tree/"
SRC_URI="ftp://mama.indstate.edu/linux/tree/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha amd64 arm ~hppa ia64 m68k ~mips ppc ppc64 s390 sh sparc x86"
IUSE=""

src_compile() {
	emake \
		CC="$(tc-getCC)" \
		CFLAGS="${CFLAGS} -DLINUX_BIGFILE" \
		LDFLAGS="${LDFLAGS}" \
		|| die "emake failed"
}

src_install() {
	dobin tree || die "dobin failed"
	doman man/tree.1
	dodoc CHANGES README*
	dobashcompletion "${FILESDIR}"/${PN}.bashcomp
}
