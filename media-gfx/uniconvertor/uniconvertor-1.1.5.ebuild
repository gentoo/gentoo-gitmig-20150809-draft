# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/uniconvertor/uniconvertor-1.1.5.ebuild,v 1.4 2011/06/24 15:38:06 ranger Exp $

EAPI="2"

PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"

inherit distutils eutils

DESCRIPTION="Commandline tool for popular vector formats convertion"
HOMEPAGE="http://sk1project.org/modules.php?name=Products&product=uniconvertor"
SRC_URI="http://uniconvertor.googlecode.com/files/${P}.tar.gz"

KEYWORDS="~amd64 ~hppa ~ppc ~x86"
SLOT="0"
LICENSE="GPL-2 LGPL-2"
IUSE=""

DEPEND=">=media-libs/sk1libs-0.9.1"
RDEPEND="${DEPEND}
	app-text/ghostscript-gpl"

src_prepare() {
	sed -i \
		-e "s/'GNU_GPL_v2', 'GNU_LGPL_v2', 'COPYRIGHTS',//" \
		setup.py || die

	epatch "${FILESDIR}/uniconvertor-1.1.5_export_raster.py_fix_import.patch"

	distutils_src_prepare
}
