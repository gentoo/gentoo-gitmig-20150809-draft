# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/cantus/cantus-1.0.3.ebuild,v 1.3 2003/01/17 22:22:59 vapier Exp $

DESCRIPTION="easy to use tool for tagging and renaming MP3 and OGG/Vorbis files"
HOMEPAGE="http://software.manicsadness.com/?site=project&project=1"
SRC_URI="http://sam.homeunix.com/software.manicsadness.com-step2/releases/cantus/cantus-1.03-1.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

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
