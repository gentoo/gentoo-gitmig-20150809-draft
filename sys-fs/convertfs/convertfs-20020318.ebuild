# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/convertfs/convertfs-20020318.ebuild,v 1.1 2003/12/23 12:28:40 twp Exp $

DESCRIPTION="A tool to convert filesystems in-place"
HOMEPAGE="http://tzukanov.narod.ru/convertfs/"
SRC_URI="http://tzukanov.narod.ru/convertfs/convertfs-18mar2002.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="X gnome"
DEPEND="virtual/glibc"
S=${WORKDIR}/${PN}

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -i Makefile -e "s/^\(CFLAGS=\).*\$/\1${CFLAGS}/"
}

src_compile() {
	emake devclone devremap prepindex || die
}

src_install() {
	into /
	dosbin convertfs_dumb devclone devremap prepindex contrib/convertfs
}

pkg_postinst() {
	ewarn "This tool is HIGHLY DANGEROUS. Read the homepage before using it!"
	ewarn "    ${HOMEPAGE}"
	ewarn "You have been warned!"
}
