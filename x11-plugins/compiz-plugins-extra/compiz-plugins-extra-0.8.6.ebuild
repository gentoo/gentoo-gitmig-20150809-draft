# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/compiz-plugins-extra/compiz-plugins-extra-0.8.6.ebuild,v 1.1 2010/04/03 05:11:17 jmbsvicetto Exp $

EAPI="2"

inherit autotools eutils gnome2-utils

DESCRIPTION="Compiz Fusion Window Decorator Extra Plugins"
HOMEPAGE="http://www.compiz.org/"
SRC_URI="http://releases.compiz.org/${PV}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE="gnome"

MY_PV="0.8.4"

RDEPEND="
	>=gnome-base/librsvg-2.14.0
	media-libs/jpeg
	>=x11-libs/compiz-bcop-${MY_PV}
	>=x11-plugins/compiz-plugins-main-${PV}
	>=x11-wm/compiz-${PV}
"

DEPEND="${RDEPEND}
	>=dev-util/intltool-0.35
	>=dev-util/pkgconfig-0.19
	>=sys-devel/gettext-0.15
	x11-libs/cairo
	gnome? ( gnome-base/gconf )
"

src_prepare() {
	use gnome || {
		epatch "${FILESDIR}"/${PN}-no-gconf.patch

		# required to apply the above patch
		intltoolize --copy --force || die "intltoolize failed"
		eautoreconf || die "eautoreconf failed"
	}
}

src_configure() {
	econf --disable-dependency-tracking \
		$(use_enable gnome schemas)
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
}

pkg_preinst() {
	if use gnome; then
		gnome2_gconf_savelist
	fi
}

pkg_postinst() {
	if use gnome; then
		gnome2_gconf_install
	fi
}
