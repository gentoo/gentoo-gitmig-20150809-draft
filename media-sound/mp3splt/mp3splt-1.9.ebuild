# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/mp3splt/mp3splt-1.9.ebuild,v 1.3 2004/01/18 08:49:21 seemant Exp $

IUSE=""

S=${WORKDIR}/${P}
DESCRIPTION="A command line utility to split mp3 and ogg files"
HOMEPAGE="http://mp3splt.sourceforge.net/"
SRC_URI="mirror://sourceforge/mp3splt/${P}-src.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86"

DEPEND="media-libs/libogg
	media-libs/libvorbis
	media-sound/mad"

src_compile() {
	econf || die
	emake || die "build failed"
}

src_install() {
	einstall || die "install failed"
}
