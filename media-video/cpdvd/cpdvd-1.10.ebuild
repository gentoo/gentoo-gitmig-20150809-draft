# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/cpdvd/cpdvd-1.10.ebuild,v 1.1 2004/10/06 20:31:27 trapni Exp $

DESCRIPTION="transfer a DVD title to your harddisk with ease on Linux"
SRC_URI="http://www.lallafa.de/bp/files/${P}.gz"
HOMEPAGE="http://www.lallafa.de/bp/cpdvd.html"
KEYWORDS="~x86"
LICENSE="GPL-1"
SLOT="0"
IUSE=""

DEPEND="
	>=media-video/transcode-0.6.2
	>=perl-5.8.0-r12
	>=cpvts-1.2
"

MY_S=${WORKDIR}

src_compile () {
	#there are probably other places to rename the file...
	cd ${MY_S} || die
	mv ${P} ${PN} || die
}

src_install () {
	dobin ${MY_S}/${PN} || die
}
