# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-live/vdr-live-0.2.0.ebuild,v 1.4 2009/11/18 21:05:31 zzam Exp $

inherit vdr-plugin versionator

MY_PV=$(get_version_component_range 4)
MY_P="${PN}-${MY_PV}"

DESCRIPTION="VDR Plugin: Web Access To Settings"
HOMEPAGE="http://live.vdr-developer.org"
SRC_URI="http://live.vdr-developer.org/downloads/${P}.tar.gz"
#SRC_URI="mirror://gentoo/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="media-video/vdr
	>=dev-libs/tntnet-1.5.3
	>=dev-libs/cxxtools-1.4.3"
RDEPEND="${DEPEND}"

# depends that are not rdepend
DEPEND="${DEPEND}
	>=dev-libs/boost-1.33.0"

S="${WORKDIR}/${VDRPLUGIN}-${PV}"

src_unpack() {
	vdr-plugin_src_unpack
	cd "${S}"

	# make it work with /bin/sh as indicated in the file header
	sed -e "18s/==/=/" -i  buildutil/version-util
}

src_install() {
	vdr-plugin_src_install

	cd "${S}/live"
	insinto /etc/vdr/plugins/live
	doins -r *

	chown vdr:vdr -R "${D}"/etc/vdr/plugins/live
}

pkg_postinst() {
	vdr-plugin_pkg_postinst

	elog "To be able to use all functions of vdr-live"
	elog "you should emerge and enable vdr-epgsearch"
	elog
	elog "\temerge vdr-epgsearch"
	elog "\teselect vdr-plugin enable epgsearch"
}
