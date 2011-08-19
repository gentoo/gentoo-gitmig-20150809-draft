# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/screengrab/screengrab-0.9.85.ebuild,v 1.1 2011/08/19 21:29:41 hwoarang Exp $

EAPI="2"

inherit cmake-utils

DESCRIPTION="Qt tool for geting screenshots"
HOMEPAGE="http://code.google.com/p/screengrab-qt/"
SRC_URI="http://screengrab-qt.googlecode.com/files/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="x11-libs/qt-gui:4"
RDEPEND="${DEPEND}"

src_prepare() {
	# do not install license
	sed -i "/LICENSE.txt/d" CMakeLists.txt \
		|| die "failed to patch cmakelists"
	# install docs in the right dir
	sed -i "s#DESTINATION share/doc/screengrab#DESTINATION share/doc/${PF}#" \
		CMakeLists.txt || die "failed to patch doc dir"
	sed -i "s:screengrab%1html:${PF}%1html:" src/ui/mainwindow.cpp || die
}
