# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/diffstat/diffstat-1.29.ebuild,v 1.12 2004/02/15 15:57:41 kumba Exp $

inherit eutils

S=${WORKDIR}/${P}
DESCRIPTION="diffstat reads the output of diff and displays a histogram of the insertions, deletions, and modifications per-file"
SRC_URI="ftp://invisible-island.net/${PN}/${PN}.tar.gz"
HOMEPAGE="http://dickey.his.com/diffstat/diffstat.html"

SLOT="0"
LICENSE="as-is"
KEYWORDS="x86 sparc ~ppc"

DEPEND="sys-apps/diffutils"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}-hard-locale.patch
}

src_compile() {
	econf || die

	# Fix CFLAGS
	local oldcflags="-O -Wall -Wshadow -Wconversion -Wstrict-prototypes -Wmissing-prototypes"
	mv ${S}/makefile ${S}/makefile.orig
	sed -e "s:CFLAGS\t\t= ${oldcflags}:CFLAGS\t\t= ${oldcflags} ${CFLAGS}:g" ${S}/makefile.orig > ${S}/makefile

	emake || die
}

src_install() {
	dobin diffstat
	doman diffstat.1
	dodoc README CHANGES
}
