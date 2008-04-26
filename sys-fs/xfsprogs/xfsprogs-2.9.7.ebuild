# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/xfsprogs/xfsprogs-2.9.7.ebuild,v 1.3 2008/04/26 16:06:39 rich0 Exp $

inherit eutils toolchain-funcs autotools

MY_P="${PN}_${PV}-1"
DESCRIPTION="xfs filesystem utilities"
HOMEPAGE="http://oss.sgi.com/projects/xfs/"
SRC_URI="ftp://oss.sgi.com/projects/xfs/download/cmd_tars/${MY_P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~alpha amd64 ~hppa ~ia64 ~mips ~ppc ppc64 ~sh ~sparc ~x86"
IUSE="nls"

RDEPEND="sys-fs/e2fsprogs"
DEPEND="${RDEPEND}
	nls? ( sys-devel/gettext )"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${PN}-2.8.18-symlinks.patch #166729
	sed -i \
		-e "/^PKG_DOC_DIR/s:@pkg_name@:${PF}:" \
		include/builddefs.in \
		|| die "sed include/builddefs.in failed"
	# We'll handle /lib versus /usr/lib install
	sed -i -e '/INSTALL.* -S .*LIBNAME/d' \
		include/buildmacros || die "sed symlinks"
	eautoconf
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

	# shared in /lib, static in /usr/lib, ldscript fun too
	dodir /$(get_libdir)
	mv "${D}"/usr/$(get_libdir)/lib*.so* "${D}"/$(get_libdir)/
	dosym libhandle.so.1 /$(get_libdir)/libhandle.so
	gen_usr_ldscript libhandle.so

	prepalldocs
}
