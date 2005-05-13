# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/convertfs/convertfs-20050113.ebuild,v 1.1 2005/05/13 18:46:53 twp Exp $

DESCRIPTION="A tool to convert filesystems in-place"
HOMEPAGE="http://tzukanov.narod.ru/convertfs/"
SRC_URI="http://tzukanov.narod.ru/convertfs/convertfs-13jan2005.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc"
IUSE=""

DEPEND="virtual/libc"

S=${WORKDIR}/${PN}

src_unpack() {
	unpack ${A}
	sed -i ${S}/Makefile -e "s/^\(CFLAGS=\).*\$/\1${CFLAGS}/"
}

src_compile() {
	emake devclone devremap prepindex || die
}

src_install() {
	into /
	dosbin convertfs_dumb devclone devremap prepindex contrib/convertfs || die
}

pkg_postinst() {
	ewarn "This tool is HIGHLY DANGEROUS. Read the homepage before using it!"
	ewarn "    ${HOMEPAGE}"
	ewarn "You have been warned!"
}
