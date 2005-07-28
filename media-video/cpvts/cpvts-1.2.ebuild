# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/cpvts/cpvts-1.2.ebuild,v 1.3 2005/07/28 10:25:56 dholm Exp $

IUSE=""

MY_S="${WORKDIR}/${PN}"

DESCRIPTION="raw copy title sets from a DVD to your harddisc"
SRC_URI="http://www.lallafa.de/bp/files/${P}.tgz"
HOMEPAGE="http://www.lallafa.de/bp/cpvts.html"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc ~x86"

DEPEND="media-libs/libdvdread"

src_compile () {
	cd ${MY_S} || die
	emake || die
}

src_install () {
	dobin ${MY_S}/${PN} || die
}
