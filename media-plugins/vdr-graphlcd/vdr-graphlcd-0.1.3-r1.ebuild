# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-graphlcd/vdr-graphlcd-0.1.3-r1.ebuild,v 1.3 2007/01/05 16:31:15 hd_brummy Exp $

inherit eutils vdr-plugin

DESCRIPTION="VDR Graphical LCD Plugin"
HOMEPAGE="http://graphlcd.berlios.de/"
SRC_URI="http://download.berlios.de/graphlcd/${P}.tgz"

KEYWORDS="~x86 ~amd64"

SLOT="0"
LICENSE="GPL-2"
IUSE="truetype"

DEPEND=">=media-video/vdr-1.2.6
	>=app-misc/graphlcd-base-${PV}"

PATCHES="${FILESDIR}/0.1.3/radiotext-lcr-service.diff
	${FILESDIR}/0.1.3/graphlcd-0.1.3-span.diff
	${FILESDIR}/${P}-uint64.diff"

src_unpack() {
	vdr-plugin_src_unpack

	sed -i "s:/usr/local:/usr:" Makefile
}

src_install() {
	vdr-plugin_src_install

	insopts -m0644 -ovdr -gvdr

	insinto /usr/share/vdr/${VDRPLUGIN}/logos
	doins -r ${VDRPLUGIN}/logos/*

	insinto /usr/share/vdr/${VDRPLUGIN}/fonts
	doins ${VDRPLUGIN}/fonts/*.fnt

	if use truetype; then
		for font in /usr/share/fonts/corefonts/*.ttf; do
			elog ${font}
			dosym ${font} /usr/share/vdr/graphlcd/fonts
		done
	fi

	insinto /etc/vdr/plugins/${VDRPLUGIN}
	doins ${VDRPLUGIN}/logonames.alias.*
	doins ${VDRPLUGIN}/fonts.conf.*

	dosym /usr/share/vdr/${VDRPLUGIN}/fonts /etc/vdr/plugins/${VDRPLUGIN}/fonts
	dosym /usr/share/vdr/${VDRPLUGIN}/logos /etc/vdr/plugins/${VDRPLUGIN}/logos
	dosym /etc/graphlcd.conf /etc/vdr/plugins/${VDRPLUGIN}/graphlcd.conf

	if has_version ">=media-video/vdr-1.3.2" ; then
		dosym /etc/vdr/plugins/${VDRPLUGIN}/logonames.alias.1.3 /etc/vdr/plugins/${VDRPLUGIN}/logonames.alias
	else
		dosym /etc/vdr/plugins/${VDRPLUGIN}/logonames.alias.1.2 /etc/vdr/plugins/${VDRPLUGIN}/logonames.alias
	fi
}

pkg_preinst() {

	if [[ -e /etc/vdr/plugins/graphlcd/fonts ]] && [[ ! -L /etc/vdr/plugins/graphlcd/fonts ]] \
	|| [[ -e /etc/vdr/plugins/graphlcd/logos ]] && [[ ! -L /etc/vdr/plugins/graphlcd/logos ]] ;then

		elog "Remove wrong DIR in /etc/vdr/plugins/graphlcd from prior install"
		elog "Press CTRL+C to abbort"
		epause
		rmdir -R /etc/vdrplugins/graphlcd/{fonts,logos}
	fi
}

pkg_postinst() {
	vdr-plugin_pkg_postinst

	elog "Add additional options in /etc/conf.d/vdr.graphlcd"
	elog
	elog "Please copy or link one of the supplied fonts.conf.*"
	elog "files in /etc/vdr/plugins/graphlcd/ to"
	elog "/etc/vdr/plugins/graphlcd/fonts.conf"
}

