# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-mathematics/qtiplot/qtiplot-0.7.4.ebuild,v 1.2 2006/01/09 14:15:40 caleb Exp $

inherit eutils multilib qt3

DESCRIPTION="Qt based clone of the Origin plotting package"
HOMEPAGE="http://soft.proindependent.com/qtiplot.html"
SRC_URI="http://soft.proindependent.com/src/${P}.zip"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="$(qt_min_version 3.3)
	>=x11-libs/qwt-4.2.0
	>=x11-libs/qwtplot3d-0.2.6
	>=sci-libs/gsl-1.6"

S=${WORKDIR}/${P}/${P}

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}-qmake.patch
	sed -i -e "s|_LIBDIR_|/usr/$(get_libdir)|" ${P}.pro || die "sed failed."
}

src_compile() {
	${QTDIR}/bin/qmake QMAKE=${QTDIR}/bin/qmake ${P}.pro || die 'qmake failed.'
	emake || die 'emake failed.'
}

src_install() {
	make_desktop_entry qtiplot qtiplot qtiplot Graphics
	dobin ../qtiplot || die 'Binary installation failed.'
}
