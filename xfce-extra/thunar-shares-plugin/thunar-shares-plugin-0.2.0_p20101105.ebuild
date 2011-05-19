# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-extra/thunar-shares-plugin/thunar-shares-plugin-0.2.0_p20101105.ebuild,v 1.4 2011/05/19 21:45:14 ssuominen Exp $

# git clone -b thunarx-2 git://git.xfce.org/thunar-plugins/thunar-shares-plugin

EAPI=4
EAUTORECONF=yes
inherit xfconf

DESCRIPTION="Thunar plugin to share files using Samba"
HOMEPAGE="http://goodies.xfce.org/projects/thunar-plugins/thunar-shares-plugin"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

RDEPEND=">=dev-libs/glib-2.18:2
	>=x11-libs/gtk+-2.12:2
	>=xfce-base/thunar-1.1.0"
DEPEND="${RDEPEND}
	dev-util/intltool
	dev-util/pkgconfig"

pkg_setup() {
	XFCONF=(
		--disable-static
		$(xfconf_use_debug)
		)

	DOCS=( AUTHORS ChangeLog NEWS README TODO )
}
