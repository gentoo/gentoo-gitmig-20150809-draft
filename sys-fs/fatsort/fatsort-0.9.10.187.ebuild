# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/fatsort/fatsort-0.9.10.187.ebuild,v 1.1 2008/12/08 23:15:32 darkside Exp $

inherit toolchain-funcs versionator

MY_PV=$(replace_version_separator 3 '-')

DESCRIPTION="Sorts files on FAT16/32 partitions, ideal for basic audio players."
HOMEPAGE="http://fatsort.berlios.de/"
SRC_URI="mirror://berlios/${PN}/${PN}-${MY_PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

S=${WORKDIR}/${PN}-${MY_PV}

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i -e 's:/usr/local/sbin:/usr/sbin:g' src/Makefile || die "sed failed!"
}

src_compile() {
	emake CC=$(tc-getCC) LD=$(tc-getCC) CFLAGS="${CFLAGS}" LDFLAGS="${LDFLAGS}" \
	DESTDIR="${D}" || die "compile failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "install failed"
	doman man/fatsort.8 || die "doman failed"
	dodoc CHANGES README TODO || die "dodoc failed"
}

