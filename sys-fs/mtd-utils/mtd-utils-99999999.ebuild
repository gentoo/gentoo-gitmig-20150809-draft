# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/mtd-utils/mtd-utils-99999999.ebuild,v 1.2 2009/12/01 03:13:00 vapier Exp $

ECVS_USER="anoncvs"
ECVS_PASS="anoncvs"
EGIT_REPO_URI="git://git.infradead.org/mtd-utils.git"
inherit git

DESCRIPTION="MTD userspace tools"
HOMEPAGE="http://git.infradead.org/?p=mtd-utils.git;a=summary"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="xattr"

RDEPEND="!sys-fs/mtd
	dev-libs/lzo
	sys-libs/zlib"
# ACL is only required for the <sys/acl.h> header file to build mkfs.jffs2
# And ACL brings in Attr as well.
DEPEND="xattr? ( sys-apps/acl )
	${DEPEND}"

src_unpack() {
	git_src_unpack
	sed -i \
		-e 's!^MANDIR.*!MANDIR = /usr/share/man!g' \
		-e 's!-include.*!!g' \
		-e '/make -C/s,make,$(MAKE),g' \
		"${S}"/Makefile
}

src_compile() {
	local myflags="-j1"
	use xattr || myflags+=" WITHOUT_XATTR=1"
	emake DESTDIR="${D}" \
		CROSS=${CHOST}- \
		OPTFLAGS="${CFLAGS}" \
		LDFLAGS="${LDFLAGS}" \
		${myflags} || die
}

src_install() {
	emake install DESTDIR="${D}" || die
	rm -rf "${D}"/usr/include || die
	dodoc *.txt
	# TODO: check ubi-utils for docs+scripts
}
