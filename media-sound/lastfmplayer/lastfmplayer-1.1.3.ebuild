# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/lastfmplayer/lastfmplayer-1.1.3.ebuild,v 1.1 2007/02/11 11:17:36 genstef Exp $

inherit eutils versionator

DESCRIPTION="The player allows you to listen to last.fm radio streams"
HOMEPAGE="http://www.last.fm/help/player"
MY_P="${P/lastfmplayer/last.fm}"
SRC_URI="http://static.last.fm/client/Linux/${MY_P}.src.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""
RESTRICT="nomirror"
S="${WORKDIR}/${MY_P}"

DEPEND=">=x11-libs/qt-4.2
	media-libs/alsa-lib"

src_compile() {
	./configure
	emake -j1 || die "emake failed"
}

src_install() {
	# Docs
	dodoc ChangeLog README

	# The root at which the player, data, and cache
	# are to be installed
	local destination="/opt/lastfm"
	cd bin

	# Make ${destination} writable by audio group
	diropts -m0775 -g audio
	dodir ${destination}

	# Install the player
	cp -R * ${D}/${destination}

	# Make a folder such that album art cache works
	diropts -m0775 -g audio
	dodir ${destination}/cache
	keepdir ${destination}/cache

	# Icon, menu, protcol
	make_wrapper lastfm ./last.fm ${destination} ${destination}
	newicon data/icons/as.png lastfm.png
	make_desktop_entry lastfm "Last.fm Player" lastfm.png

	insinto /usr/share/services
	doins ${FILESDIR}/lastfm.protocol
}

pkg_postinst() {
	einfo "To use the Last.fm player with a mozilla based browser:"
	einfo " 1. Go to about:config in the browser"
	einfo " 2. Right-click on the page"
	einfo " 3. Select New and then String"
	einfo " 4. For the name: network.protocol-handler.app.lastfm"
	einfo " 5. For the value: /usr/bin/lastfm"
	einfo
	einfo "If you experiance awkward fonts or widgets, try running qtconfig."
}
