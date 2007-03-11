# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/mirage/mirage-0.8.3.ebuild,v 1.7 2007/03/11 15:58:45 nixnut Exp $

inherit distutils

DESCRIPTION="Fast and simple GTK+ image viewer"
HOMEPAGE="http://mirageiv.berlios.de/"
SRC_URI="mirror://berlios/mirageiv/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc ppc64 x86 ~x86-fbsd"
IUSE=""

RDEPEND=">=dev-python/pygtk-2.6"
DEPEND="${RDEPEND}"

src_install() {
	local DOCS="CHANGELOG README TODO TRANSLATORS"
	distutils_src_install

	# Don't install duplicate ungzipped docs.
	rm -f "${D}/usr/share/mirage/COPYING"

	for DOC in $DOCS; do
		rm -f "${D}/usr/share/mirage/${DOC}"
	done
}
