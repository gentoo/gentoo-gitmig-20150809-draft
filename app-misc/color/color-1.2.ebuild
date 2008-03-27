# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/color/color-1.2.ebuild,v 1.7 2008/03/27 21:25:11 jer Exp $

inherit toolchain-funcs

DESCRIPTION="Easily add ANSI colouring to shell scripts"
HOMEPAGE="http://www.runslinux.net/?page_id=10"
SRC_URI="http://runslinux.net/projects/color/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 hppa ~ia64 ~mips ppc ppc64 sparc x86"
IUSE=""

src_compile() {
	emake CC="$(tc-getCC)" CFLAGS="${CFLAGS}" || die "emake failed"
}

src_install() {
	dobin color || die "dobin failed"
	dodoc CHANGELOG README

	# symlink for british users.
	dosym color /usr/bin/colour
}

pkg_postinst() {
	elog "For information on using colour in your shell scripts,"
	elog "run \`color\` without any arguments."
	elog
	elog "To see all the colours available, use this command"
	elog "	$ color --list"
	elog
	elog "More examples are available in /usr/share/doc/${PF}."
}
