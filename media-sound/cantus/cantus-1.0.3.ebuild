# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/cantus/cantus-1.0.3.ebuild,v 1.7 2004/03/01 05:37:12 eradicator Exp $

DESCRIPTION="easy to use tool for tagging and renaming MP3 and OGG/Vorbis files"
HOMEPAGE="http://software.manicsadness.com/?site=project&project=1"
SRC_URI="http://sam.homeunix.com/software.manicsadness.com-step2/releases/cantus/cantus-1.03-1.tar.gz"

LICENSE="GPL-2"
SLOT="1"
KEYWORDS="x86"

DEPEND="vorbis? ( media-libs/libvorbis
		media-libs/libogg )"

S="${WORKDIR}/${PN}-1.03"

src_compile() {
	econf || die "configure failed"
	make || die "make failed"
}

src_install() {
	einstall || die "Install failed"
}
