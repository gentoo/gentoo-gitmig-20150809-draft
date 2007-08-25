# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/xfsdump/xfsdump-2.2.45.ebuild,v 1.8 2007/08/25 18:03:03 vapier Exp $

inherit eutils autotools

MY_P="${PN}_${PV}-1"
DESCRIPTION="xfs dump/restore utilities"
HOMEPAGE="http://oss.sgi.com/projects/xfs"
SRC_URI="ftp://oss.sgi.com/projects/xfs/download/cmd_tars/${MY_P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="alpha amd64 hppa ia64 ~mips ppc ppc64 -sparc x86"
IUSE=""

RDEPEND="sys-fs/e2fsprogs
	sys-fs/xfsprogs
	sys-apps/dmapi
	>=sys-apps/attr-2.4.19"
DEPEND="${RDEPEND}
	sys-devel/gettext"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${PN}-2.2.45-LDFLAGS.patch
	sed -i \
		-e "/^PKG_DOC_DIR/s:@pkg_name@:${PF}:" \
		-e '/^GCFLAGS/s:-O1::' \
		include/builddefs.in \
		|| die
	epatch "${FILESDIR}"/${PN}-2.2.42-Makefile-deps.patch
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
	emake DIST_ROOT="${D}" install || die
	prepalldocs
}
