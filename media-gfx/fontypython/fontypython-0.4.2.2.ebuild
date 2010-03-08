# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/fontypython/fontypython-0.4.2.2.ebuild,v 1.3 2010/03/08 00:53:31 abcd Exp $

EAPI=2

PYTHON_DEPEND="2:2.6"
inherit distutils multilib python

DESCRIPTION="Font preview application"
HOMEPAGE="http://savannah.nongnu.org/projects/fontypython"
SRC_URI="http://download.savannah.nongnu.org/releases/${PN}/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

# Crashes w/ debug build of wxGTK (#201315)
DEPEND="dev-python/imaging
	dev-python/wxpython:2.8
	x11-libs/wxGTK:2.8[-debug]"
RDEPEND="${DEPEND}"

PYTHON_MODNAME="fontypythonmodules"

src_install() {
	distutils_src_install
	doman "${S}"/fontypython.1
}
