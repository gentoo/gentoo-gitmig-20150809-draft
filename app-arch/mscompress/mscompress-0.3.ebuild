# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/mscompress/mscompress-0.3.ebuild,v 1.2 2004/04/14 11:12:40 aliz Exp $

inherit gnuconfig eutils

DESCRIPTION="Microsoft compress.exe/expand.exe compatible (de)compressor"
SRC_URI="http://www.penguin.cz/~mhi/ftp/mscompress/${P}.tar.bz2"
HOMEPAGE="http://www.penguin.cz/~mhi/ftp/mscompress/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND="virtual/glibc"
RDEPEND="${DEPEND}
	>=sys-apps/sed-4"

src_unpack() {
	unpack ${A} ; cd ${S}

	epatch ${FILESDIR}/${P}-makefile.patch
}

src_compile() {
	gnuconfig_update

	econf || die
	emake || die
}

src_install() {
	dobin mscompress msexpand
	doman mscompress.1 msexpand.1
	dodoc README ChangeLog

	# taken from magic.add, modified for gentoo
	if [ -z "`grep END_OF_MSCOMPRESS ${ROOT}/usr/share/misc/file/magic`" ] ; then
		dodir /usr/share/misc/file
		cat ${ROOT}/usr/share/misc/file/magic magic.mscompress > ${D}/usr/share/misc/file/magic
	fi
}
