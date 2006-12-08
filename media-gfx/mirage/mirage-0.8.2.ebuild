# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/mirage/mirage-0.8.2.ebuild,v 1.1 2006/12/08 07:31:35 omp Exp $

inherit distutils

DESCRIPTION="Fast and simple GTK+ image viewer"
HOMEPAGE="http://mirageiv.berlios.de/"
SRC_URI="http://download.berlios.de/mirageiv/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=dev-python/pygtk-2.6"

src_install() {
	DOCS="CHANGELOG README TODO TRANSLATORS"
	distutils_src_install

	# Don't install duplicate ungzipped docs.
	rm -rf "${D}/usr/share/mirage/COPYING"
	for DOC in $DOCS; do
		rm -rf "${D}/usr/share/mirage/${DOC}"
	done
}
