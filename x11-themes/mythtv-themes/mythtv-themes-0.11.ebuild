# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/mythtv-themes/mythtv-themes-0.11.ebuild,v 1.1 2003/08/18 21:23:02 max Exp $

DESCRIPTION="A collection of themes for the MythTV project."
HOMEPAGE="http://www.mythtv.org/"
SRC_URI="http://www.mythtv.org/modules/My_eGallery/gallery/MainThemes/Photo-Theme.tar.gz
	http://www.mythtv.org/modules/My_eGallery/gallery/MainThemes/PurpleGalaxy.tar.gz
	http://www.mythtv.org/modules/My_eGallery/gallery/MainThemes/visor.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

RDEPEND="|| ( >=media-tv/mythtv-${PV} >=media-tv/mythfrontend-${PV} )"

src_unpack() {
	unpack ${A}

	find "${WORKDIR}" -type f -print0 | xargs -0 chmod 644
	find "${WORKDIR}" -type d -print0 | xargs -0 chmod 755
	rm -f "${WORKDIR}/visor/visor"
}

src_install() {
	dodir /usr/share/mythtv
	cp -r "${WORKDIR}" "${D}/usr/share/mythtv/themes"
	dosym /usr/share/mythtv/themes/visor /usr/share/mythtv/themes/visorosd
}
