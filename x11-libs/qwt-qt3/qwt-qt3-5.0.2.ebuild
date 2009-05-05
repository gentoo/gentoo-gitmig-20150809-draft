# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/qwt-qt3/qwt-qt3-5.0.2.ebuild,v 1.4 2009/05/05 08:20:53 ssuominen Exp $

EAPI=1

inherit multilib eutils qt3

MY_P=${P/-qt3/}

SRC_URI="mirror://sourceforge/qwt/${MY_P}.tar.bz2"
HOMEPAGE="http://qwt.sourceforge.net/"
DESCRIPTION="2D plotting library for Qt4"
LICENSE="qwt"
KEYWORDS="~amd64 ~x86"
SLOT="5"
IUSE="doc"

QWTVER="5.0.2"

S=${WORKDIR}/${MY_P}

RDEPEND="x11-libs/qt:3"
DEPEND="${RDEPEND}"

src_unpack () {
	unpack ${A}

	cd "{S}"

	sed -i -e "s:TARGET            = qwt:TARGET            = qwt-qt3:" src/src.pro
	sed -i -e "s:-lqwt:-lqwt-qt3:" designer/designer.pro

	qwtconfig="${S}/qwtconfig.pri"
	echo > ${qwtconfig} ""
	echo >> ${qwtconfig} "target.path = /usr/$(get_libdir)"
	echo >> ${qwtconfig} "headers.path = /usr/include/qwt-qt3"
	echo >> ${qwtconfig} "doc.path = /usr/share/doc/${PF}"
	echo >> ${qwtconfig}
	echo >> ${qwtconfig} "CONFIG += qt warn_on thread"
	echo >> ${qwtconfig} "CONFIG += release"
	echo >> ${qwtconfig} "CONFIG += QwtDll QwtPlot QwtWidgets QwtDesigner"

	# Can also do QwtExamples for example building

	echo >> ${qwtconfig} "QMAKE_CFLAGS_RELEASE += ${CFLAGS}"
	echo >> ${qwtconfig} "QMAKE_CXXFLAGS_RELEASE += ${CXXFLAGS}"

	if ! useq doc; then
		echo >> "${S}/src/src.pro" "INSTALLS = target headers"
	fi

}

src_compile () {
	# -j1 due to parallel build failures ( bug # 170625 )
	"${QTDIR}"/bin/qmake QMAKE="${QTDIR}"/bin/qmake qwt.pro
	emake -j1 || die
}

src_install () {
	make INSTALL_ROOT="${D}" install
	rm "${D}"usr/$(get_libdir)/libqwt-qt3.so
}
