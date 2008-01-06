# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/fontypython/fontypython-0.3.2.ebuild,v 1.1 2008/01/06 12:30:57 drac Exp $

inherit distutils multilib python

DESCRIPTION="Font preview application"
HOMEPAGE="http://savannah.nongnu.org/projects/fontypython"
SRC_URI="http://download.savannah.nongnu.org/releases/${PN}/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-python/imaging
	=dev-python/wxpython-2.6*"
DEPEND="${RDEPEND}"

src_install() {
	python_version
	distutils_src_install \
		--install-data=/usr/$(get_libdir)/python${PYVER}/site-packages
}
