# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-weatherng/vdr-weatherng-0.0.8_pre2.ebuild,v 1.4 2006/04/17 16:54:37 zzam Exp $

inherit vdr-plugin

MY_PV="${PV/_/-}"
MY_P="${PN}-${MY_PV}"

DESCRIPTION="Video Disk Recorder plugin to show weather for specified place"
HOMEPAGE="http://beejay.vdr-developer.org/"
SRC_URI="mirror://vdrfiles/${PN}/${MY_P}.tgz"

LICENSE="GPL-2 stardock-images"
SLOT="0"
KEYWORDS="x86 ~amd64"
IUSE=""

DEPEND="media-libs/imlib2
	>=media-video/vdr-1.3.34"

S="${WORKDIR}/weatherng-${MY_PV}"

VDR_CONFD_FILE="${FILESDIR}/confd-0.0.8"
VDR_RCADDON_FILE="${FILESDIR}/rc-addon-0.0.8.sh"

PATCHES="${FILESDIR}/${P}-gentoo.diff"

src_install() {
	vdr-plugin_src_install

	insinto /usr/share/vdr/weatherng/images
	doins ${S}/images/*.png

	diropts -m0755 -ovdr -gvdr
	dodir /var/vdr/${VDRPLUGIN}

	insinto  /var/vdr/${VDRPLUGIN}
	insopts -m755 -ovdr -gvdr
	doins ${S}/examples/weatherng.sh
}

pkg_postinst() {
	vdr-plugin_pkg_postinst

	echo
	einfo "To display the weather for your location"
	einfo "you have to find out its ID on weather.com"
	einfo
	einfo "Go to http://www.weather.com and search for your city (i.e. Herne)"
	einfo "in the list of results click on the right one and then look at its URL"
	einfo
	einfo "It contains a code for your city"
	einfo "For Herne this is GMXX0056"
	einfo
	einfo "Now you have to enter this code in /etc/conf.d/vdr.burn WEATHERNG_STATIONID(x)"
	echo
}
