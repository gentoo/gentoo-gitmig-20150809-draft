# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/wavplay/wavplay-1.4.ebuild,v 1.10 2004/09/15 17:43:43 eradicator Exp $

inherit eutils

DESCRIPTION="A command line player/recorder for wav files"
SRC_URI="http://ibiblio.org/pub/linux/apps/sound/players/${P}.tar.gz"
HOMEPAGE="http://orphan//"
LICENSE="GPL-2"
DEPEND="virtual/libc"
SLOT="0"
KEYWORDS="x86 amd64"

IUSE=""

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/${P}.patch
	epatch ${FILESDIR}/${P}-gcc34.patch
}

src_compile() {
	emake no_x || die
}

src_install () {
	dodir /usr/bin
	emake INSTDIR=${D}usr/bin install_no_x || die
	# the motif frontend crashes and there are nicer player
	# for X anyway
	# no suid root install for old packages which use strcpy
	dodoc BUGS README
	doman *.1
}

