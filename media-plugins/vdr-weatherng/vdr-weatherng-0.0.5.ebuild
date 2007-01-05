# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-weatherng/vdr-weatherng-0.0.5.ebuild,v 1.3 2007/01/05 17:05:12 hd_brummy Exp $

inherit vdr-plugin

DESCRIPTION="VDR plugin: show weather for specified place"
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
	elog "Note: On first run, this Plugin is in Offline Mode"
	elog "You can change this in OSD Menu of the plugin."
	elog
	elog
	elog "To display the weather for your location"
	elog "you have to find out its ID on weather.com"
	elog
	elog "Go to http://www.weather.com and search for your city (i.e. Herne)"
	elog "in the list of results click on the right one and then look at its URL"
	elog
	elog "It contains a code for your city"
	elog "For Herne this is GMXX0056"
	elog
	elog
	 "Now you have to enter this code in plugin-setup in OSD"
	echo
}
