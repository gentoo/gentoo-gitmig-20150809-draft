# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/videogen/videogen-0.32.ebuild,v 1.6 2005/01/14 15:42:54 luckyduck Exp $

inherit toolchain-funcs

DESCRIPTION="Small utility to generate XFree86 modelines and fbset timings"
HOMEPAGE="http://www.dynaweb.hu/opensource/videogen/"
SRC_URI="http://www.dynaweb.hu/opensource/videogen/download/${P}.tar.gz"
IUSE=""
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~amd64"
DEPEND=">=sys-apps/sed-4"

src_unpack() {
	unpack ${A}
	sed -i 's:CFLAGS = :# CFLAGS = :' ${S}/Makefile
	sed -i "s:CC = gcc:CC = $(tc-getCC):" ${S}/Makefile
}

src_compile() {
	emake || die "error while compiling videogen"
}

src_install() {
	dobin videogen
	doman videogen.1x
	dodoc BUGS CHANGES INSTALL README THANKS videogen.sample
}
