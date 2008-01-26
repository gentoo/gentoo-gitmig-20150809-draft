# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/mtd-utils/mtd-utils-20060907.ebuild,v 1.6 2008/01/26 08:45:07 vapier Exp $

inherit toolchain-funcs flag-o-matic

DESCRIPTION="MTD userspace tools, based on GIT snapshot from upstream"
HOMEPAGE="http://sources.redhat.com/jffs2/"
SRC_URI="mirror://gentoo/${PN}-snapshot-${PV}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 arm mips ppc x86"
IUSE=""

S=${WORKDIR}/${PN}

RDEPEND="!sys-fs/mtd
		sys-libs/zlib"
# ACL is only required for the <sys/acl.h> header file to build mkfs.jffs2
DEPEND="sys-apps/acl
		${DEPEND}"

src_unpack() {
	unpack ${A}
	sed -i.orig \
		-e 's!^MANDIR.*!MANDIR = /usr/share/man!g' \
		-e 's!-include.*!!g' \
		"${S}"/Makefile
}

src_compile() {
	append-flags -I./include -Wall
	emake DESTDIR="${D}" CFLAGS="${CFLAGS}" LDFLAGS="${LDFLAGS}" CC="$(tc-getCC)" || die
}

src_install() {
	emake install DESTDIR="${D}" || die
	dodoc *.txt
}
