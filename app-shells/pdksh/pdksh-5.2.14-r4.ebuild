# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-shells/pdksh/pdksh-5.2.14-r4.ebuild,v 1.23 2004/09/12 18:59:47 taviso Exp $

inherit eutils

DESCRIPTION="The Public Domain Korn Shell"
HOMEPAGE="http://www.cs.mun.ca/~michael/pdksh/"
SRC_URI="ftp://ftp.cs.mun.ca/pub/pdksh/${P}.tar.gz
	ftp://ftp.cs.mun.ca/pub/pdksh/${P}-patches.1"

LICENSE="as-is"
SLOT="0"
KEYWORDS="x86 ppc sparc ~mips alpha ~hppa amd64 ia64 ~ppc64 s390"
IUSE=""

DEPEND="virtual/libc
	sys-apps/coreutils
	!app-shells/ksh"

src_unpack() {
	unpack ${P}.tar.gz
	cd ${S}
	epatch ${DISTDIR}/${P}-patches.1
	epatch ${FILESDIR}/${P}-coreutils-posix-fix.patch
}

src_compile() {
	echo 'ksh_cv_dev_fd=${ksh_cv_dev_fd=yes}' > config.cache

	./configure \
		--prefix=/usr \
		|| die

	emake || die
}

src_install() {
	into /
	dobin ksh
	into usr
	doman ksh.1
	dodoc BUG-REPORTS ChangeLog* CONTRIBUTORS LEGAL NEWS NOTES PROJECTS README
	docinto etc
	dodoc etc/*
}
