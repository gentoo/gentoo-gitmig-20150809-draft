# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/mftrace/mftrace-1.2.16.ebuild,v 1.2 2011/06/30 18:49:04 jer Exp $

EAPI="3"
PYTHON_DEPEND="2"

inherit python multilib toolchain-funcs

DESCRIPTION="Traces TeX fonts to PFA or PFB fonts (formerly pktrace)"
HOMEPAGE="http://lilypond.org/mftrace/"
SRC_URI="http://lilypond.org/download/sources/mftrace/${P}.tar.gz"
LICENSE="GPL-2"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~sparc ~x86"
# SLOT 1 was used in pktrace ebuild
SLOT="1"
IUSE="truetype"

DEPEND="|| ( media-gfx/potrace >=media-gfx/autotrace-0.30 )"
RDEPEND="${DEPEND}
	virtual/latex-base
	>=app-text/t1utils-1.25
	truetype? ( media-gfx/fontforge )"

pkg_setup() {
	python_set_active_version 2
}

src_configure() {
	tc-export CC
	econf --datadir=$(python_get_sitedir)
}

src_compile() {
	emake CFLAGS="-Wall ${CFLAGS}" || die "emake failed"
}

src_install () {
	emake DESTDIR="${D}" PYC_MODULES="" install || die "make install failed"
	dodoc README.txt ChangeLog
}

pkg_postinst() {
	python_mod_optimize mftrace
}

pkg_postrm() {
	python_mod_cleanup mftrace
}
