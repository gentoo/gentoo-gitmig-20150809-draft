# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/ecls/ecls-9.12.3.ebuild,v 1.1 2009/12/17 12:04:22 grozin Exp $

EAPI=2
inherit eutils multilib

MY_P=ecl-${PV}

DESCRIPTION="ECL is an embeddable Common Lisp implementation."
HOMEPAGE="http://common-lisp.net/project/ecl/"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tgz"
RESTRICT="mirror"

LICENSE="BSD LGPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE="X debug +threads +unicode"

RDEPEND="dev-libs/gmp
		dev-libs/libffi
		>=dev-libs/boehm-gc-7.1[threads?]"
		# cxx? ( dev-libs/boehm-gc[-nocxx] )"
DEPEND="${RDEPEND}
		app-text/texi2html"
PDEPEND="dev-lisp/gentoo-init"

PROVIDE="virtual/commonlisp"

S="${WORKDIR}"/ecl-${PV}

src_prepare() {
	epatch "${FILESDIR}"/${PV}-headers-gentoo.patch
}

src_configure() {
	# $(use_with cxx)
	econf \
		--with-system-gmp \
		--enable-boehm=system \
		--enable-gengc \
		--enable-longdouble \
		$(use_enable debug) \
		$(use_enable threads) \
		$(use_with threads __thread) \
		$(use_enable unicode) \
		$(use_with X x) \
		$(use_with X clx) \
		|| die "econf failed"
}

src_compile() {
	#parallel fails
	emake -j1 || die "make failed"
}

src_install () {
	emake DESTDIR="${D}" install || die "Could not build ECL"

	dohtml doc/*.html
	dodoc ANNOUNCEMENT Copyright
	dodoc "${FILESDIR}"/README.Gentoo
}
