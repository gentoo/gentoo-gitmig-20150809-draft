# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/spe/spe-0.4.1d.ebuild,v 1.2 2003/10/22 06:31:23 pythonhead Exp $

inherit distutils

MY_P="SPE-0.4.1.d-wx2.4.2.4.-bl2.28"
S="${WORKDIR}/${MY_P}"
DESCRIPTION="Python IDE with Blender support"
HOMEPAGE="http://spe.pycs.net/"
SRC_URI="http://projects.blender.org/download.php/47/${MY_P}.zip"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
DEPEND=">=dev-lang/python-2.2.3-r1
	>=dev-python/wxPython-2.4.2.4"

src_install() {
	export PREFIX="/usr"
	distutils_src_install
}

