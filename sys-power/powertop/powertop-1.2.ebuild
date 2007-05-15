# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-power/powertop/powertop-1.2.ebuild,v 1.1 2007/05/15 00:20:12 vapier Exp $

inherit toolchain-funcs

DESCRIPTION="tool that helps you find what software is using the most power"
HOMEPAGE="http://www.linuxpowertop.org/"
SRC_URI="http://www.linuxpowertop.org/download/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

src_compile() {
	tc-export CC
	emake || die
}

src_install() {
	emake install DESTDIR="${D}" || die
	dodoc Changelog README
	doman powertop.1
}

pkg_postinst() {
	echo
	einfo "For PowerTOP to work best, use a Linux kernel with the"
	einfo "tickless idle (NO_HZ) feature enabled (version 2.6.21 or later)"
	echo
}
