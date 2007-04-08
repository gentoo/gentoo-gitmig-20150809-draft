# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-shells/pdksh/pdksh-5.2.14-r4.ebuild,v 1.26 2007/04/08 13:27:59 jokey Exp $

inherit eutils

DESCRIPTION="The Public Domain Korn Shell"
HOMEPAGE="http://www.cs.mun.ca/~michael/pdksh/"
SRC_URI="ftp://ftp.cs.mun.ca/pub/pdksh/${P}.tar.gz
	ftp://ftp.cs.mun.ca/pub/pdksh/${P}-patches.1"

LICENSE="as-is"
SLOT="0"
KEYWORDS="alpha amd64 ~hppa ia64 ~mips ppc ppc64 s390 sparc x86"
IUSE=""

DEPEND="virtual/libc
	sys-apps/coreutils
	!app-shells/ksh"

RESTRICT="test"

src_unpack() {
	unpack ${P}.tar.gz
	cd "${S}"
	epatch "${DISTDIR}"/${P}-patches.1
	epatch "${FILESDIR}"/${P}-coreutils-posix-fix.patch
}

src_compile() {
	echo 'ksh_cv_dev_fd=${ksh_cv_dev_fd=yes}' > config.cache

	econf || die "econf failed"
	emake || die "emake failed"
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
