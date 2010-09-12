# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/mtd-utils/mtd-utils-20080907.ebuild,v 1.10 2010/09/12 08:39:50 robbat2 Exp $

inherit toolchain-funcs eutils

# Git ID for the snapshot
MY_PV="${PV}-41c53b6f2d756ae995c3ffa4455576515427c5e0"
DESCRIPTION="MTD userspace tools, based on GIT snapshot from upstream (NFTL, JFFS2, NAND, FTL, UBI)"
HOMEPAGE="http://git.infradead.org/?p=mtd-utils.git;a=summary"
SRC_URI="mirror://gentoo/${PN}-snapshot-${MY_PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm ~mips ppc x86"
IUSE="xattr"

# We need libuuid
RDEPEND="!sys-fs/mtd
	dev-libs/lzo
	sys-libs/zlib
	>=sys-apps/util-linux-2.16"
# ACL is only required for the <sys/acl.h> header file to build mkfs.jffs2
# And ACL brings in Attr as well.
DEPEND="${RDEPEND}
	xattr? ( sys-apps/acl )"

S=${WORKDIR}/${PN}

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i 's:-Werror::' $(find . -name Makefile)
	epatch "${FILESDIR}"/mtd-utils-fixup.patch
	sed -i -e 's:\<ar\>:$(AR):' tests/ubi-tests/Makefile || die
	sed -i -e 's:\<ranlib\>:$(RANLIB):' ubi-utils/new-utils/Makefile || die
}

src_compile() {
	tc-export AR RANLIB
	# -j1 for #276374
	emake -j1 \
		CC="$(tc-getCC)" \
		OPTFLAGS="${CFLAGS}" \
		$(use xattr || echo WITHOUT_XATTR=1) \
		|| die
}

src_install() {
	emake install DESTDIR="${D}" || die
	newman ubi-utils/doc/unubi.roff unubi.1
	dodoc *.txt */*.TXT
	newdoc mkfs.ubifs/README README.mkfs.ubifs
	newdoc ubi-utils/README README.ubi-utils
	newdoc ubi-utils/new-utils/README README.new-utils
	# TODO: check ubi-utils for docs+scripts
}
