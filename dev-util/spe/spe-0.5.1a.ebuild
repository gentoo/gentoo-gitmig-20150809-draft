# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/spe/spe-0.5.1a.ebuild,v 1.5 2004/07/03 12:20:34 kloeri Exp $

inherit distutils eutils

MY_P="SPE-0.5.1.a-wx2.4.2.4.-bl2.31"
DESCRIPTION="Python IDE with Blender support"
HOMEPAGE="http://spe.pycs.net/"
SRC_URI="http://projects.blender.org/download.php/148/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc"
IUSE=""

DEPEND=">=virtual/python-2.2.3-r1"
RDEPEND=">=dev-python/wxpython-2.4.2.4
	${DEPEND}"

S="${WORKDIR}/${MY_P}"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/spe_setup.patch
}

src_install() {
	distutils_src_install
	dobin spe
}

pkg_postinst() {
	distutils_python_version
	SPEPATH="/usr/lib/python${PYVER}/site-packages"

	einfo "To be able to use spe in blender, be sure that the path where spe is"
	einfo "installed ($SPEPATH) is included in your PYTHONPATH"
	einfo "environment variable. See the installation section in the manual for"
	einfo "more information ($SPEPATH/spe/doc/manual.html).\n"
}
