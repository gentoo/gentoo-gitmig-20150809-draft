# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/compiz-fusion-plugins-main/compiz-fusion-plugins-main-0.6.0.ebuild,v 1.5 2007/10/24 17:49:33 lu_zero Exp $

DESCRIPTION="Compiz Fusion main plugins"
HOMEPAGE="http://compiz-fusion.org"
SRC_URI="http://releases.compiz-fusion.org/${PV}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc ~x86"
IUSE="jpeg"
RESTRICT="test"

DEPEND=">=x11-wm/compiz-0.6.0
	jpeg? ( media-libs/jpeg )
	>=gnome-base/librsvg-2.14.0
	>=x11-libs/compiz-bcop-0.6.0
	>=sys-devel/gettext-0.15"

src_compile() {
	econf $(use_enable jpeg) || die "econf failed"
	emake || die "make failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS || die "dodoc failed"
}
