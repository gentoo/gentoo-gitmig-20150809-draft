# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/mscompress/mscompress-0.3.ebuild,v 1.5 2004/06/25 23:52:14 vapier Exp $

inherit gnuconfig eutils

DESCRIPTION="Microsoft compress.exe/expand.exe compatible (de)compressor"
HOMEPAGE="http://www.penguin.cz/~mhi/ftp/mscompress/"
SRC_URI="http://www.penguin.cz/~mhi/ftp/mscompress/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~amd64"
IUSE=""

DEPEND="virtual/libc"
RDEPEND="${DEPEND}
	>=sys-apps/sed-4"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}-makefile.patch
	gnuconfig_update
}

src_install() {
	dobin mscompress msexpand || die
	doman mscompress.1 msexpand.1
	dodoc README ChangeLog

	# taken from magic.add, modified for gentoo
	if [ -z "`grep END_OF_MSCOMPRESS ${ROOT}/usr/share/misc/file/magic`" ] ; then
		dodir /usr/share/misc/file
		cat ${ROOT}/usr/share/misc/file/magic magic.mscompress > ${D}/usr/share/misc/file/magic
	fi
}
