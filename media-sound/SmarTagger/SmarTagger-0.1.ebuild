# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/SmarTagger/SmarTagger-0.1.ebuild,v 1.2 2004/09/02 13:33:16 dholm Exp $

DESCRIPTION="Perl script for renaming and tagging mp3s"
HOMEPAGE="http://freshmeat.net/projects/smartagger/"
SRC_URI="http://freshmeat.net/redir/smartagger/9680/url_tgz/${P}.tar.gz"

IUSE=""
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc"

DEPEND="dev-lang/perl
	dev-perl/MP3-Info"

src_unpack() {
	unpack ${A}
	cd ${S}
	mv changelog ChangeLog
	mv album.id3 Example.id3
}

src_install() {
	dodir /usr/bin/

	exeinto /usr/bin
	doexe SmarTagger

	dosym /usr/bin/SmarTagger /usr/bin/smartagger

	dodoc ChangeLog INSTALL README TODO Example.id3
}

