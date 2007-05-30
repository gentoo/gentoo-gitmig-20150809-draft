# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-power/powertop/powertop-1.5.ebuild,v 1.2 2007/05/30 00:06:43 genstef Exp $

inherit toolchain-funcs eutils

DESCRIPTION="tool that helps you find what software is using the most power"
HOMEPAGE="http://www.linuxpowertop.org/"
SRC_URI="http://www.linuxpowertop.org/download/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
DEPEND="sys-libs/ncurses"
RDEPEND="${DEPEND}"

pkg_setup() {
	if ! built_with_use sys-libs/ncurses unicode; then
		eerror "You need USE=unicode for sys-libs/ncurses"
		die "You need USE=unicode for sys-libs/ncurses"
	fi
}

src_compile() {
	tc-export CC
	emake || die
}

src_install() {
	emake install DESTDIR="${D}" || die
	dodoc Changelog README
	gunzip ${D}/usr/share/man/man1/powertop.1.gz
}

pkg_postinst() {
	echo
	einfo "For PowerTOP to work best, use a Linux kernel with the"
	einfo "tickless idle (NO_HZ) feature enabled (version 2.6.21 or later)"
	echo
}
