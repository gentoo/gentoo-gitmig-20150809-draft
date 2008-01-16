# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/netio/netio-1.23.ebuild,v 1.14 2008/01/16 20:21:29 grobian Exp $

inherit toolchain-funcs

DESCRIPTION="a network benchmark for DOS, OS/2, Windows NT and Unix that measures net througput with NetBIOS and TCP/IP protocols."
HOMEPAGE="http://freshmeat.net/projects/netio/"
SRC_URI="http://ftp.leo.org/pub/comp/os/os2/leo/systools/netio123.zip"

LICENSE="free-noncomm"
SLOT="0"
KEYWORDS="x86 ppc sparc"
IUSE=""

DEPEND="virtual/libc
	app-arch/unzip
	>=sys-apps/sed-4"
RDEPEND="virtual/libc"

S="${WORKDIR}"

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -i -e 's|\(CFLAGS\)=|\1?=|g' \
		-e 's|\(CC\)=|\1?=|g' Makefile || die "sed Makefile failed"
}

src_compile() {
	emake linux	\
		CC="$(tc-getCC)" \
		CFLAGS="-DUNIX ${CFLAGS}" \
		|| die "emake failed"
}

src_install() {
	dobin netio || die "dobin failed"

	# to be sure to comply with the license statement in netio.doc,
	# just install everything included in the package to doc
	dodoc netio.doc FILE_ID.DIZ getopt.h netb_1_c.h netbios.h netio.c \
		netb_2_c.h netio.doc getopt.c Makefile netbios.c

	# also install binaries
	dodoc bin/os2-i386.exe bin/win32-i386.exe bin/linux-i386
}

pkg_postinst() {
	echo
	elog "NOTE: all files included in the upstream zip file have"
	elog "been installed to /usr/share/doc/${PF}, as required by"
	elog "the license."
	echo
}
