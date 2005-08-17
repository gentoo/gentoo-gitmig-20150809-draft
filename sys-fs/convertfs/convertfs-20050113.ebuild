# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/convertfs/convertfs-20050113.ebuild,v 1.2 2005/08/17 10:12:35 sbriesen Exp $

DESCRIPTION="A tool to convert filesystems in-place"
HOMEPAGE="http://tzukanov.narod.ru/convertfs/"
SRC_URI="http://tzukanov.narod.ru/convertfs/convertfs-13jan2005.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc"
IUSE=""

DEPEND="virtual/libc"

S="${WORKDIR}/${PN}"

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i -e "s:\./\(devclone\):\1:g" -e "s:\./\(devremap\):\1:g" \
		-e "s:\./\(prepindex\):\1:g" convertfs_dumb contrib/convertfs 
}

src_compile() {
	emake CFLAGS="${CFLAGS}" devclone devremap prepindex || die "emake failed"
}

src_install() {
	dodoc convertfs_dumb
	into / && dosbin devclone devremap prepindex contrib/convertfs
}

pkg_postinst() {
	ewarn "This tool is HIGHLY DANGEROUS. Read the homepage before using it!"
	ewarn "    ${HOMEPAGE}"
	ewarn "You have been warned!"
}
