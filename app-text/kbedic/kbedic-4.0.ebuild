# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header:

IUSE="kde"
inherit kde

S=${WORKDIR}/${P}
DESCRIPTION="English <-> Bulgarian Dictionary"
SRC_URI="mirror://sourceforge/kbedic/$P.tar.gz"
HOMEPAGE="http://kbedic.sourceforge.net"
KEYWORDS="x86"
SLOT="0"
LICENSE="GPL-2"

use kde && need-kde 3 || need-qt 3

src_compile() {

	use kde && myconf="$myconf --with-kde" || myconf="$myconf --prefix=/usr"
	use kde && kde_src_compile myconf

	kde_src_compile configure make

}

src_install() {

	kde_src_install
	use kde && install -m 644 -D ${FILESDIR}/kbedic.desktop ${D}/usr/share/applnk/Utilities/kbedic.desktop

}
