# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:

EAPI="4"

inherit vdr-plugin

VERSION="828" # every bump, new version

DESCRIPTION="VDR Plugin: allows remote programming VDR using VDR-Manager running on Android devices"
HOMEPAGE="http://projects.vdr-developer.org/wiki/androvdr"
SRC_URI="mirror://vdr-developerorg/${VERSION}/${P}.tar.gz"
KEYWORDS="~x86 ~amd64"
SLOT="0"
LICENSE="GPL-2"

IUSE="-stream"

DEPEND=">=media-video/vdr-1.6.0"

RDEPEND="stream? ( media-plugins/vdr-streamdev[server] )"

S="${WORKDIR}/${P}"

pkg_postinst() {
	vdr-plugin_pkg_postinst

	einfo "Add a password to /etc/conf.d/vdr.vdrmanager"
}
