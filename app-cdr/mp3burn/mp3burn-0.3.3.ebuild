# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-cdr/mp3burn/mp3burn-0.3.3.ebuild,v 1.5 2004/09/03 21:05:46 eradicator Exp $

IUSE=""

DESCRIPTION="Burn mp3s without filling up your disk with .wav files"
HOMEPAGE="http://sourceforge.net/projects/mp3burn/"
SRC_URI="mirror://sourceforge/mp3burn/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc amd64 sparc"

DEPEND="dev-lang/perl"

RDEPEND="${DEPEND}
	 virtual/mpg123
	 media-libs/flac
	 media-sound/vorbis-tools
	 virtual/cdrtools
	 dev-perl/MP3-Info
	 dev-perl/String-ShellQuote"

src_compile() {
	emake
}

src_install() {
	dobin mp3burn
	doman mp3burn.1
	dodoc Changelog INSTALL README
}
