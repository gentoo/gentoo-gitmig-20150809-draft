# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-visualization/hippodraw/hippodraw-1.21.3-r1.ebuild,v 1.9 2009/12/15 23:26:12 markusle Exp $

EAPI=2

inherit eutils autotools multilib qt3 qt4

MY_PN=HippoDraw

DESCRIPTION="Highly interactive data analysis Qt environment for C++ and python"
HOMEPAGE="http://www.slac.stanford.edu/grp/ek/hippodraw/"
SRC_URI="ftp://ftp.slac.stanford.edu/users/pfkeb/${PN}/${MY_PN}-${PV}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE="doc examples +fits +numpy qt4 root wcs"

CDEPEND="dev-libs/boost[python]
	virtual/latex-base
	media-libs/netpbm
	dev-lang/python[threads]
	fits? ( sci-libs/cfitsio )
	numpy? ( dev-python/numpy )
	qt4? (
		x11-libs/qt-gui:4
		x11-libs/qt-qt3support:4
		x11-libs/qt-assistant:4
	)
	!qt4? ( x11-libs/qt:3 )
	root? ( >=sci-physics/root-5 )
	!root? ( sci-libs/minuit )
	wcs? ( sci-astronomy/wcslib )"

DEPEND="${CDEPEND}
	doc? ( app-doc/doxygen )"

RDEPEND="${CDEPEND}
	numpy? ( fits? ( dev-python/pyfits ) )"

S="${WORKDIR}/${MY_PN}-${PV}"

pkg_setup() {
	use qt4 && qt4_pkg_setup
}

src_prepare() {
	epatch "${FILESDIR}"/${P}-gcc4.3.patch
	epatch "${FILESDIR}"/${P}-gcc4.4.patch
	epatch "${FILESDIR}"/${P}-numarray.patch
	epatch "${FILESDIR}"/${P}-test-fix.patch
	epatch "${FILESDIR}"/${P}-minuit2.patch
	epatch "${FILESDIR}"/${P}-wcslib.patch
	epatch "${FILESDIR}"/${P}-qt4.patch
	epatch "${FILESDIR}"/${P}-autoconf-2.64.patch

	# fix the install doc directory to gentoo's one
	local docdir=/usr/share/doc/${PF}
	sed -i \
		-e "s:\(docdir\).*=.*:\1= ${docdir}:" \
		-e "s:\(INSTALLDIR\).*=.*:\1= \$(DESTDIR)${docdir}/html:" \
		-e "/^DOCS_STR/s:\(DOCS_STR\).*=.*:\1 = \\\\\"${docdir}/html\\\\\":" \
		-e "s:\$(pkgdatadir)/examples:${docdir}/examples:" \
		-e 's:LICENSE:README:' \
		{.,doc,examples,qt}/Makefile.am || die "sed for docdir failed"

	AT_M4DIR=config/m4 eautoreconf
}

src_configure() {
	local myconf="
		--disable-numarraybuild
		$(use_enable numpy numpybuild)
		$(use_enable doc help)"
	# All these longuish conf options are necessary
	# or else a huge patch
	if use qt4; then
		myconf="${myconf} --with-Qt-include-dir=no"
		myconf="${myconf} --with-Qt-lib-dir=no"
		myconf="${myconf} --with-Qt-bin-dir=no"
		myconf="${myconf} --with-qt4-include=/usr/include/qt4"
		myconf="${myconf} --with-qt4-lib=/usr/$(get_libdir)/qt4"
		myconf="${myconf} --with-qt4-dir=/usr"
	else
		myconf="${myconf} --with-Qt-include-dir=/usr/qt/3/include"
		myconf="${myconf} --with-Qt-lib-dir=/usr/qt/3/$(get_libdir)"
		myconf="${myconf} --with-Qt-bin-dir=/usr/qt/3/bin"
		myconf="${myconf} --with-qt4-include=no"
		myconf="${myconf} --with-qt4-lib=no"
		myconf="${myconf} --with-qt4-dir=no"
	fi

	if use root; then
		myconf="${myconf} --with-root-include=$(root-config --incdir)"
		myconf="${myconf} --with-root-lib=$(root-config --libdir)"
		myconf="${myconf} --with-minuit2-lib=no"
	else
		myconf="${myconf} --with-minuit2-include=/usr/include"
		myconf="${myconf} --with-minuit2-lib=/usr/$(get_libdir)"
		myconf="${myconf} --with-root-lib=no"
	fi

	if use fits; then
		myconf="${myconf} --with-cfitsio-include=/usr/include"
		myconf="${myconf} --with-cfitsio-lib=/usr/$(get_libdir)"
	else
		myconf="${myconf} --with-cfitsio-lib=no"
	fi

	if use wcs; then
		myconf="${myconf} --with-wcslib-include=/usr/include"
		myconf="${myconf} --with-wcslib-lib=/usr/$(get_libdir)"
	else
		myconf="${myconf} --with-wcslib-include=no"
		myconf="${myconf} --with-wcslib-lib=no"
	fi

	econf ${myconf} || die "econf failed"
}

src_compile() {
	emake || die "emake failed"
	if use doc; then
		emake docs || die "emake docs failed"
	fi
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dosym ../${MY_PN}/hippoApp.png /usr/share/pixmaps/hippoApp.png
	make_desktop_entry hippodraw HippoDraw hippoApp
	if use examples; then
		insinto /usr/share/doc/${PF}/testsuite
		doins testsuite/*.py || die "examples install failed"
		insinto /usr/share/doc/${PF}/examples
		doins examples/*.{fits,tnt,data,baddata}*
	else
		# these are automatically installed
		rm -rf "${D}"usr/share/doc/${PF}/examples || die
	fi
}
