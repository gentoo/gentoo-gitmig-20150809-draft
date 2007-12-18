# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-cdr/mp3burn/mp3burn-0.4.0.ebuild,v 1.2 2007/12/18 17:26:16 eradicator Exp $

IUSE=""

inherit eutils

DESCRIPTION="Burn mp3s without filling up your disk with .wav files"
HOMEPAGE="http://sourceforge.net/projects/mp3burn/"
SRC_URI="mirror://sourceforge/mp3burn/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"

DEPEND="dev-lang/perl"

RDEPEND="${DEPEND}
	 virtual/mpg123
	 media-libs/flac
	 media-sound/vorbis-tools
	 virtual/cdrtools
	 dev-perl/MP3-Info
	 dev-perl/String-ShellQuote"

S="${WORKDIR}/${PN}"

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i 's:mpg321:mpg123:g' mp3burn
}

src_compile() {
	emake || die "Compilation failed."
}

src_install() {
	dobin mp3burn
	doman mp3burn.1
	dodoc Changelog README
}
