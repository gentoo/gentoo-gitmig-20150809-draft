# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/musicman/musicman-0.11-r1.ebuild,v 1.5 2004/11/29 23:06:38 eradicator Exp $

IUSE=""

inherit eutils kde

S="${WORKDIR}/musicman"

DESCRIPTION="A Konqueror plugin for manipulating ID3 tags in MP3 files"
HOMEPAGE="http://musicman.sourceforge.net/"
SRC_URI="mirror://sourceforge/musicman/${P}.tar.gz"

LICENSE="GPL-1"
SLOT="0"
KEYWORDS="amd64 ~ppc ~sparc x86"

DEPEND=">=kde-base/kdebase-3.2.1
	kde-base/arts
	>=media-libs/jpeg-6b-r3
	virtual/fam
	>=media-libs/libart_lgpl-2.3.16"

src_unpack() {
	unpack ${A}

	epatch ${FILESDIR}/${P}-gcc34.patch
	epatch ${FILESDIR}/${P}-amd64.patch
}

src_install() {
	einstall || die
	dodoc AUTHORS ChangeLog README TODO
}
