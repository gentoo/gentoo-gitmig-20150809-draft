# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/lxde-base/lxmenu-data/lxmenu-data-0.1.ebuild,v 1.3 2009/07/30 18:29:59 volkmar Exp $

DESCRIPTION="Provides files needed for LXDE application menus"
HOMEPAGE="http://lxde.sourceforge.net/"
SRC_URI="mirror://sourceforge/lxde/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

RDEPEND=""
DEPEND="sys-devel/gettext
	>=dev-util/intltool-0.40.0
	dev-util/pkgconfig"

src_unpack() {
	unpack ${A}
	cd "${S}"
	#newline at end of file POTFILES.in
	sed -i -e '$G' po/POTFILES.in
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS README || die "dodoc failed"
}
