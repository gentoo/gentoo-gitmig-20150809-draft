# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/sigil/sigil-0.4.2.ebuild,v 1.1 2012/01/10 03:11:52 sbriesen Exp $

EAPI=4
CMAKE_BUILD_TYPE="Release"

inherit eutils cmake-utils

MY_P="Sigil-${PV}-Code"

DESCRIPTION="Sigil is a multi-platform WYSIWYG ebook editor for ePub format."
HOMEPAGE="http://code.google.com/p/sigil/"
SRC_URI="http://${PN}.googlecode.com/files/${MY_P}.zip"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="
	>=x11-libs/qt-xmlpatterns-4.7.2
	>=x11-libs/qt-webkit-4.7.2
	>=x11-libs/qt-svg-4.7.2
	>=x11-libs/qt-gui-4.7.2"
RDEPEND="${DEPEND}"

S="${WORKDIR}"

DOCS=( ChangeLog README )

src_prepare() {
	# use standard naming
	mv -f README.txt README
	mv -f ChangeLog.txt ChangeLog
	edos2unix ChangeLog README
}
