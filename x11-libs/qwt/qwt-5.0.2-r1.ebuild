# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/qwt/qwt-5.0.2-r1.ebuild,v 1.1 2007/08/23 13:01:00 caleb Exp $

inherit multilib qt4

SRC_URI="mirror://sourceforge/qwt/${P}.tar.bz2"
HOMEPAGE="http://qwt.sourceforge.net/"
DESCRIPTION="2D plotting library for Qt4"
LICENSE="qwt"
KEYWORDS="~amd64 ~x86"
SLOT="5"
IUSE="doc svg"

DEPEND="$(qt4_min_version 4)"

src_compile () {
	# Configuration file
	qwtconfig="${S}"/qwtconfig.pri

	echo > ${qwtconfig} ""
	echo >> ${qwtconfig} "target.path = /usr/$(get_libdir)"
	echo >> ${qwtconfig} "headers.path = /usr/include/qwt5"
	echo >> ${qwtconfig} "doc.path = /usr/share/doc/${PF}"
	echo >> ${qwtconfig}
	echo >> ${qwtconfig} "CONFIG += qt warn_on thread"
	echo >> ${qwtconfig} "CONFIG += QwtDll QwtPlot QwtWidgets QwtDesigner"

	use svg && echo >> ${qwtconfig} "CONFIG += QwtSVGItem"
	use doc || echo >> src/src.pro "INSTALLS -= doc"

	# Generates top-level Makefile
	eqmake4

	# -j1 due to parallel build failures ( bug # 170625 )
	emake -j1 || die "emake failed"
}

src_install () {
	emake INSTALL_ROOT="${D}" install || die "emake install failed"
	dodoc CHANGES README
}
