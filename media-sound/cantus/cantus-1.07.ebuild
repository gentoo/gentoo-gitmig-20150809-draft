# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/cantus/cantus-1.07.ebuild,v 1.1 2003/06/19 11:39:23 mjc Exp $

DESCRIPTION="easy to use tool for tagging and renaming MP3 and OGG/Vorbis files"
HOMEPAGE="http://software.manicsadness.com/?site=project&project=1"
SRC_URI="http://sam.homeunix.com/software.manicsadness.com-step3/releases/cantus/${P}-1.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

DEPEND="vorbis? ( media-libs/libvorbis
		media-libs/libogg )"

S="${WORKDIR}/${P}"

src_compile() {
	econf || die "configure failed"
	make || die "make failed"
}

src_install() {
	einstall || die "Install failed"
}
					
