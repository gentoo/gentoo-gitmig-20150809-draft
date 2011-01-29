# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-extra/xfce4-weather-plugin/xfce4-weather-plugin-0.7.3_p20110129.ebuild,v 1.1 2011/01/29 11:23:30 ssuominen Exp $

# http://bugzilla.xfce.org/show_bug.cgi?id=6965

# git clone git://git.xfce.org/panel-plugins/xfce4-weather-plugin
# wget "http://bugzilla.xfce.org/attachment.cgi?id=3428" -O xfce48.patch

EAPI=3
EAUTORECONF=yes
inherit xfconf

DESCRIPTION="A weather plug-in for the Xfce desktop environment"
HOMEPAGE="http://goodies.xfce.org/projects/panel-plugins/xfce4-weather-plugin"
SRC_URI="http://dev.gentoo.org/~ssuominen/${P}.tar.xz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

RDEPEND=">=x11-libs/gtk+-2.6:2
	>=xfce-base/libxfce4util-4.3.90.2
	>=xfce-base/libxfcegui4-4.3.90.2
	>=xfce-base/xfce4-panel-4.3.99.1
	>=dev-libs/libxml2-2.4"
DEPEND="${RDEPEND}
	app-arch/xz-utils
	dev-util/intltool
	dev-util/pkgconfig"

pkg_setup() {
	XFCONF=(
		--disable-dependency-tracking
		$(xfconf_use_debug)
		)

	DOCS="AUTHORS NEWS README TODO"
}
