# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/mp3splt/mp3splt-1.9.ebuild,v 1.1 2003/09/16 09:12:59 aliz Exp $

IUSE=""

DESCRIPTION="A command line utility to split mp3 and ogg files"
HOMEPAGE="http://mp3splt.sourceforge.net/"
SRC_URI="mirror://sourceforge/mp3splt/${P}-src.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
DEPEND="media-libs/libogg
	media-libs/libvorbis
	media-sound/mad"
S=${WORKDIR}/${P}
