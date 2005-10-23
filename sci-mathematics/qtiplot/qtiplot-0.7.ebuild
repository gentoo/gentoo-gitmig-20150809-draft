# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-mathematics/qtiplot/qtiplot-0.7.ebuild,v 1.1 2005/10/23 15:02:38 cryos Exp $

inherit eutils

IUSE=""
DESCRIPTION="Qt based clone of the Origin plotting package"

MY_P=${P/_p/-}
SRC_URI="http://soft.proindependent.com/src/${MY_P}.zip"
HOMEPAGE="http://soft.proindependent.com/qtiplot.html"
S=${WORKDIR}/${A/.zip/}

QTIPLOT_DIR=${S}/${A/.zip/}
QTIPLOT_PRO=${A/.zip}.pro

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="=x11-libs/qt-3*
	>=x11-libs/qwt-4.2.0
	>=x11-libs/qwtplot3d-0.2.6
	>=sci-libs/gsl-1.6"

src_unpack () {
	unpack ${A}
	cd ${QTIPLOT_DIR}
	mv ${QTIPLOT_PRO} qtiplot.pro
	sed -e 's/INCLUDEPATH.*//' -i qtiplot.pro
	echo >> qtiplot.pro "INCLUDEPATH += /usr/include/qwt"
	echo >> qtiplot.pro "INCLUDEPATH += /usr/include/qwtplot3d"
}

src_compile () {
	cd ${QTIPLOT_DIR}
	qmake qtiplot.pro || die 'qmake failed.'
	emake || die 'emake failed.'
}

src_install() {
	make_desktop_entry qtiplot qtiplot qtiplot Graphics
	dobin qtiplot || die 'Binary installation failed.'
}
