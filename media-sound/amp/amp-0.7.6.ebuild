# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/amp/amp-0.7.6.ebuild,v 1.11 2004/09/14 07:21:02 eradicator Exp $

IUSE=""

inherit eutils

DESCRIPTION="AMP - the Audio Mpeg Player"
LICENSE="as-is"

SRC_URI="http://distro.ibiblio.org/pub/Linux/distributions/slackware/slackware_source/ap/amp/${P}.tar.gz"
KEYWORDS="x86 sparc amd64"
SLOT="0"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}-gcc34.patch
}

src_install() {
	dobin amp || die
	dodoc BUGS CHANGES README TODO doc/*
}
