# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/librep/librep-0.17_p20070101.ebuild,v 1.1 2007/03/26 18:29:07 truedfx Exp $

MY_P=${P%_*}

WANT_AUTOCONF="latest"
WANT_AUTOMAKE="latest"

inherit autotools eutils toolchain-funcs multilib

DESCRIPTION="Shared library implementing a Lisp dialect"
HOMEPAGE="http://librep.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.gz
	mirror://gentoo/${P}.patch.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~sparc ~x86"
IUSE="readline"

RDEPEND=">=sys-libs/gdbm-1.8.0
	readline? ( sys-libs/readline )"
DEPEND="${RDEPEND}
	sys-apps/texinfo"

S=${WORKDIR}/${MY_P}

src_unpack() {
	unpack ${MY_P}.tar.gz
	cd "${S}"
	epatch "${DISTDIR}"/${P}.patch.bz2
	epatch "${FILESDIR}"/${P}-libtool.patch
	epatch "${FILESDIR}"/rep_file_fdopen.patch
	eautoreconf || die "eautoreconf failed"
}

src_compile() {
	econf \
		--libexecdir=/usr/$(get_libdir) \
		--without-gmp \
		--without-ffi \
		$(use_with readline) || die "configure failed"

	LC_ALL=C emake || die "make failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS BUGS ChangeLog NEWS README THANKS TODO TREE
	docinto doc
	dodoc doc/*
}
