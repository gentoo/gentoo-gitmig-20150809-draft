# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/xfsprogs/xfsprogs-3.0.3.ebuild,v 1.2 2010/04/05 20:58:24 maekke Exp $

inherit eutils toolchain-funcs multilib

DESCRIPTION="xfs filesystem utilities"
HOMEPAGE="http://oss.sgi.com/projects/xfs/"
SRC_URI="ftp://oss.sgi.com/projects/xfs/cmd_tars/${P}.tar.gz
	ftp://oss.sgi.com/projects/xfs/previous/cmd_tars/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~alpha amd64 arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sh ~sparc x86"
IUSE="nls static"

RDEPEND="sys-fs/e2fsprogs
	!<sys-fs/xfsdump-3"
DEPEND="${RDEPEND}
	nls? ( sys-devel/gettext )"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${PN}-3.0.1-sharedlibs.patch
	sed -i \
		-e "/^PKG_DOC_DIR/s:@pkg_name@:${PF}:" \
		include/builddefs.in \
		|| die "sed include/builddefs.in failed"
	sed -i '1iLLDFLAGS = -static' {estimate,fsr}/Makefile
	sed -i \
		-e "/LLDFLAGS/s:-static:$(use static && echo -all-static):" \
		$(find -name Makefile)
}

src_compile() {
	export DEBUG=-DNDEBUG
	export OPTIMIZER=${CFLAGS}
	unset PLATFORM # if set in user env, this breaks configure
	econf \
		--bindir=/usr/bin \
		--sbindir=/sbin \
		--libexecdir=/usr/$(get_libdir) \
		$(use_enable nls gettext) \
		|| die "config failed"
	emake || die
}

src_install() {
	emake DIST_ROOT="${D}" install install-dev || die "make install failed"
	# handle is for xfsdump, the rest for xfsprogs
	gen_usr_ldscript -a disk handle xfs xlog
	prepalldocs
}
