# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/kita/kita-0.6.ebuild,v 1.1 2003/09/19 17:34:18 usata Exp $

IUSE=""

DESCRIPTION="Kita - 2ch client for KDE"
HOMEPAGE="http://kita.sourceforge.jp/"
SRC_URI="mirror://sourceforge.jp/kita/5688/${P}.tar.gz"

LICENSE="GPL-2 BSD"
SLOT="0"
KEYWORDS="~x86"

DEPEND=">=x11-libs/qt-3.1
	>=kde-base/kde-3.1
	>=kde-base/kdelibs-3.1
	kde-base/arts
	sys-libs/zlib
	media-libs/libpng
	media-libs/jpeg"
#RDEPEND=""

S=${WORKDIR}/${P}

src_install() {

	einstall || die

	dodoc AUTHORS ChangeLog INSTALL NEWS README
}
