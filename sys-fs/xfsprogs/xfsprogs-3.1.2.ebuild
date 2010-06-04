# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/xfsprogs/xfsprogs-3.1.2.ebuild,v 1.2 2010/06/04 02:27:13 mr_bones_ Exp $

EAPI="3"

inherit eutils toolchain-funcs multilib

DESCRIPTION="xfs filesystem utilities"
HOMEPAGE="http://oss.sgi.com/projects/xfs/"
SRC_URI="ftp://oss.sgi.com/projects/xfs/cmd_tars/${P}.tar.gz
	ftp://oss.sgi.com/projects/xfs/previous/cmd_tars/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sh ~sparc ~x86"
IUSE="libedit nls readline static static-libs"

RDEPEND=">=sys-apps/util-linux-2.17.2
	!<sys-fs/xfsdump-3
	readline? (
		!libedit? ( sys-libs/readline
			static? ( sys-libs/ncurses )
		)
	)
	libedit? ( dev-libs/libedit )"
DEPEND="${RDEPEND}
	nls? ( sys-devel/gettext )"

pkg_setup() {
	if use readline && use libedit ; then
		ewarn "You enabled both readline and libedit support but only one can be supported"
		ewarn "Using libedit. Please disable the libedit USE flag if you want readline."
	fi

	if use static && use !static-libs ; then
		ewarn "Can't build a static variant of the executables without static-libs."
		ewarn "Static libs will also be built."
	fi
}

src_prepare() {
	epatch "${FILESDIR}/${PN}-3.1.1-sharedlibs.patch"

	sed -i \
		-e "/^PKG_DOC_DIR/s:@pkg_name@:${PF}:" \
		include/builddefs.in \
		|| die "sed include/builddefs.in failed"
	sed -i \
		-e '1iLLDFLAGS = -static' \
		{estimate,fsr}/Makefile || die "sed failed"

	sed -i \
		-e "/LLDFLAGS/s:-static:$(use static && echo -all-static):" \
		$(find -name Makefile) || die "sed failed"

	# TODO: write a patch for configure.in to use pkg-config for the uuid-part
	if use static && use readline ; then
		sed -i \
			-e 's|-lreadline|\0 -lncurses|' \
			-e 's|-lblkid|\0 -luuid|' \
			configure || die "sed failed"
	fi
}

src_configure() {
	export DEBUG="-DNDEBUG"
	export OPTIMIZER="${CFLAGS}"
	unset PLATFORM # if set in user env, this breaks configure

	local myconf=""

	if use libedit ; then
		myconf="--disable-readline --enable-editline"
	elif use readline ; then
		myconf="--enable-readline --disable-editline"
	else
		myconf="--disable-readline --disable-editline"
	fi

	if use static || use static-libs ; then
		myconf="${myconf} --enable-static"
	else
		myconf="${myconf} --disable-static"
	fi

	econf \
		--bindir=/usr/bin \
		--libexecdir=/usr/$(get_libdir) \
		$(use_enable static-libs static) \
		$(use_enable nls gettext) \
		${myconf}

	MAKEOPTS="${MAKEOPTS} V=1"
}

src_install() {
	# TODO: there is a seldomly triggered parallel install problem where
	# libxfs.so doesn't get installed before rdeps causing the relink to fail
	emake -j1 DIST_ROOT="${D}" install install-dev || die "emake install failed"

	dosym libxfs.so.0 /$(get_libdir)/libxfs.so
	dosym libxlog.so.0 /$(get_libdir)/libxlog.so

	# removing duplicated libraries
	rm "${D}"/lib*/lib{handle,xcmd}.* "${D}"/usr/lib*/lib{xfs,xlog}.so*

	# removing unnecessary .la files if not needed
	( use static || use static-libs ) || rm -rf "${D}"/usr/lib*/*.la

	# handle is for xfsdump, the rest for xfsprogs
	gen_usr_ldscript libxfs.so libxlog.so
	prepalldocs
}
