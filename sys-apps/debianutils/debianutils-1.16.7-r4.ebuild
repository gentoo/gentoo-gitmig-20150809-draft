# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/debianutils/debianutils-1.16.7-r4.ebuild,v 1.14 2004/10/23 05:51:53 mr_bones_ Exp $

inherit eutils

DESCRIPTION="A selection of tools from Debian"
HOMEPAGE="http://packages.debian.org/unstable/base/debianutils.html"
SRC_URI="mirror://gentoo/${PN}_${PV}.tar.gz"

LICENSE="GPL-2 BSD"
SLOT="0"
KEYWORDS="x86 ppc sparc mips alpha arm hppa amd64 ia64 ppc64 s390 ppc-macos"
IUSE="static build"

DEPEND="virtual/libc"
RDEPEND="app-arch/bzip2
	!macos? ( !ppc-macos? ( sys-apps/coreutils ) )"

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
	if use static
	then
		emake LDFLAGS=-static || die
	else
		emake || die
	fi
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
