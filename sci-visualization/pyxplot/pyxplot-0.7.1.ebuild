# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-visualization/pyxplot/pyxplot-0.7.1.ebuild,v 1.1 2009/11/26 20:07:50 bicatali Exp $

EAPI=2
inherit eutils python

DESCRIPTION="Gnuplot like graphing program publication-quality figures"
HOMEPAGE="http://www.pyxplot.org.uk/"
SRC_URI="http://www.pyxplot.org.uk/src/${PN}_${PV}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="virtual/latex-base
	sci-libs/scipy
	app-text/gv
	|| ( media-gfx/imagemagick media-gfx/graphicsmagick[imagemagick] )"
DEPEND="${RDEPEND}"

S="${WORKDIR}/${PN}"

src_prepare() {
	python_version
	sed -i \
		-e "s:^\(USRDIR=\).*:\1/usr:g" \
		-e "s:^\(SRCDIR=\).*:\1/usr/$(get_libdir)/python${PYVER}/${PN}:g" \
		-e 's:^\(MANDIR=\).*:\1${USRDIR}/share/man/man1:g' \
		-e "s:^\(DOCDIR=\).*:\1\${USRDIR}/share/doc/${PF}:g" \
		-e '/install:/,$s:${\(SRC\|BIN\|DOC\|MAN\)DIR:${DESTDIR}/${\1DIR:g' \
		-e "/pyc/d" \
		-e 's/ex_\*/{ex_,fig}\*/' \
		Makefile.skel || die "sed Makefile.skel failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc README AUTHORS ChangeLog
}
