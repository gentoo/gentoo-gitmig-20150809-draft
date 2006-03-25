# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-cdr/burncdda/burncdda-1.4.2.ebuild,v 1.1 2006/03/25 18:20:52 metalgod Exp $

DESCRIPTION="Console app for copying burning audio cds"
SLOT="0"
SRC_URI="http://www.thenktor.homepage.t-online.de/burncdda/download/${P}.tar.gz"
LICENSE="GPL-2"
HOMEPAGE="http://www.thenktor.homepage.t-online.de/burncdda/index.html"
IUSE=""
KEYWORDS="~amd64 ~ppc ~sparc ~x86"

DEPEND="dev-util/dialog
	app-cdr/cdrdao
	app-cdr/cdrtools
	virtual/mpg123
	media-sound/mp3_check
	media-sound/normalize
	media-sound/sox
	media-sound/vorbis-tools"

src_install() {
	dodoc CHANGELOG INSTALL LICENSE
	insinto /etc
	doins burncdda.conf
	dobin burncdda
	insinto /usr/share/man/man1
	doins burncdda.1.gz
}
