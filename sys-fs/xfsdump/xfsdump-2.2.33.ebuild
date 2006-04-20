# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/xfsdump/xfsdump-2.2.33.ebuild,v 1.2 2006/04/20 01:40:49 vapier Exp $

inherit eutils

DESCRIPTION="xfs dump/restore utilities"
HOMEPAGE="http://oss.sgi.com/projects/xfs"
SRC_URI="ftp://oss.sgi.com/projects/xfs/download/cmd_tars/${P}.src.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~mips ~ppc -sparc ~x86"
IUSE=""

DEPEND="sys-fs/e2fsprogs
	sys-fs/xfsprogs
	sys-apps/dmapi
	>=sys-apps/attr-2.4.19"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/xfsdump-2.2.30-docs.patch
	epatch "${FILESDIR}"/${P}-LDFLAGS.patch #126825
	sed -i \
		-e "/^PKG_DOC_DIR/s:=.*:= /usr/share/doc/${PF}:" \
		-e '/^GCFLAGS/s:-O1::' \
		include/builddefs.in \
		|| die
}

src_compile() {
	export OPTIMIZER=${CFLAGS}
	export DEBUG=-DNDEBUG

	econf \
		--libdir=/$(get_libdir) \
		--libexecdir=/usr/$(get_libdir) \
		--sbindir=/sbin \
		|| die
	emake || die
}

src_install() {
	make DIST_ROOT="${D}" install || die
	prepalldocs
}
