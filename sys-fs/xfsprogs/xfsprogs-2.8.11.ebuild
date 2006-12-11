# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/xfsprogs/xfsprogs-2.8.11.ebuild,v 1.7 2006/12/11 20:53:19 welp Exp $

WANT_AUTOCONF="latest"
WANT_AUTOMAKE="latest"
inherit flag-o-matic eutils autotools toolchain-funcs

MY_P="${PN}_${PV}-1"
DESCRIPTION="xfs filesystem utilities"
HOMEPAGE="http://oss.sgi.com/projects/xfs/"
SRC_URI="ftp://oss.sgi.com/projects/xfs/download/cmd_tars/${MY_P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~alpha amd64 hppa ~ia64 ~mips ~ppc ppc64 ~sh ~sparc x86"
IUSE="nls"

RDEPEND="sys-fs/e2fsprogs"
DEPEND="${RDEPEND}
	nls? ( sys-devel/gettext )"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-kern-types.patch #131483
	epatch "${FILESDIR}"/${PN}-2.7.11-no-compress-docs.patch #129486
	# Inject our own CFLAGS / docpath
	sed -i \
		-e "/^PKG_DOC_DIR/s:@pkg_name@:${PF}:" \
		-e '/^GCFLAGS/s:-O1::' \
		include/builddefs.in \
		|| die "sed include/builddefs.in failed"
	# make sure the PLATFORM envvar doesn't break crap
	sed -i -e '/PLATFORM/d' configure.in || die "sed PLATFORM"
	# We'll handle /lib versus /usr/lib install
	sed -i -e '/INSTALL.* -S .*LIBNAME/d' \
		include/buildmacros || die "sed symlinks"
	eautoconf
}

src_compile() {
	export OPTIMIZER=${CFLAGS}
	export DEBUG=-DNDEBUG

	econf \
		--bindir=/usr/bin \
		--sbindir=/sbin \
		--libexecdir=/usr/$(get_libdir) \
		$(use_enable nls gettext) \
		|| die "config failed"
	emake || die
}

src_install() {
	make DIST_ROOT="${D}" install install-dev || die "make install failed"

	# shared in /lib, static in /usr/lib, ldscript fun too
	dodir /$(get_libdir)
	mv "${D}"/usr/$(get_libdir)/lib*.so* "${D}"/$(get_libdir)/
	dosym libhandle.so.1 /$(get_libdir)/libhandle.so
	gen_usr_ldscript libhandle.so

	prepalldocs
}
