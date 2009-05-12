# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/ppl/ppl-0.10.2.ebuild,v 1.2 2009/05/12 14:54:45 jer Exp $

EAPI=2

inherit eutils

DESCRIPTION="The Parma Polyhedra Library provides numerical abstractions for analysis of complex systems"
HOMEPAGE="http://www.cs.unipr.it/ppl/"
SRC_URI="http://www.cs.unipr.it/ppl/Download/ftp/releases/${PV}/${P}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~mips ~x86"
IUSE="doc pch prolog test watchdog"

RDEPEND="prolog? ( dev-lang/swi-prolog[gmp] )
		>=dev-libs/gmp-4.1.3[-nocxx]"
DEPEND="${RDEPEND}
	sys-devel/m4"

pkg_setup() {
	if use test; then
		ewarn "The PPL testsuite will be run."
		ewarn "Note that this can take several hours to complete on a fast machine."
		epause 3
	fi
}

src_configure() {
	use prolog && want_prolog="swi_prolog"
	use test && want_check="--enable-check=quick"

	econf 												\
		--docdir=/usr/share/doc/${PF} 					\
		--disable-debugging 							\
		--disable-optimization 							\
		$(use_enable pch)                               \
		$(use_enable watchdog)							\
		--enable-interfaces="c cxx ${want_prolog}"		\
		${want_check}                                   \
		|| die "configure failed"
}

src_test() {
	# default src_test runs with -j1, overriding it here saves about
	# 30 minutes and recommended by upstream
	if emake -j1 check -n &> /dev/null; then
		emake check || die "tests failed"
	fi
}

src_install() {
	emake DESTDIR="${D}" install || die "install failed"

	if ! use doc; then
		rm -r "${D}"/usr/share/doc/${PF}/ppl-user*-html
		rm -r "${D}"/usr/share/doc/${PF}/pwl-user*-html
	fi

	cd "${S}"
	dodoc NEWS README README.configure STANDARDS TODO
}
