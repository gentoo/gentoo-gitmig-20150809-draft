# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/xfsprogs/xfsprogs-2.7.11.ebuild,v 1.7 2006/04/29 17:31:29 gmsoft Exp $

inherit flag-o-matic eutils

DESCRIPTION="xfs filesystem utilities"
HOMEPAGE="http://oss.sgi.com/projects/xfs/"
SRC_URI="ftp://oss.sgi.com/projects/xfs/download/cmd_tars/${P}.src.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~alpha ~amd64 hppa ~ia64 mips ppc ~ppc64 ~sparc x86"
IUSE="nls"

RDEPEND="sys-fs/e2fsprogs"
DEPEND="${RDEPEND}
	nls? ( sys-devel/gettext )"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-no-compress-docs.patch #129486
	epatch "${FILESDIR}"/${P}-LDFLAGS.patch #126825
	# Inject our own CFLAGS / docpath
	sed -i \
		-e '/^GCFLAGS/s:-O1::' \
		-e "/^PKG_DOC_DIR/s:=.*:= /usr/share/doc/${PF}:" \
		include/builddefs.in \
		|| die "sed include/builddefs.in failed"
	# make sure the PLATFORM envvar doesn't break crap
	sed -i -e '/PLATFORM/d' configure || die "sed PLATFORM"
	# We'll handle /lib versus /usr/lib install
	sed -i -e '/INSTALL.* -S .*LIBNAME/d' \
		include/buildmacros || die "sed symlinks"
}

src_compile() {
	replace-flags -O[2-9] -O1
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
