# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/debianutils/debianutils-1.16.7-r4.ebuild,v 1.17 2004/12/08 02:34:04 vapier Exp $

inherit eutils flag-o-matic toolchain-funcs

DESCRIPTION="A selection of tools from Debian"
HOMEPAGE="http://packages.debian.org/unstable/base/debianutils.html"
SRC_URI="mirror://gentoo/${PN}_${PV}.tar.gz"

LICENSE="GPL-2 BSD"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 mips ppc ppc64 ppc-macos s390 sh sparc x86"
IUSE="static build"

DEPEND="virtual/libc"
RDEPEND="app-arch/bzip2"

src_unpack() {
	unpack ${A}

	cd ${S}

	# Make installkernel and mkboot more Gentoo friendly
	# <azarah@gentoo.org> (25 Sep 2002)
	epatch ${FILESDIR}/${P}-gentoo.patch

	# Patch savelog to use bzip2 compression instead of gzip
	epatch ${FILESDIR}/${PN}-compress.patch

	# Get it to work with gcc-3.3
	# <azarah@gentoo.org> (18 May 2003)
	epatch ${FILESDIR}/${P}-gcc33.patch
}

src_compile() {
	use static && append-ldflags -static
	emake CC="$(tc-getCC)" LDFLAGS="${LDFLAGS}" || die
}

src_install() {
	into /
	dobin tempfile mktemp || die

	if ! use build
	then
		dobin run-parts
		insopts -m755
		exeinto /usr/sbin
		doexe savelog
		dosbin installkernel || die "installkernel"
		into /usr
		dosbin mkboot || die "mkboot"

		into /usr
		doman mktemp.1 tempfile.1 run-parts.8 savelog.8 \
			installkernel.8 mkboot.8

		cd debian
		dodoc changelog control
	fi
}
