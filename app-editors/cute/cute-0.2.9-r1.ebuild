# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/cute/cute-0.2.9-r1.ebuild,v 1.5 2005/08/18 18:51:04 hansmi Exp $

inherit distutils

MY_P=${PN}-${PV/*.*.*.*/${PV%.*}-${PV##*.}}

DESCRIPTION="CUTE is a Qt and  Scintilla based text editor which can be easily extended using Python"
HOMEPAGE="http://cute.sourceforge.net/"
SRC_URI="mirror://sourceforge/cute/${MY_P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ppc x86"
IUSE="doc"

DEPEND="sys-apps/sed
	virtual/python
	<dev-python/qscintilla-1.6"

src_unpack() {
	unpack ${A}
	distutils_python_version
	cd ${S} ; sed -i -e "s:qscintilla::" cute.pro
	rm -rf ${S}/qscintilla ; cd ${S}/cute

	sed -i -r -e "s:#define DOC_PATH.*:#define DOC_PATH \"/usr/share/doc/${P}/index.html\":" config.h

	# (multi-)lib fix
	sed -i -r -e "s:^QEXTSCINTILLADIR =.*:QEXTSCINTILLADIR = /usr/$(get_libdir):" \
		-e "s:^PYTHON_INCLUDE_DIR =.*:PYTHON_INCLUDE_DIR = /usr/include/python${PYVER}/:" \
		-e "s:^PYTHON_LIB_DIR =.*:PYTHON_LIB_DIR = /usr/$(get_libdir)/python${PYVER}/:" \
		-e "s:unix\:INCLUDEPATH=.*:unix\:INCLUDEPATH= ${QTDIR}/include /usr/include \\\\:" \
		-e "s:-lpython2.2:-lpython${PYVER}:" \
		-e "s:SCINTILLADIR/lib:SCINTILLADIR:" cute.pro

	echo -e "\nQMAKE_CFLAGS_RELEASE=${CFLAGS} -w\nQMAKE_CXXFLAGS_RELEASE=${CXXFLAGS} -w\nQMAKE_LFLAGS_RELEASE=${LDFLAGS}" >> cute.pro
}

src_compile() {
	cd ${S}/cute
	[ -d "$QTDIR/etc/settings" ] && addwrite "$QTDIR/etc/settings"
	addpredict "$QTDIR/etc/settings"
	${QTDIR}/bin/qmake -o Makefile cute.pro
	emake || die
}

src_install() {
	dobin ${S}/bin/cute
	use doc && ( dohtml -r ${S}/cute/doc/doc/*
			dosym index.html /usr/share/doc/${PF}/html/book1.html
			insinto /usr/share/doc/${PF}/api
			doins ${S}/cute/cute-api/html/* )
	insinto /usr/share/cute/langs
	doins ${S}/cute/langs/*
	insinto /usr/share/cute/lib/scripts/
	doins ${S}/cute/scripts/*
	insinto /usr/share/icons
	doins ${S}/cute/icons/cute.xpm
	dodoc changelog.txt LICENSE INSTALL README
}
