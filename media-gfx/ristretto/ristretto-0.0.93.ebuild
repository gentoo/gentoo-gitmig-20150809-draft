# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/ristretto/ristretto-0.0.93.ebuild,v 1.5 2011/03/29 13:05:53 jer Exp $

EAPI=3
EAUTORECONF=yes
inherit xfconf

DESCRIPTION="Image viewer and browser for Xfce4"
HOMEPAGE="http://goodies.xfce.org/projects/applications/ristretto"
SRC_URI="mirror://xfce/src/apps/${PN}/0.0/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha amd64 hppa ~ia64 ppc ppc64 ~sparc x86"
IUSE="debug"

RDEPEND="media-libs/libexif
	>=x11-libs/gtk+-2.14:2
	>=dev-libs/glib-2.18:2
	>=dev-libs/dbus-glib-0.34
	>=xfce-base/libxfce4util-4.7
	>=xfce-base/libxfce4ui-4.7
	>=xfce-base/xfconf-4.7
	>=x11-libs/cairo-1.8"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	dev-util/intltool
	sys-devel/gettext"

pkg_setup() {
	XFCONF=(
		--disable-dependency-tracking
		$(xfconf_use_debug)
		)

	DOCS="AUTHORS ChangeLog NEWS README TODO"
}

src_prepare() {
	sed -i \
		-e "/TARGET_DIR/s:(datadir)/doc/ristretto:(datadir)/doc/${PF}:" \
		docs/manual/C/Makefile.am || die

	xfconf_src_prepare
}
