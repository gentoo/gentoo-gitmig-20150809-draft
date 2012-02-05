# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-visualization/pyxplot/pyxplot-0.8.3.ebuild,v 1.3 2012/02/05 02:00:09 floppym Exp $

EAPI="2"
PYTHON_DEPEND="2"

inherit eutils multilib python flag-o-matic

DESCRIPTION="Gnuplot like graphing program publication-quality figures"
HOMEPAGE="http://www.pyxplot.org.uk/"
SRC_URI="mirror://sourceforge/${PN}/${PN}_${PV}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="virtual/latex-base
	sci-libs/cfitsio
	sci-libs/fftw:3.0
	>=sci-libs/gsl-1.10
	sci-libs/scipy
	media-libs/libpng
	dev-libs/libxml2:2
	app-text/gv
	|| ( media-gfx/imagemagick media-gfx/graphicsmagick[imagemagick] )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

pkg_setup() {
	python_set_active_version 2
	python_pkg_setup
}

src_prepare() {
	epatch "${FILESDIR}"/${PN}-0.8.3-as-needed.patch
	# upstream: does not work with -O1 and above
	replace-flags -O? -O0
	sed -i \
		-e 's:/local:/:' \
		-e "s:/lib/:/$(get_libdir)/:" \
		-e "s:\${USRDIR}/share/${PN}:/$(python_get_sitedir)/${PN}:" \
		-e "s:/doc/${PN}:/doc/${PF}:" \
		Makefile.skel || die "sed Makefile.skel failed"
	sed -i -e 's/-ltermcap//' configure
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc README AUTHORS ChangeLog
}
