# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/netio/netio-1.23.ebuild,v 1.2 2003/10/19 19:38:28 mr_bones_ Exp $

DESCRIPTION="a network benchmark for DOS, OS/2, Windows NT and Unix that measures net througput with NetBIOS and TCP/IP protocols."
HOMEPAGE="http://freshmeat.net/projects/netio/"
SRC_URI="http://ftp.leo.org/pub/comp/os/os2/leo/systools/netio123.zip"
LICENSE="free-noncomm"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
DEPEND="virtual/glibc"
RDEPEND="virtual/glibc"
S=${WORKDIR}/

src_compile() {
	emake linux || die
}

src_install() {
	into /usr
	dobin netio

	# to be sure to comply with the license statement in netio.doc,
	# just install everything included in the package to doc
	dodoc netio.doc FILE_ID.DIZ getopt.h netb_1_c.h netbios.h netio.c\
		getopt.o netb_2_c.h netbios.o netio.doc getopt.c Makefile netbios.c\
		netio netio.o

	# also install binaries for other platforms than linux 
	dodoc bin/os2-i386.exe bin/win32-i386.exe
}
