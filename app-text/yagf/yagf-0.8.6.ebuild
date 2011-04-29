# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/yagf/yagf-0.8.6.ebuild,v 1.1 2011/04/29 09:13:43 pva Exp $

EAPI="4"

inherit cmake-utils

MY_P="${P}-Source"

DESCRIPTION="Graphical front-end for cuneiform OCR tool"
HOMEPAGE="http://symmetrica.net/cuneiform-linux/yagf-en.html"
SRC_URI="http://symmetrica.net/cuneiform-linux/${MY_P}.tar.gz"

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

S="${WORKDIR}/${MY_P}"

CMAKE_IN_SOURCE_BUILD=1
