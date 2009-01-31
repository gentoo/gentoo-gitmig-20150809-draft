# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/ppl/ppl-0.10-r1.ebuild,v 1.1 2009/01/31 19:08:02 dirtyepic Exp $

EAPI=2

DESCRIPTION="The Parma Polyhedra Library (PPL) is a modern and reasonably complete library providing numerical abstractions especially targeted at applications in the field of analysis and verification of complex systems"
HOMEPAGE="http://www.cs.unipr.it/ppl/"
SRC_URI="http://www.cs.unipr.it/ppl/Download/ftp/releases/${PV}/${P}.tar.bz2
	ftp://ftp.cs.unipr.it/pub/ppl/releases/${PV}/${P}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~mips ~x86"
IUSE="doc prolog"

RDEPEND="prolog? ( dev-lang/swi-prolog )
		>=dev-libs/gmp-4.1.3[-nocxx]"
DEPEND="${RDEPEND}
	sys-devel/m4"


src_configure() {

	use prolog && want_prolog="swi_prolog"

	econf 												\
		--docdir=/usr/share/doc/${PF} 					\
		--disable-debugging 							\
		--disable-optimization 							\
		--enable-interfaces="c cxx ${want_prolog}"		\
		|| die
}


src_install() {

	emake DESTDIR="${D}" install || die "emake install failed"

	if use doc; then
		cd "${D}"/usr/share/doc/${PF}
		mkdir ppl ppl-watchdog
		# the library docs get installed into ${DOCDIR}/ppl/
		# move them to the right place
		mv * ppl-watchdog
		mv ../ppl .
		prepalldocs
	else
		rm -rf "${D}"/usr/share/doc/${PN}
		rm -rf "${D}"/usr/share/doc/${PF}
	fi

	dodoc NEWS README README.configure STANDARDS TODO
}
