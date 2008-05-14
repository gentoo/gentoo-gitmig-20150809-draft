# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-visualization/pyxplot/pyxplot-0.6.3.1.ebuild,v 1.4 2008/05/14 17:21:42 grozin Exp $

inherit eutils python

DESCRIPTION="Graphing program similar to gnuplot to produce publication-quality figures"
HOMEPAGE="http://www.pyxplot.org.uk/"
SRC_URI="http://www.pyxplot.org.uk/src/${PN}_${PV}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
# test is actually done during emake in src_compile
RESTRICT="test"

# should use xdg-utils once those are working for postcript viewers
RDEPEND=">=dev-python/pyx-0.9
	sci-libs/scipy
	virtual/tetex
	virtual/ghostscript
	|| ( app-text/gv app-text/ggv )
	media-gfx/imagemagick"
DEPEND="${RDEPEND}"
S="${WORKDIR}/${PN}"

src_unpack() {
	unpack ${A}
	cd "${S}"

	sed -i \
		-e "s:^\(USRDIR=\).*:\1/usr:g" \
		-e 's:^\(MANDIR=\).*:\1${USRDIR}/share/man/man1:g' \
		-e "s:^\(DOCDIR=\).*:\1\${USRDIR}/share/doc/${PF}:g" \
		Makefile.skel || die "sed Makefile.skel failed"

	epatch "${FILESDIR}"/${PV}-dont-build-pyx.patch
	# Depends on dont-build-pyx.patch
	epatch "${FILESDIR}"/${PV}-respect-destdir.patch

	# It doesn't come with precompiled .pyc files,
	# so fails if we try to install them.
	sed -i \
		-e "/pyc/d" \
		Makefile.skel || die "sed pyx failed"

	# allows proper commands
	sed -i \
		-e 's/${MAKE_COMMAND}/$(MAKE)/g' \
		-e "s:\${PYTHON_COMMAND}:/usr/bin/python$(python_version):g" \
		Makefile.skel || die "sed commands failed"

	# install fig_init for examples to work once installed
	sed -i \
		-e 's/ex_\*/{ex_,fig}\*/' \
		Makefile.skel || die "sed examples failed"

}

src_compile() {
	econf || die "econf failed"
	# To prevent sandbox violations by metafont
	VARTEXFONTS="${T}"/fonts emake -j1 || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc README AUTHORS ChangeLog || die "dodoc failed"
}

pkg_postinst() {
	python_mod_optimize "${ROOT}/usr/share/${PN}"
}

pkg_postrm() {
	python_mod_cleanup "${ROOT}/usr/share/${PN}"
}
