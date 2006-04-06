# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-weatherng-images/vdr-weatherng-images-0.0.5.ebuild,v 1.2 2006/04/06 19:52:26 swegener Exp $

DESCRIPTION="Images used by the weatherng plugin to Video Disk Recorder (VDR)"
HOMEPAGE="http://beejay.vdr-developer.org/"
SRC_URI="http://www.glaserei-franz.de/VDR/Moronimo2/downloads/images-2MB.${PV}.tar.bz2
		mirror://vdrfiles/${PN}/images-2MB.${PV}.tar.bz2"

LICENSE="weatherng-images"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND=""

S=${WORKDIR}/images

src_install() {
	insinto /usr/share/vdr/weatherng/images
	doins *.png
}
