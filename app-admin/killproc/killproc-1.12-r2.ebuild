# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/killproc/killproc-1.12-r2.ebuild,v 1.25 2009/01/03 17:19:20 angelos Exp $

inherit flag-o-matic toolchain-funcs

DESCRIPTION="killproc and assorted tools for boot scripts"
HOMEPAGE="http://www.suse.de/"
SRC_URI="ftp://ftp.suse.com/pub/projects/init/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc sparc x86"
IUSE=""

src_unpack() {
	unpack ${A}
	cd "${S}"
	filter-flags -O0
	sed -i \
		-e "s:-O2:-O1 ${CFLAGS}:" \
		-e "s:-m486::" \
		Makefile || die "sed failed"
}

src_compile() {
	emake CC="$(tc-getCC)" || die "emake failed"
}

src_install() {
	into /
	dosbin checkproc startproc killproc || die "dosbin failed"
	into /usr
	doman *.8
	dodoc README *.lsm
}
