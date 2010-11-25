# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/gdmodule/gdmodule-0.56-r1.ebuild,v 1.1 2010/11/25 14:14:40 jlec Exp $

EAPI="3"

PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"

inherit distutils eutils

DESCRIPTION="Python extensions for gd"
HOMEPAGE="http://newcenturycomputers.net/projects/gdmodule.html"
SRC_URI="http://newcenturycomputers.net/projects/download.cgi/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86 ~x86-linux ~ppc-macos"
IUSE=""

RDEPEND="media-libs/gd"
DEPEND="${RDEPEND}"

RESTRICT_PYTHON_ABIS="3.*"

src_prepare() {
	epatch "${FILESDIR}"/${PV}-libs.patch
	mv Setup.py setup.py
	distutils_src_prepare
}
