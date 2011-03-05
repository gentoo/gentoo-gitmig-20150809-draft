# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/qwt/qwt-6.0.0_rc5.ebuild,v 1.1 2011/03/05 11:34:43 jlec Exp $

EAPI="3"
inherit eutils qt4

MY_P="${PN}-${PV/_/-}"

DESCRIPTION="2D plotting library for Qt4"
HOMEPAGE="http://qwt.sourceforge.net/"
SRC_URI="mirror://sourceforge/project/${PN}/${PN}-beta/${PV/_/-}/${MY_P}.tar.bz2"

LICENSE="qwt"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-macos"
SLOT="5"
IUSE="doc examples svg"

DEPEND="
	x11-libs/qt-gui:4
	doc? ( !<media-libs/coin-3.1.3[doc] )
	svg? ( x11-libs/qt-svg:4 )"
RDEPEND="${DEPEND}"

S="${WORKDIR}"/${MY_P}

src_prepare() {
	cat > qwtconfig.pri <<-EOF
		QWT_INSTALL_LIBS = "${EPREFIX}/usr/$(get_libdir)"
		QWT_INSTALL_HEADERS = "${EPREFIX}/usr/include/qwt5"
		QWT_INSTALL_DOCS = "${EPREFIX}/usr/share/doc/${PF}"
		QWT_CONFIG += QwtDll QwtPlot QwtWidgets QwtDesigner
		VERSION = ${PV}
		QWT_INSTALL_PLUGINS   = "${EPREFIX}/usr/$(get_libdir)/qt4/plugins/designer"
		QWT_INSTALL_FEATURES  = "${EPREFIX}/usr/$(get_libdir)/qt4/features"
	EOF

	cat > qwtbuild.pri <<-EOF
		QWT_CONFIG += qt warn_on thread release no_keywords
	EOF


	# don't build examples - fix the qt files to build once installed
	cat > examples/examples.pri <<-EOF
		include( qwtconfig.pri )
		TEMPLATE     = app
		MOC_DIR      = moc
		INCLUDEPATH += "${EPREFIX}/usr/include/qwt5"
		DEPENDPATH  += "${EPREFIX}/usr/include/qwt5"
		LIBS        += -lqwt
	EOF
	sed -i -e 's:../qwtconfig:qwtconfig:' examples/examples.pro || die
	sed -i -e 's/target doc/target/' src/src.pro || die
	qt4_src_prepare
}

src_configure() {
	use svg && echo >> qwtconfig.pri "CONFIG += QwtSvg"
	cp *.pri examples/ || die
	eqmake4
}
src_compile() {
	# split compilation to allow parallel building
	emake sub-src || die "emake library failed"
	emake || die "emake failed"
}

src_install () {
	emake INSTALL_ROOT="${D}" install || die "emake install failed"
	dodoc CHANGES README
	insinto /usr/share/doc/${PF}
	if use doc; then
		doman doc/man/*/* || die
		doins -r doc/html || die
	fi
	if use examples; then
		doins -r examples || die
	fi
}
