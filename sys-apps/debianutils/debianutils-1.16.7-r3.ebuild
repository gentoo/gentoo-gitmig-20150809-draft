# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/debianutils/debianutils-1.16.7-r3.ebuild,v 1.7 2003/09/12 11:44:13 seemant Exp $

IUSE="static build"

S=${WORKDIR}/${P}
DESCRIPTION="A selection of tools from Debian"
HOMEPAGE="http://packages.debian.org/unstable/base/debianutils.html"
SRC_URI="mirror://gentoo/${PN}_${PV}.tar.gz"

SLOT="0"
LICENSE="GPL-2 BSD"
KEYWORDS="x86 ~amd64 ~ppc ~sparc ~alpha ~mips ~hppa ~arm"

DEPEND="virtual/glibc"

RDEPEND="sys-apps/bzip2
	sys-apps/coreutils"

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
		pmake LDFLAGS=-static || die
	else
		pmake || die
	fi
}

src_install() {
	into /
	dobin tempfile mktemp

	if [ -z "`use build`" ]
	then
		dobin run-parts
		insopts -m755
		exeinto /usr/sbin
		doexe savelog
		dosbin installkernel
		into /usr
		dosbin mkboot

		into /usr
		doman mktemp.1 readlink.1 tempfile.1 run-parts.8 savelog.8 \
			installkernel.8 mkboot.8

		cd debian
		dodoc changelog control copyright
	fi
}
