# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/bigeye/bigeye-0.3.ebuild,v 1.4 2004/02/21 05:55:23 vapier Exp $

inherit gcc eutils

DESCRIPTION="Bigeye is a network utility dump and simple honeypot utility"
HOMEPAGE="http://violating.us/projects/bigeye/"
SRC_URI="http://violating.us/projects/bigeye/download/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

DEPEND="virtual/glibc"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PV}-gcc3.patch
}

src_compile() {
	cd src
	$(gcc-getCC) ${CFLAGS} bigeye.c emulate.c -o bigeye || die
}

src_install() {
	dobin src/bigeye || die

	insinto /usr/share/bigeye
	doins sig.file
	cp -r messages ${D}/usr/share/bigeye/
	dodoc README
}

pkg_postinst() {
	einfo "The service emulation files mentioned in the README"
	einfo "are located in /usr/share/bigeye/messages"
}
