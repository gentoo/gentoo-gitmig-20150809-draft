# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/amp/amp-0.7.6.ebuild,v 1.12 2006/05/15 19:05:01 tcort Exp $

inherit eutils

DESCRIPTION="AMP - the Audio Mpeg Player"
HOMEPAGE="http://packages.debian.org/oldstable/sound/amp"
SRC_URI="mirror://gentoo/${P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="amd64 sparc x86"
IUSE=""

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}-gcc34.patch
}

src_install() {
	dobin amp || die
	dodoc BUGS CHANGES README TODO doc/*
}
