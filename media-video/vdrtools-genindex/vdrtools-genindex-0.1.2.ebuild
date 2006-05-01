# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/vdrtools-genindex/vdrtools-genindex-0.1.2.ebuild,v 1.1 2006/05/01 15:29:35 hd_brummy Exp $

SCRIPT="genindex"

DESCRIPTION="Video Disk Recorder genindex Script"
HOMEPAGE="http://www.cadsoft.de/vdr/"
SRC_URI="http://www.muempf.de/down/${SCRIPT}-${PV}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86"
IUSE=""

DEPEND=""

S=${WORKDIR}/${SCRIPT}-${PV}

src_unpack() {
	unpack ${A}
}

src_compile() {
	cd ${S}
	make || die "make failed"
}

src_install() {

	dobin genindex
}
