# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-extra/thunar-shares-plugin/thunar-shares-plugin-0.2.0.ebuild,v 1.5 2010/01/15 02:45:39 ssuominen Exp $

EAPI=2
inherit xfconf

DESCRIPTION="Thunar plugin to share files using Samba"
HOMEPAGE="http://goodies.xfce.org/projects/thunar-plugins/thunar-shares-plugin"
SRC_URI="http://goodies.xfce.org/releases/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

RDEPEND=">=dev-libs/glib-2.12:2
	>=x11-libs/gtk+-2.10:2
	<=xfce-base/thunar-1.1.0"
DEPEND="${RDEPEND}
	dev-util/intltool"

pkg_setup() {
	DOCS="AUTHORS ChangeLog NEWS README TODO"
}
