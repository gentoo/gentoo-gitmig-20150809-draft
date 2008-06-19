# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-cdr/mp3burn/mp3burn-0.4.0.ebuild,v 1.5 2008/06/19 19:44:24 bluebird Exp $

DESCRIPTION="Burn mp3s without filling up your disk with .wav files"
HOMEPAGE="http://sourceforge.net/projects/mp3burn/"
SRC_URI="mirror://sourceforge/mp3burn/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc sparc ~x86"
IUSE=""

DEPEND="dev-lang/perl"
RDEPEND="${DEPEND}
	 virtual/mpg123
	 media-libs/flac
	 media-sound/vorbis-tools
	 virtual/cdrtools
	 dev-perl/MP3-Info
	 dev-perl/ogg-vorbis-header
	 dev-perl/String-ShellQuote"

S=${WORKDIR}/${PN}

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i -e 's:mpg321:mpg123:g' mp3burn || die "sed failed."
}

src_compile() {
	emake || die "emake failed."
}

src_install() {
	dobin mp3burn || die "dobin failed."
	doman mp3burn.1
	dodoc Changelog README
}
