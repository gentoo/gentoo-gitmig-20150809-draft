# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/mplay/mplay-0.68.ebuild,v 1.8 2007/01/05 17:37:58 flameeyes Exp $

IUSE=""

inherit perl-module

AMIX_V="0.7"
AMIX_D="${WORKDIR}/Audio-Mixer-${AMIX_V}"

PP_V="0.07"
PP_D="${WORKDIR}/Ogg-Vorbis-Header-PurePerl-${PP_V}"

DESCRIPTION="A Curses front-end for mplayer"
HOMEPAGE="http://mplay.sourceforge.net"
SRC_URI="mirror://sourceforge/mplay/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~sparc ~ppc x86"

DEPEND="dev-lang/perl
	dev-perl/TermReadKey
	dev-perl/MP3-Info
	dev-perl/Term-ANSIScreen
	virtual/perl-Time-HiRes
	media-video/mplayer"

src_unpack() {
	unpack ${A}

	#build the Audio-Mixer dep
	cd ${S}/src
	tar xfz Audio-Mixer-${AMIX_V}.tar.gz -C ${WORKDIR}
	tar xfz Ogg-Vorbis-Header-PurePerl-${PP_V}.tar.gz -C ${WORKDIR}

	cd ${S}
	sed 's:/usr/local:/usr:g' -i mplay || die "Unable fix the /usr/local path issues."
}

src_compile() {
	cd ${AMIX_D}
	perl-module_src_prep
	perl-module_src_compile

	cd ${PP_D}
	perl-module_src_prep
	perl-module_src_compile
}

src_install() {
	dodir /usr/share/mplay /usr/bin

	dobin mplay

	dodoc README

	cd ${S}/help
	insinto /usr/share/mplay
	doins help_en help_de mplayconf
	doman mplay.1


	cd ${AMIX_D}
	#make install
	perl-module_src_install

	cd ${PP_D}
	#make install
	perl-module_src_install
}

pkg_postinst() {
	elog "Please note, gnome terminal does not like this program"
	elog "too much.  xterm,kterm, and konsole can use it ok."
}
