# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/safecat/safecat-1.11.ebuild,v 1.14 2011/06/19 15:49:23 armin76 Exp $

inherit fixheadtails eutils toolchain-funcs

IUSE=""

DESCRIPTION="Safecat implements qmail's maildir algorithm, copying standard input safely to a specified directory."
HOMEPAGE="http://budney.homeunix.net:8080/users/budney/linux/software/safecat/"
SRC_URI="http://budney.homeunix.net:8080/users/budney/linux/software/${PN}/${P}.tar.gz"

DEPEND="sys-apps/groff"
RDEPEND=""

SLOT="0"
LICENSE="BSD"
KEYWORDS="amd64 ~hppa ~mips ppc ~sparc x86"

src_unpack() {
	unpack ${P}.tar.gz

	# applying errno-patch and maildir-patch
	epatch ${FILESDIR}/safecat-1.11-gentoo.patch

	cd ${S}
	echo "/usr" > conf-root
	echo "$(tc-getCC) ${CFLAGS}" > conf-cc
	echo "$(tc-getCC) ${LDFLAGS}" > conf-ld

	ht_fix_file Makefile make-compile.sh

	egrep -v 'man|doc' hier.c > hier.c.new
	mv hier.c.new hier.c
}

src_compile() {
	make it man || die
}

src_install() {
	dodir /usr
	echo "${D}/usr" > conf-root
	make man setup check || die
	dodoc CHANGES COPYING INSTALL README
	doman maildir.1 safecat.1
}
