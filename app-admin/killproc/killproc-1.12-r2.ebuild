# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/killproc/killproc-1.12-r2.ebuild,v 1.24 2008/11/02 06:18:26 jmbsvicetto Exp $

DESCRIPTION="killproc and assorted tools for boot scripts"
HOMEPAGE="http://www.suse.de/"
SRC_URI="ftp://ftp.suse.com/pub/projects/init/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc amd64"
IUSE=""

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i \
		-e "s:-O2:${CFLAGS}:" \
		-e "s:-m486::" \
		Makefile || die "sed failed"
}

src_compile() {
	make || die
}

src_install() {
	into /
	dosbin checkproc startproc killproc || die
	into /usr
	doman *.8
	dodoc README *.lsm
}
