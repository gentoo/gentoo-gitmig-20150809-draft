# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-extra/xfce4-playercontrol-plugin/xfce4-playercontrol-plugin-0.3.0.ebuild,v 1.3 2010/11/04 21:15:18 ssuominen Exp $

EAPI=3
inherit xfconf

DESCRIPTION="Audacious and MPD panel plugins"
HOMEPAGE="http://goodies.xfce.org/projects/panel-plugins/xfce4-xmms-plugin/"
SRC_URI="http://www.bilimfeneri.gen.tr/ilgar/${P}.tar.bz2"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="audacious mpd"

RDEPEND=">=xfce-base/libxfcegui4-4.2
	>=xfce-base/xfce4-panel-4.3.20
	>=xfce-base/libxfce4util-4.3
	>=x11-libs/pango-1.8
	>=x11-libs/gtk+-2.4:2
	mpd? ( >=media-libs/libmpd-0.12 )
	audacious? ( >=media-sound/audacious-1.4 )"
DEPEND="${RDEPEND}
	dev-util/intltool
	dev-util/pkgconfig
	sys-devel/gettext"

pkg_setup() {
	PATCHES=( "${FILESDIR}"/${P}-undeclared_XfceRc.patch )

	XFCONF=(
		--disable-dependency-tracking
		--disable-static
		--disable-xmms
		$(use_enable audacious)
		$(use_enable mpd)
		)

	DOCS="AUTHORS ChangeLog README README.developers"
}
