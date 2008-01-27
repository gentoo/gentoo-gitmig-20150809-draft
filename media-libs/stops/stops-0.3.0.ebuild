# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/stops/stops-0.3.0.ebuild,v 1.1 2008/01/27 19:48:23 aballier Exp $

DESCRIPTION="Organ stops for aeolus by Fons Adriaensen <fons.adriaensen@skynet.be>"
HOMEPAGE="http://www.kokkinizita.net/linuxaudio/aeolus/index.html"
SRC_URI="http://users.skynet.be/solaris/linuxaudio/downloads/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=""
RDEPEND=""

src_install() {
	insinto /usr/share/${PN}
	doins -r *.ae0 Aeolus* waves
}
