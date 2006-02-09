# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-process/schedtool/schedtool-1.2.6.ebuild,v 1.1 2006/02/09 20:41:15 dang Exp $

DESCRIPTION="A tool to query or alter a process' scheduling policy."
HOMEPAGE="http://freequaos.host.sk/schedtool"
SRC_URI="http://freequaos.host.sk/${PN}/${P}.tar.bz2"
LICENSE="GPL-2"
SLOT=0
KEYWORDS="~x86 ~ppc ~amd64"
IUSE=""

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -i '/^CFLAGS=/d ; s:/man/:/share/man/:' Makefile
}

src_compile() {
	emake || die "Compilation failed."
}

src_install() {
	make DESTPREFIX=${D}/usr install
	dodoc BUGS CHANGES INSTALL LICENSE README THANKS TUNING
}
