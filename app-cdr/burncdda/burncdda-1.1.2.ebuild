# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-cdr/burncdda/burncdda-1.1.2.ebuild,v 1.9 2003/12/05 13:59:49 weeve Exp $

DESCRIPTION="Console app for copying burning audio cds"
SLOT="0"
SRC_URI="http://freshmeat.net/redir/burncdda/20268/url_tgz/${P}.tar.gz"
LICENSE="GPL-2"
HOMEPAGE="http://freshmeat.net/projects/burncdda/"
KEYWORDS="x86 ppc ~sparc "

DEPEND="dev-util/dialog
	app-cdr/cdrdao
	app-cdr/cdrtools
	media-sound/mpg123
	media-sound/mp3_check
	media-sound/normalize
	media-sound/sox
	media-sound/vorbis-tools"

src_install() {
	dodoc README CHANGELOG INSTALL LICENSE
	insinto /etc
	doins burncdda.conf
	dobin burncdda
	insinto /usr/share/man/man1
	doins burncdda.1.gz
}
