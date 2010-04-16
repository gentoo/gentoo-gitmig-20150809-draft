# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/fatsort/fatsort-0.9.13.1.206.ebuild,v 1.4 2010/04/16 18:32:05 hwoarang Exp $

EAPI="2"

inherit toolchain-funcs versionator

MY_PV=$(replace_version_separator 4 '-')

DESCRIPTION="Sorts files on FAT16/32 partitions, ideal for basic audio players."
HOMEPAGE="http://fatsort.berlios.de/"
SRC_URI="mirror://berlios/${PN}/${PN}-${MY_PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

S=${WORKDIR}/${PN}-${MY_PV}

src_prepare() {
	sed -i -e "/^\(MANDIR=\|SBINDIR=\)/s|/usr/local|/usr|" $(find ./ -name Makefile)
}

src_compile() {
	emake CC=$(tc-getCC) LD=$(tc-getCC) CFLAGS="${CFLAGS}" LDFLAGS="${LDFLAGS}" \
	DESTDIR="${D}" || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc CHANGES README TODO || die "dodoc failed"
}
