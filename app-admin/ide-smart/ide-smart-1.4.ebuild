# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/ide-smart/ide-smart-1.4.ebuild,v 1.18 2004/05/31 19:21:32 vapier Exp $

DESCRIPTION="A tool to read SMART information from harddiscs"
HOMEPAGE="http://lightside.eresmas.com/"
SRC_URI="http://lightside.eresmas.com/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc"
IUSE=""

DEPEND="virtual/glibc"

src_unpack() {
	unpack ${A} ; cd ${S}
	rm ide-smart ide-smart.o
	sed -i -e "s:^CFLAGS.*:CFLAGS = ${CFLAGS}:" \
		-e "s:^#CC.*:CC = gcc:" \
		Makefile
}

src_compile() {
	emake || die
}

src_install() {
	dobin ide-smart || die
	doman ide-smart.8
	dodoc README
}
