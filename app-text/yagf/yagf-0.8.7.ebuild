# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/yagf/yagf-0.8.7.ebuild,v 1.1 2011/09/07 07:42:05 pva Exp $

EAPI="4"
inherit cmake-utils

DESCRIPTION="Graphical front-end for cuneiform OCR tool"
HOMEPAGE="http://symmetrica.net/cuneiform-linux/yagf-en.html"
SRC_URI="http://symmetrica.net/cuneiform-linux/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="scanner"

DEPEND="x11-libs/qt-gui:4
	app-text/aspell"
RDEPEND="${DEPEND}
	app-text/cuneiform
	scanner? ( media-gfx/xsane )"

DOCS="AUTHORS ChangeLog DESCRIPTION README"

CMAKE_IN_SOURCE_BUILD=1
