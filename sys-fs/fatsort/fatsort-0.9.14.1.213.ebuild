# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/fatsort/fatsort-0.9.14.1.213.ebuild,v 1.2 2011/02/16 22:31:54 hwoarang Exp $

EAPI=2

inherit toolchain-funcs versionator

MY_PV=$(replace_version_separator 4 '-')

DESCRIPTION="Sorts files on FAT16/32 partitions, ideal for basic audio players."
HOMEPAGE="http://fatsort.berlios.de/"
SRC_URI="mirror://berlios/${PN}/${PN}-${MY_PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~x86"
IUSE=""

S=${WORKDIR}/${PN}-${MY_PV}

src_prepare() {
	sed -i -e "/^\(MANDIR=\|SBINDIR=\)/s|/usr/local|/usr|" $(find ./ -name Makefile)
}

src_compile() {
	emake CC=$(tc-getCC) LD=$(tc-getCC) CFLAGS="${CFLAGS}" LDFLAGS="${LDFLAGS}" \
	DESTDIR="${D}" || die
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc CHANGES README TODO || die
}
