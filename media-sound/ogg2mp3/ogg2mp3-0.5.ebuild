# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/ogg2mp3/ogg2mp3-0.5.ebuild,v 1.2 2005/07/25 13:51:43 dholm Exp $

IUSE=""

DESCRIPTION="A perl script to convert Ogg Vorbis files to MP3 files."

HOMEPAGE="http://amor.cms.hu-berlin.de/~h0444y2j/linux.html"
SRC_URI="http://amor.cms.hu-berlin.de/~h0444y2j/pub/${P}.tar.bz2"

LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"

RDEPEND="media-sound/lame
	dev-perl/String-ShellQuote
	media-sound/vorbis-tools"

src_install() {
	dobin ogg2mp3
}
