# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/sk1libs/sk1libs-0.9.1.ebuild,v 1.4 2010/11/09 15:21:53 ssuominen Exp $

EAPI=2

PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"

inherit distutils

DESCRIPTION="sk1 vector graphics lib"
HOMEPAGE="http://sk1project.org/index.php"
SRC_URI="http://uniconvertor.googlecode.com/files/${P}.tar.gz"

SLOT="0"
KEYWORDS="~amd64 ~x86"
LICENSE="GPL-2 LGPL-2"
IUSE=""

DEPEND="
	media-libs/freetype:2
	virtual/jpeg
	=media-libs/lcms-1*
	>=media-libs/lcms-1.15[python]"
RDEPEND="${DEPEND}
	app-text/ghostscript-gpl
	media-libs/netpbm"
