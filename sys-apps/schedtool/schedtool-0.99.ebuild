# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/schedtool/schedtool-0.99.ebuild,v 1.3 2004/06/24 22:25:28 agriffis Exp $

DESCRIPTION="A tool to query or alter a process' scheduling policy."
HOMEPAGE="http://freequaos.host.sk/schedtool"
SRC_URI="http://freequaos.host.sk/${PN}/${P}.tar.bz2"
LICENSE="GPL-2"
SLOT=0
KEYWORDS="~x86 ~ppc"
DEPEND="sys-apps/sed"
S="${WORKDIR}/${P}"

src_unpack() {
		unpack ${A}
			cp ${S}/Makefile ${S}/Makefile.orig
				sed '/^CFLAGS=/d ; s:/man/:/share/man/:' \
						< ${S}/Makefile.orig > ${S}/Makefile
}

src_compile() {
		emake || die "Compilation failed."
}

src_install() {
		make DESTPREFIX=${D}/usr install
			dodoc BUGS CHANGES INSTALL LICENSE README THANKS TUNING
}
