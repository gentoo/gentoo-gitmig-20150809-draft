# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-client/kita/kita-0.173.0.ebuild,v 1.1 2004/11/30 03:49:30 usata Exp $

inherit kde-functions

IUSE=""

DESCRIPTION="Kita - 2ch client for KDE"
HOMEPAGE="http://kita.sourceforge.jp/"
SRC_URI="mirror://sourceforge.jp/kita/12389/${P}.tar.gz"

LICENSE="GPL-2 BSD"
SLOT="0"
KEYWORDS="~x86 ~ppc ~ppc64 ~alpha"

RDEPEND="virtual/libc
	>=kde-base/arts-1.1.4
	>=dev-libs/libpcre-4.2
	>=dev-libs/expat-1.95.6
	>=sys-libs/zlib-1.1.4
	>=app-admin/fam-2.6.9
	>=media-libs/libpng-1.2.5
	>=media-libs/jpeg-6b
	>=media-libs/freetype-2.1.4
	>=media-libs/fontconfig-2.2.1
	>=media-libs/libart_lgpl-2.3.16
	sys-devel/gettext"
DEPEND="${RDEPEND}
	>=sys-devel/gcc-3.2"

need-kde 3.1

src_compile() {
	#addpredict ${QTDIR}/etc

	econf || die
	emake -j1 || die
}

src_install() {

	make DESTDIR=${D} install || die

	dodoc AUTHORS ChangeLog INSTALL NEWS README
}
