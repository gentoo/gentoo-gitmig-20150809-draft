# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/miscfiles/miscfiles-1.3-r1.ebuild,v 1.8 2004/04/26 04:55:20 vapier Exp $

inherit eutils

DESCRIPTION="Miscellaneous files"
HOMEPAGE="http://www.gnu.org/directory/miscfiles.html"
SRC_URI="ftp://ftp.gnu.org/gnu/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc mips alpha arm hppa amd64 ia64 ppc64 s390"
IUSE=""

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/tasks.info.diff
	epatch ${FILESDIR}/${P}-Makefile.diff
}

src_install() {
	einstall || die
	dodoc GNU* NEWS ORIGIN README dict-README
}
