# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/cpvts/cpvts-1.2.ebuild,v 1.1 2004/10/06 20:26:56 trapni Exp $

DESCRIPTION="raw copy title sets from a DVD to your harddisc"
SRC_URI="http://www.lallafa.de/bp/files/${P}.tgz"
HOMEPAGE="http://www.lallafa.de/bp/cpvts.html"
SLOT="0"
IUSE=""

DEPEND="media-libs/libdvdread"

KEYWORDS="~x86"
LICENSE="GPL-1"

MY_S=${WORKDIR}/${PN}

src_compile () {
	cd ${MY_S} || die
	emake || die
}

src_install () {
	dobin ${MY_S}/${PN} || die
}
