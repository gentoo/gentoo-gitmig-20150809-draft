# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/librep/librep-0.17-r2.ebuild,v 1.1 2005/09/01 19:20:34 truedfx Exp $

inherit libtool toolchain-funcs multilib

DESCRIPTION="Shared library implementing a Lisp dialect"
HOMEPAGE="http://librep.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~sparc ~x86"
IUSE="readline"

RDEPEND="sys-devel/libtool
	>=sys-libs/gdbm-1.8.0
	readline? ( sys-libs/readline )"
DEPEND="${RDEPEND}
	sys-apps/texinfo"

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i -e '7s/AM_PATH_REP/[&]/' rep.m4 || die "sed failed"
	elibtoolize || die "elibtoolize failed"
}

src_compile() {
	local myconf="$(use_with readline)"
	use ppc && myconf="${myconf} --with-stack-direction=1"

	econf \
		--libexecdir=/usr/$(get_libdir) \
		--without-gmp \
		--without-ffi \
		${myconf} || die "configure failed"

	LC_ALL=C emake || die "make failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dosym ../../../bin/libtool /usr/$(get_libdir)/rep/${CHOST}/libtool
	fowners -h root:0 /usr/$(get_libdir)/rep/${CHOST}/libtool
	dodoc AUTHORS BUGS COPYING ChangeLog NEWS README THANKS TODO TREE
	docinto doc
	dodoc doc/*
}
