# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/screengrab/screengrab-0.8.1.ebuild,v 1.1 2010/10/05 01:14:54 chiiph Exp $

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
	# fix documentation installation (bug #314495)
	sed -i "s/doc\/screengrab/doc\/${PF}/" ${PN}.pro \
		|| die "failed to fix documentation path"
	# do not install license
	sed -i "/LICENSE.txt/d" CMakeLists.txt \
		|| die "failed to patch cmakelists"
	# install docs in the right dir
	sed -i "s#DESTINATION share/doc/screengrab#DESTINATION share/doc/${PF}#" \
		CMakeLists.txt || die "failed to patch doc dir"
}
