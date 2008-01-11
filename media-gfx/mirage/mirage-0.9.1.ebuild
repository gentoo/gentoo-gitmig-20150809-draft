# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/mirage/mirage-0.9.1.ebuild,v 1.1 2008/01/11 01:09:30 omp Exp $

inherit distutils

DESCRIPTION="Fast and simple GTK+ image viewer"
HOMEPAGE="http://mirageiv.berlios.de/"
SRC_URI="mirror://berlios/mirageiv/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86 ~x86-fbsd"
IUSE=""

RDEPEND=">=dev-python/pygtk-2.6"
DEPEND="${RDEPEND}"

src_install() {
	local DOCS="CHANGELOG README TODO TRANSLATORS"
	distutils_src_install

	rm -f "${D}/usr/share/mirage/COPYING"

	# Do not install duplicate docs.
	for DOC in ${DOCS}; do
		rm -f "${D}/usr/share/mirage/${DOC}"
	done
}
