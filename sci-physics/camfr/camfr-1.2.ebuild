# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-physics/camfr/camfr-1.2.ebuild,v 1.3 2007/03/23 14:22:46 pbienst Exp $

inherit eutils distutils fortran

S=${WORKDIR}/camfr_${PV}
DESCRIPTION="Full vectorial Maxwell solver based on eigenmode expansion"
SRC_URI="mirror://sourceforge/camfr/${P}.tgz"
HOMEPAGE="http://camfr.sourceforge.net/"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86"
DEPEND="dev-lang/python
	>=dev-util/scons-0.94
	>=dev-python/numeric-23.1
	>=dev-libs/boost-1.30.2
	>=dev-python/imaging-1.1.4
	>=dev-libs/blitz-0.7
	virtual/lapack
	virtual/tetex
	virtual/ghostscript
	>=app-text/texi2html-1.64"
FORTAN="g77"

src_unpack() {
	python -c "import ImageTk" 2>/dev/null
	if [ $? -ne 0 ]; then
		eerror "Python and imaging don't have Tk support enabled."
		eerror "Set the tcltk USE flag and reinstall python and imaging before continuing."
		die
	fi

	unpack ${P}.tgz
	cp ${FILESDIR}/machine_cfg.py ${S}/machine_cfg.py
	cp ${FILESDIR}/SConstruct ${S}
	epatch ${FILESDIR}/throw_patch.diff
	echo '1;' >> ${S}/docs/texi2html.init
}

src_compile() {

	cd ${S}
	distutils_src_compile

	cd ${S}/docs
	make
}


src_install() {
	distutils_src_install

	cp ${S}/docs/camfr.pdf ${D}/usr/share/doc/${P}
	dohtml ${S}/docs/*.html ${S}/docs/*.css
	mkdir ${D}/usr/share/doc/${P}/html/figs
	cp ${S}/docs/figs/*.png ${D}/usr/share/doc/${P}/html/figs
	cp ${S}/docs/figs/*.gif ${D}/usr/share/doc/${P}/html/figs
}
