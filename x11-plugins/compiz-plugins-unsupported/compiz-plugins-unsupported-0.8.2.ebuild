# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/compiz-plugins-unsupported/compiz-plugins-unsupported-0.8.2.ebuild,v 1.4 2009/04/25 16:06:10 ranger Exp $

EAPI="2"

DESCRIPTION="Compiz Fusion Window Decorator Unsupported Plugins"
HOMEPAGE="http://www.compiz.org/"
SRC_URI="http://releases.compiz.org/${PV}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE=""

RDEPEND="
	!x11-plugins/compiz-fusion-plugins-unsupported
	>=gnome-base/librsvg-2.14.0
	media-libs/jpeg
	~x11-libs/compiz-bcop-${PV}
	~x11-plugins/compiz-plugins-main-${PV}
	~x11-wm/compiz-${PV}
"

DEPEND="${RDEPEND}
	>=dev-util/intltool-0.35
	>=dev-util/pkgconfig-0.19
	>=sys-devel/gettext-0.15
	x11-libs/cairo
"

RESTRICT="mirror"

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
}
