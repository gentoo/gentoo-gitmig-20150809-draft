# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Maintainer: Matt Keadle <mkeadle@mkeadle.org>
# $Header:

DESCRIPTION="Console app for copying burning audio cds"
SLOT="0"
SRC_URI="http://freshmeat.net/redir/burncdda/20268/url_tgz/${P}.tar.gz"
LICENSE="GPL-2"
HOMEPAGE="http://freshmeat.net/projects/burncdda/"
KEYWORDS="x86"

DEPEND="dev-util/dialog
	app-cdr/cdrdao
	app-cdr/cdrtools
	media-sound/mpg123
	media-sound/mp3_check
	media-sound/normalize
	media-sound/sox
	media-sound/vorbis-tools"

src_install () {
	dodoc README CHANGELOG INSTALL LICENSE
	insinto /etc
	doins burncdda.conf
	dobin burncdda
	insinto /usr/share/man/man1
	doins burncdda.1.gz
}

