# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/mythtv-themes/mythtv-themes-0.10.ebuild,v 1.2 2003/09/04 07:05:02 msterret Exp $

IUSE=""
DESCRIPTION="A collection of themes for the MythTV project."
HOMEPAGE="http://www.mythtv.org/"
SRC_URI="http://www.mythtv.org/modules/My_eGallery/gallery/MainThemes/Photo-Theme.tar.gz
	http://www.mythtv.org/modules/My_eGallery/gallery/MainThemes/PurpleGalaxy.tar.gz
	http://www.mythtv.org/modules/My_eGallery/gallery/MainThemes/visor.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

RDEPEND=">=media-tv/mythtv-${PV}"

src_install() {

	dodir /usr/share/mythtv
	cp -r "${WORKDIR}" "${D}/usr/share/mythtv/themes"

}
