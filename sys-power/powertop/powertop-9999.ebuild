# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-power/powertop/powertop-9999.ebuild,v 1.2 2011/01/26 10:44:34 bangert Exp $

EAPI=3

inherit git toolchain-funcs eutils

DESCRIPTION="tool that helps you find what software is using the most power"
HOMEPAGE="http://www.lesswatts.org/projects/powertop/"
SRC_URI=""
EGIT_REPO_URI="git://git.kernel.org/pub/scm/status/powertop/powertop.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="unicode"

DEPEND="sys-libs/ncurses[unicode?]
	sys-devel/gettext"
RDEPEND="${DEPEND}"

src_prepare() {
	use unicode || sed -i 's:-lncursesw:-lncurses:' Makefile
}

src_configure() {
	tc-export CC
}

src_install() {
	emake install DESTDIR="${ED}" || die
	dodoc Changelog README
	gunzip "${ED}"/usr/share/man/man1/powertop.1.gz
}

pkg_postinst() {
	echo
	einfo "For PowerTOP to work best, use a Linux kernel with the"
	einfo "tickless idle (NO_HZ) feature enabled (version 2.6.21 or later)"
	echo
}
