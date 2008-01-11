# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/ecls/ecls-0.9j_p1.ebuild,v 1.1 2008/01/11 14:50:18 hkbst Exp $

inherit eutils multilib

DESCRIPTION="ECL is an embeddable Common Lisp implementation."
SRC_URI="mirror://sourceforge/${PN}/ecl-${PV/_/-}.tgz"
HOMEPAGE="http://ecls.sourceforge.net/"
SLOT="0"
LICENSE="BSD LGPL-2"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"

DEPEND="=dev-libs/gmp-4*
		app-text/texi2html
		>=dev-libs/boehm-gc-6.8"

IUSE="X threads unicode"

PROVIDE="virtual/commonlisp"

S="${WORKDIR}"/ecl-${PV:0:4}

_src_unpack() {
	unpack ${A}
	epatch "${FILESDIR}"/${PV}-headers-gentoo.patch
}

src_compile() {
	econf \
		--with-system-gmp \
		--enable-boehm=system \
		--enable-longdouble \
		--enable-c99-complex \
		$(use_with threads) \
		$(use_with threads __thread) \
		$(use_with unicode) \
		$(use_with X x) \
		$(use_with X clx) \
		|| die "econf failed"
	#parallel fails
	emake -j1 || die "make failed"
}

src_install () {
	emake DESTDIR="${D}" install || die

	dohtml doc/*.html
	dodoc ANNOUNCEMENT Copyright

#	dodoc "${FILESDIR}"/README.Gentoo
}
