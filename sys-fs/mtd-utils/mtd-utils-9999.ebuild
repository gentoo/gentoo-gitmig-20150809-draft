# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/mtd-utils/mtd-utils-9999.ebuild,v 1.1 2007/12/27 21:13:10 vapier Exp $

ECVS_USER="anoncvs"
ECVS_PASS="anoncvs"
ECVS_SERVER="cvs.infradead.org:/home/cvs"
ECVS_MODULE="mtd"
inherit toolchain-funcs flag-o-matic cvs

DESCRIPTION="MTD userspace tools"
HOMEPAGE="http://sources.redhat.com/jffs2/"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE=""

S=${WORKDIR}/mtd/util

DEPEND="!sys-fs/mtd
	sys-libs/zlib"

src_unpack() {
	cvs_src_unpack
	sed -i \
		-e 's!^MANDIR.*!MANDIR = /usr/share/man!g' \
		-e 's!-include.*!!g' \
		"${S}"/Makefile
}

src_compile() {
	emake \
		CFLAGS="${CFLAGS} -I../include -Wall" \
		LDFLAGS="${LDFLAGS}" \
		CC="$(tc-getCC)" \
		DESTDIR="${D}" \
		|| die
}

src_install() {
	emake install DESTDIR="${D}" || die
	rm -r "${D}"/usr/include || die
	dodoc *.txt
}
