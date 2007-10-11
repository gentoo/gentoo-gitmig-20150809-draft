# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-power/powernowd/powernowd-0.97.ebuild,v 1.5 2007/10/11 06:05:00 tgall Exp $

DESCRIPTION="Daemon to control the speed and voltage of CPUs"
HOMEPAGE="http://www.deater.net/john/powernowd.html"
SRC_URI="http://www.deater.net/john/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc ~ppc64 x86"
IUSE=""

src_unpack() {
	unpack ${A}
	rm -f "${S}"/Makefile
}

src_compile() {
	emake powernowd || die "emake failed"
}

src_install() {
	dosbin powernowd || die
	dodoc README

	newconfd "${FILESDIR}"/powernowd.confd powernowd
	newinitd "${FILESDIR}"/powernowd.rc powernowd
}
