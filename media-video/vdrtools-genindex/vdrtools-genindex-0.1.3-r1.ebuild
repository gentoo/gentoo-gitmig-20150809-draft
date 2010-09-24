# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/vdrtools-genindex/vdrtools-genindex-0.1.3-r1.ebuild,v 1.1 2010/09/24 13:16:57 hd_brummy Exp $

EAPI="2"

inherit eutils

SCRIPT="genindex"

DESCRIPTION="VDR: genindex Script"
HOMEPAGE="http://www.cadsoft.de/vdr/"
SRC_URI="http://www.muempf.de/down/${SCRIPT}-${PV}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""

S=${WORKDIR}/${SCRIPT}-${PV}

src_prepare() {
	epatch "${FILESDIR}"/ldflags.diff
}

src_install() {
	dodoc README
	dobin genindex
}
