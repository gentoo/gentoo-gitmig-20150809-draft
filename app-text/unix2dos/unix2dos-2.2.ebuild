# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/unix2dos/unix2dos-2.2.ebuild,v 1.22 2005/05/16 05:48:59 ka0ttic Exp $

inherit eutils toolchain-funcs

DESCRIPTION="UNIX to DOS text file format converter"
HOMEPAGE="I HAVE NO HOME :("
SRC_URI="mirror://gentoo/${P}.src.tar.gz"

LICENSE="freedist"
SLOT="0"
KEYWORDS="x86 ppc sparc mips alpha arm hppa amd64 ppc64 ppc-macos"
IUSE=""

DEPEND=""
RDEPEND=""

S="${WORKDIR}"

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/${PN}-mkstemp.patch
	epatch ${FILESDIR}/${P}-segfault.patch
	epatch ${FILESDIR}/${P}-manpage.patch
}

src_compile() {
	$(tc-getCC) ${CFLAGS} -o unix2dos unix2dos.c || die
}

src_install() {
	dobin unix2dos || die
	doman unix2dos.1
}
