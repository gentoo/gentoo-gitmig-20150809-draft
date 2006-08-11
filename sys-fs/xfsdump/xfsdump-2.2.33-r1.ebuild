# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/xfsdump/xfsdump-2.2.33-r1.ebuild,v 1.4 2006/08/11 21:35:15 dertobi123 Exp $

inherit eutils

DESCRIPTION="xfs dump/restore utilities"
HOMEPAGE="http://oss.sgi.com/projects/xfs"
SRC_URI="ftp://oss.sgi.com/projects/xfs/download/cmd_tars/${P}.src.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~mips ppc ~ppc64 -sparc x86"
IUSE=""

DEPEND="sys-fs/e2fsprogs
	sys-fs/xfsprogs
	sys-apps/dmapi
	>=sys-apps/attr-2.4.19"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-no-compress-docs.patch
	epatch "${FILESDIR}"/${P}-LDFLAGS.patch #126825
	sed -i \
		-e "/^PKG_DOC_DIR/s:=.*:= /usr/share/doc/${PF}:" \
		-e '/^GCFLAGS/s:-O1::' \
		include/builddefs.in \
		|| die
	epatch "${FILESDIR}"/${P}-Makefile-deps.patch
	for i in restore dump invutil ; do
		sed -i.orig \
			-e 's|@$(RM) $@; $(LN_S)|$(RM) $@; $(LN_S)|g' \
			${S}/${i}/Makefile || die
	done
}

src_compile() {
	export OPTIMIZER="${CFLAGS}"
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
