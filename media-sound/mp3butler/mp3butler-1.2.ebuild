# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/mp3butler/mp3butler-1.2.ebuild,v 1.2 2003/09/08 07:09:44 msterret Exp $

MY_P="${PN/mp3}-${PV}"
DESCRIPTION="Tool for organizing MP3 Collections"
SRC_URI="http://illuzionz.org/pub/mp3butler/${MY_P}.tar.gz"
HOMEPAGE="http://babblica.net/mp3butler"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86"

DEPEND="media-sound/id3"

S=${WORKDIR}/${MY_P}

src_compile () {
	cd ${S}
	./mkdocs
}

src_install () {

	insinto ${D}
	dobin albumbutler.pl mp3butler.pl minibutler.pl
	doman mp3butler.1.gz
	dodoc sample.butlerrc
	dodoc AUTHORS COPYING ChangeLog RANT README
}

