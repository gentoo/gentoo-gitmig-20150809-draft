# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-cdr/burncdda/burncdda-1.1.2.ebuild,v 1.5 2002/10/17 12:55:52 vapier Exp $

DESCRIPTION="Console app for copying burning audio cds"
SLOT="0"
SRC_URI="http://freshmeat.net/redir/burncdda/20268/url_tgz/${P}.tar.gz"
LICENSE="GPL-2"
HOMEPAGE="http://freshmeat.net/projects/burncdda/"
KEYWORDS="x86 ppc sparc sparc64"

DEPEND="dev-util/dialog
	app-cdr/cdrdao
	app-cdr/cdrtools
	media-sound/mpg123
	media-sound/mp3_check
	media-sound/normalize
	media-sound/sox
	media-sound/vorbis-tools"
RDEPEND="${DEPEND}"

src_install() {
	dodoc README CHANGELOG INSTALL LICENSE
	insinto /etc
	doins burncdda.conf
	dobin burncdda
	insinto /usr/share/man/man1
	doins burncdda.1.gz
}
