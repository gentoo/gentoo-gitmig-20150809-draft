# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/SmarTagger/SmarTagger-0.1.ebuild,v 1.3 2004/10/19 06:14:08 eradicator Exp $

IUSE=""

DESCRIPTION="Perl script for renaming and tagging mp3s"
HOMEPAGE="http://freshmeat.net/projects/smartagger/"
SRC_URI="http://freshmeat.net/redir/smartagger/9680/url_tgz/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"

DEPEND=""

RDEPEND="dev-lang/perl
	dev-perl/MP3-Info"

src_install() {
	exeinto /usr/bin
	doexe SmarTagger

	dosym /usr/bin/SmarTagger /usr/bin/smartagger

	dodoc INSTALL README TODO
	newdoc changelog ChangeLog
	newdoc album.id3 Example.id3
}
