# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-weatherng/vdr-weatherng-0.0.5.ebuild,v 1.2 2006/04/06 19:51:59 swegener Exp $

inherit vdr-plugin

DESCRIPTION="Video Disk Recorder plugin to show weather for specified place"
HOMEPAGE="http://beejay.vdr-developer.org/"
SRC_URI="http://beejay.vdr-developer.org/devel/${P}.tgz
		mirror://vdrfiles/${PN}/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND="media-gfx/imagemagick
	>=media-video/vdr-1.3.34
	media-plugins/vdr-weatherng-images"

PATCHES="${FILESDIR}/${P}.diff"

src_install() {
	vdr-plugin_src_install

	insinto /etc/vdr/commands/
	doins "${FILESDIR}/commands.${VDRPLUGIN}.conf"

	diropts -m755 -ovdr -gvdr
	keepdir /var/vdr/${VDRPLUGIN}
	insinto /var/vdr/${VDRPLUGIN}
	insopts -m755
	doins ${S}/Tools/SatDownload

	insopts -m644 -ovdr -gvdr
	touch daten.dat
	doins daten.dat
}

pkg_postinst() {
	vdr-plugin_pkg_postinst

	echo
	einfo "Note: On first run, this Plugin is in Offline Mode"
	einfo "You can change this in OSD Menu of the plugin."
	einfo
	einfo
	einfo "To display the weather for your location"
	einfo "you have to find out its ID on weather.com"
	einfo
	einfo "Go to http://www.weather.com and search for your city (i.e. Herne)"
	einfo "in the list of results click on the right one and then look at its URL"
	einfo
	einfo "It contains a code for your city"
	einfo "For Herne this is GMXX0056"
	einfo
	einfo "Now you have to enter this code in plugin-setup in OSD"
	echo
}
