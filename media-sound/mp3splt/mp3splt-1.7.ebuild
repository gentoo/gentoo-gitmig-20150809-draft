# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/mp3splt/mp3splt-1.7.ebuild,v 1.1 2003/05/13 09:43:19 jje Exp $

IUSE=""

DESCRIPTION="A command line utility to split mp3 and ogg files"
HOMEPAGE="http://mp3splt.sourceforge.net/"
SRC_URI="mirror://sourceforge/mp3splt/${P}-src.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
DEPEND="libogg libvorbis mad"
S=${WORKDIR}/${P}

src_compile() {
	econf
	emake || die "build failed"
}

src_install() {
	einstall || die "install failed"
}
