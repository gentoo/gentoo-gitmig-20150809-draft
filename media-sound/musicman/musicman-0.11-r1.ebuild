# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/musicman/musicman-0.11-r1.ebuild,v 1.8 2005/01/18 20:14:13 greg_g Exp $

IUSE=""

inherit eutils kde

S="${WORKDIR}/musicman"

DESCRIPTION="A Konqueror plugin for manipulating ID3 tags in MP3 files"
HOMEPAGE="http://musicman.sourceforge.net/"
SRC_URI="mirror://sourceforge/musicman/${P}.tar.gz"

LICENSE="GPL-1"
SLOT="0"
KEYWORDS="amd64 ~ppc sparc x86"

DEPEND="|| ( kde-base/kdebase-meta >=kde-base/kdebase-3.2.1 )
	kde-base/arts
	>=media-libs/jpeg-6b-r3
	virtual/fam
	>=media-libs/libart_lgpl-2.3.16"

need-kde 3.2

src_unpack() {
	unpack ${A}

	epatch ${FILESDIR}/${P}-gcc34.patch
	epatch ${FILESDIR}/${P}-amd64.patch
}
