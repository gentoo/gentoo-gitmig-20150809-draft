# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/wavplay/wavplay-1.4.ebuild,v 1.4 2003/04/24 13:34:47 phosphan Exp $

inherit eutils

DESCRIPTION="A command line player/recorder for wav files"
SRC_URI="http://ibiblio.org/pub/linux/apps/sound/players/${P}.tar.gz"
HOMEPAGE="http://orphan//"
LICENSE="GPL-2"
DEPEND="virtual/glibc"
SLOT="0"
KEYWORDS="x86"

IUSE=""

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/${P}.patch
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

