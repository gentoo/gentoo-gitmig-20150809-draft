# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/qwt-qt3/qwt-qt3-5.0.2-r1.ebuild,v 1.1 2007/08/23 18:50:37 caleb Exp $

inherit multilib qt3

MY_P="${P/-qt3/}"

SRC_URI="mirror://sourceforge/qwt/${MY_P}.tar.bz2"
HOMEPAGE="http://qwt.sourceforge.net/"
DESCRIPTION="2D plotting library for Qt3"
LICENSE="qwt"
KEYWORDS="~amd64 ~x86"
SLOT="5"
IUSE="doc"

S="${WORKDIR}/${MY_P}"

DEPEND="$(qt_min_version 3)"

src_compile () {
	sed -i -e "s:TARGET .* = qwt:TARGET = qwt-qt3:" src/src.pro \
		|| die "sed src.pro failed"
	sed -i -e "s:-lqwt:-lqwt-qt3:" designer/designer.pro \
		|| die "sed designer.pro failed"

	# Configuration file
	qwtconfig="${S}/qwtconfig.pri"

	echo > ${qwtconfig} ""
	echo >> ${qwtconfig} "target.path = /usr/$(get_libdir)"
	echo >> ${qwtconfig} "headers.path = /usr/include/qwt-qt3"
	echo >> ${qwtconfig} "doc.path = /usr/share/doc/${PF}"
	echo >> ${qwtconfig}
	echo >> ${qwtconfig} "CONFIG += qt warn_on thread"
	echo >> ${qwtconfig} "CONFIG += QwtDll QwtPlot QwtWidgets QwtDesigner"

	use doc || echo >> src/src.pro "INSTALLS -= doc"

	# Generates top-level Makefile
	eqmake3 qwt.pro

	# -j1 due to parallel build failures ( bug # 170625 )
	emake -j1 || die "emake failed"
}

src_install () {
	emake INSTALL_ROOT="${D}" install || die "emake install failed"

#	Can't remember right now why this was here.  Commenting out until we either remove it 
#	or remember why it was	put into place.  caleb@gentoo.org - 08.22.07

#	rm "${D}"/usr/$(get_libdir)/libqwt-qt3.so

	dodoc CHANGES README
}
