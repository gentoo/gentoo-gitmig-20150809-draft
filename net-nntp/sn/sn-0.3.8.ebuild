# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-nntp/sn/sn-0.3.8.ebuild,v 1.2 2005/05/16 17:08:34 swegener Exp $

inherit toolchain-funcs

DESCRIPTION="Hassle-free Usenet news system for small sites"
SRC_URI="http://infa.abo.fi/~patrik/sn/files/${P}.tar.bz2"
HOMEPAGE="http://infa.abo.fi/~patrik/sn/"

KEYWORDS="x86 ~ppc"
SLOT="0"
LICENSE="GPL-2"
IUSE=""

RDEPEND="virtual/libc
	sys-libs/zlib"
DEPEND="${RDEPEND}
	>=sys-apps/sed-4"

src_compile() {
	make cc-flags || die "make cc-flags failed"
	echo ${CFLAGS} >>cc-flags

	emake -j1 \
		CC="$(tc-getCC)" LD="$(tc-getCC)" \
		SNROOT=/var/spool/news \
		BINDIR=/usr/sbin \
		MANDIR=/usr/share/man \
		|| die "emake failed"
}

src_install() {
	dodir /var/spool/news /usr/sbin /usr/share/man/man8
	mknod -m 600 "${D}"/var/spool/news/.fifo p
	make install \
		SNROOT="${D}"/var/spool/news \
		BINDIR="${D}"/usr/sbin \
		MANDIR="${D}"/usr/share/man \
		|| die "make install failed"
	dodoc CHANGES FAQ INSTALL* INTERNALS README* THANKS TODO || die "dodoc failed"
	fowners news:news /var/spool/news{,/.fifo}
}
