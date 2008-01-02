# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/mtd-utils/mtd-utils-20080102.ebuild,v 1.1 2008/01/02 21:36:51 robbat2 Exp $

inherit toolchain-funcs flag-o-matic

DESCRIPTION="MTD userspace tools, based on GIT snapshot from upstream"
HOMEPAGE="http://git.infradead.org/?p=mtd-utils.git;a=summary"

# Git ID for the snapshot
MY_PV="${PV}-9ba41c4dc891e38c92126bfcc4c366d765841da0"
SRC_URI="mirror://gentoo/${PN}-snapshot-${MY_PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~arm ~mips ~ppc ~x86"
IUSE="xattr"

S=${WORKDIR}/${PN}.git

RDEPEND="!sys-fs/mtd
		sys-libs/zlib"
# ACL is only required for the <sys/acl.h> header file to build mkfs.jffs2
# And ACL brings in Attr as well.
DEPEND="xattr? ( sys-apps/acl )
		${DEPEND}"

src_unpack() {
	unpack ${A}
	sed -i.orig \
		-e 's!^MANDIR.*!MANDIR = /usr/share/man!g' \
		-e 's!-include.*!!g' \
		-e '/make -C/s,make,$(MAKE),g' \
		"${S}"/Makefile
}

src_compile() {
	local myflags=""
	use xattr || myflags="WITHOUT_XATTR=1"
	emake DESTDIR="${D}" \
		OPTFLAGS="${CFLAGS}" \
		LDFLAGS="${LDFLAGS}" \
		CC="$(tc-getCC)" \
		${myflags} || die
}

src_install() {
	emake install DESTDIR="${D}" || die
	dodoc *.txt
	# TODO: check ubi-utils for docs+scripts
}
