# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/xfsdump/xfsdump-2.2.38.ebuild,v 1.1 2006/08/10 03:44:47 vapier Exp $

inherit eutils autotools

MY_P="${PN}_${PV}-1"
DESCRIPTION="xfs dump/restore utilities"
HOMEPAGE="http://oss.sgi.com/projects/xfs"
SRC_URI="ftp://oss.sgi.com/projects/xfs/download/cmd_tars/${MY_P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~mips ~ppc ~ppc64 -sparc ~x86"
IUSE=""

DEPEND="sys-fs/e2fsprogs
	sys-fs/xfsprogs
	sys-apps/dmapi
	>=sys-apps/attr-2.4.19"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${PN}-2.2.33-no-compress-docs.patch
	sed -i \
		-e "/^PKG_DOC_DIR/s:@pkg_name@:${PF}:" \
		-e '/^GCFLAGS/s:-O1::' \
		include/builddefs.in \
		|| die
	epatch "${FILESDIR}"/${PN}-2.2.33-Makefile-deps.patch
	for i in restore dump invutil ; do
		sed -i \
			-e 's|@$(RM) $@; $(LN_S)|$(RM) $@; $(LN_S)|g' \
			"${S}"/${i}/Makefile || die
	done
	eautoconf
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
