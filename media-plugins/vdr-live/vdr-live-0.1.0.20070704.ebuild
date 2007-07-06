# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-live/vdr-live-0.1.0.20070704.ebuild,v 1.1 2007/07/06 13:42:41 zzam Exp $

inherit vdr-plugin versionator

MY_PV=$(get_version_component_range 4)
MY_P="${PN}-${MY_PV}"

DESCRIPTION="VDR Plugin: Web Access To Settings"
HOMEPAGE="http://live.vdr-developer.org"
#SRC_URI="http://live.vdr-developer.org/downloads/${MY_PP}.tar.gz"
SRC_URI="mirror://gentoo/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="media-video/vdr
	>=dev-libs/boost-1.33.0
	>=dev-libs/tntnet-1.5.3
	>=dev-libs/cxxtools-1.4.3"

PATCHES="${FILESDIR}/vdr-live-content-type.diff"

S="${WORKDIR}/${VDRPLUGIN}"

src_unpack() {
	vdr-plugin_src_unpack

	cd "${S}"
#	sed -i live.cpp -e '/m_configDirectory =/s#=.*#= "/usr/share/vdr/live/http";#'
}

src_install() {
	vdr-plugin_src_install

	cd "${S}/live"
	#insinto /usr/share/vdr/live/http
	insinto /etc/vdr/plugins/live
	doins -r *

	chown vdr:vdr -R "${D}"/etc/vdr/plugins/live
}

