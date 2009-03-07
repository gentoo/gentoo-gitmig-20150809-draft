# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/fontypython/fontypython-0.3.6.ebuild,v 1.2 2009/03/07 23:02:45 maekke Exp $

inherit distutils multilib python

DESCRIPTION="Font preview application"
HOMEPAGE="http://savannah.nongnu.org/projects/fontypython"
SRC_URI="http://download.savannah.nongnu.org/releases/${PN}/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-python/imaging
	>=dev-python/wxpython-2.6"
DEPEND="${RDEPEND}"

src_install() {
	python_version
	distutils_src_install \
		--install-data=/usr/$(get_libdir)/python${PYVER}/site-packages
}
