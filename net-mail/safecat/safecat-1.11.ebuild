# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/safecat/safecat-1.11.ebuild,v 1.10 2005/03/19 15:25:38 agriffis Exp $

IUSE=""

inherit fixheadtails eutils

DESCRIPTION="Safecat implements qmail's maildir algorithm, copying standard input safely to a specified directory."
HOMEPAGE="http://budney.homeunix.net:8080/users/budney/linux/software/${PN}/"
SRC_URI="http://budney.homeunix.net:8080/users/budney/linux/software/${PN}/${P}.tar.gz"

DEPEND="virtual/libc
	sys-apps/groff"

RDEPEND="virtual/libc"
SLOT="0"
LICENSE="BSD"
KEYWORDS="alpha amd64 ~hppa ia64 ~mips ~ppc ~sparc x86"

src_unpack() {
	unpack ${P}.tar.gz

	# applying errno-patch and maildir-patch
	epatch ${FILESDIR}/safecat-1.11-gentoo.patch

	cd ${S}
	echo "/usr" > conf-root
	echo "${CC} ${CFLAGS}" > conf-cc
	echo "${CC} ${LDFLAGS}" > conf-ld

	ht_fix_file Makefile make-compile.sh
}

src_compile() {
	egrep -v 'man|doc' hier.c > hier.c.new
	mv hier.c.new hier.c
	make it man || die
}

src_install() {
	dodir /usr
	echo "${D}/usr" > conf-root
	make man setup check || die
	dodoc CHANGES COPYING INSTALL README
	doman maildir.1 safecat.1
}
