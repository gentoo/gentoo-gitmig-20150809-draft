# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/cute/cute-0.2.9.ebuild,v 1.1 2004/08/03 19:38:12 carlo Exp $

inherit distutils

MY_P=${PN}-${PV/*.*.*.*/${PV%.*}-${PV##*.}}

DESCRIPTION="CUTE is a Qt and  Scintilla based text editor which can be easily extended using Python"
HOMEPAGE="http://cute.sourceforge.net/"
SRC_URI="mirror://sourceforge/cute/${MY_P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc"
IUSE="doc"

DEPEND="sys-apps/sed
	virtual/python
	>=x11-libs/qt-3.1
	=dev-python/qscintilla-1.60"

src_unpack() {
	unpack ${A}
	distutils_python_version
	cd ${S}/cute
	sed -i -e "s:../qscintilla/:${QTDIR}:" -e "s:python2.2:python${PYVER}:g" cute.pro
}

src_compile() {
	cd ${S}/cute
	[ -d "$QTDIR/etc/settings" ] && addwrite "$QTDIR/etc/settings"
	addpredict "$QTDIR/etc/settings"
	qmake -o Makefile cute.pro
	sed -i -e "s:CFLAGS   = -pipe -O2:CFLAGS   = ${CFLAGS}:" \
		-e "s:CXXFLAGS = -pipe -O2:CXXFLAGS = ${CXXFLAGS}:" Makefile
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