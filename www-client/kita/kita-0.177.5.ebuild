# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-client/kita/kita-0.177.5.ebuild,v 1.1 2008/12/03 16:08:22 matsuu Exp $

inherit kde

IUSE=""

DESCRIPTION="Kita - 2ch client for KDE"
HOMEPAGE="http://kita.sourceforge.jp/"
SRC_URI="mirror://sourceforge.jp/kita/32988/${P}.tar.gz
	mirror://gentoo/kde-admindir-3.5.5.tar.bz2"

LICENSE="GPL-2 BSD"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ppc ~ppc64 ~x86"

RESTRICT="test"

need-kde 3.1

src_install() {
	kde_src_install

	dodir /usr/share/applications/kde
	mv "${D}"/usr/share/applnk/*/*.desktop "${D}/usr/share/applications/kde"
	rm -rf "${D}/usr/share/applnk"
}
