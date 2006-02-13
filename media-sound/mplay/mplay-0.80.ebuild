# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/mplay/mplay-0.80.ebuild,v 1.4 2006/02/13 14:49:58 mcummings Exp $


DESCRIPTION="A Curses front-end for mplayer"
HOMEPAGE="http://mplay.sourceforge.net"
SRC_URI="mirror://sourceforge/mplay/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~sparc ~ppc ~x86"
IUSE=""

DEPEND="dev-lang/perl
	>=dev-perl/MP3-Info-1.11
	>=dev-perl/Class-MakeMethods-1.01
	dev-perl/Audio-Mixer
	dev-perl/Ogg-Vorbis-Header-PurePerl
	>=virtual/perl-Time-HiRes-1.56
	>=dev-perl/TermReadKey-2.21
	dev-perl/Video-Info
	media-video/mplayer"

src_unpack() {
	unpack ${A}
	cd ${S}
	sed 's:/usr/local:/usr:g' -i mplay || die "Unable fix the /usr/local path issues."
}

src_install() {
	dodir /usr/share/mplay /usr/bin

	dobin mplay
	dodoc README

	cd ${S}/help
	insinto /usr/share/mplay
	doins help_en help_de mplayconf
	doman mplay.1
}

pkg_postinst() {
	einfo "Please note, gnome terminal does not like this program"
	einfo "too much.  xterm,kterm, and konsole can use it ok."
}
