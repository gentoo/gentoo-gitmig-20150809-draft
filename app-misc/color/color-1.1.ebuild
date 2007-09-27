# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/color/color-1.1.ebuild,v 1.17 2007/09/27 13:15:29 angelos Exp $

inherit ccc

DESCRIPTION="Easily add ANSI colouring to shell scripts"
HOMEPAGE="http://runslinux.net/projects.html#color"
SRC_URI="http://runslinux.net/projects/color/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 ~hppa mips ppc ppc64 sparc x86"
IUSE=""

DEPEND="virtual/libc"

src_unpack() {
	unpack ${A}
	# replace hardcoded compiler and CFLAGS.
	replace-cc-hardcode
	sed -i "s/-W -Wall -O2 -g/${CFLAGS}/g" ${S}/Makefile
}

src_compile() {
	emake || die
	# some feedback everything went ok.
	echo; ls -l color; size color
}

src_install() {
	dobin color
	dodoc CHANGELOG README

	# symlink for british users.
	dosym /usr/bin/color /usr/bin/colour
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
