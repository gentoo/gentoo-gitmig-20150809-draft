# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/lastfmplayer/lastfmplayer-1.2_pre2099.ebuild,v 1.2 2006/05/02 22:26:45 swegener Exp $

inherit eutils subversion

DESCRIPTION="The Last.fm player allows you to listen to their internet radio which is tailored to your music profile"
HOMEPAGE="http://lastfmplayer.sourceforge.net"
SRC_URI=""
ESVN_REPO_URI="svn://svn.audioscrobbler.net/player/branches/1.2"
ESVN_OPTIONS="--revision ${PV#*_pre}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND="=x11-libs/qt-4*"
RDEPEND="${DEPEND}"

pkg_setup() {
	if ! built_with_use x11-libs/qt gif ; then
		eerror "It appears that qt was compiled with the \"gif\" USE flag disabled."
		eerror
		eerror "In order to use the Last.fm player, you need to enable this USE flag"
		eerror "To do this, run the following in a command window:"
		eerror "echo \"x11-libs/qt gif\" >> /etc/portage/package.use"
		eerror "and recompile qt using \"emerge -avN1 qt\""

		die "no gif support in qt"
	fi
}

src_compile() {
	# gcc-4.1 fix
	sed -i "s/Player:://" src/player.h || die
	qmake || die "qmake failed"
	emake || die "emake failed"
}

src_install() {
	# The root at which the player, data, and cache
	# are to be installed
	local destination="/opt/lastfm"

	# Install the player
	exeinto ${destination}
	doexe player

	insinto ${destination}
	doins -r data

	# Make a folder such that album art cache works
	diropts -m0775 -g audio
	dodir ${destination}/cache
	keepdir ${destination}/cache

	make_wrapper lastfm ./player ${destination}
	newicon data/icon.png lastfm.png
	make_desktop_entry lastfm "Last.fm Player" lastfm.png

	insinto /usr/share/services
	doins ${FILESDIR}/lastfm.protocol

	dodoc ChangeLog README
}

pkg_postinst() {
	einfo "In order to use the Last.fm player with your mozilla based browser,"
	einfo "You must follow these steps:"
	einfo " 1. Go to \"about:config\" using the location bar"
	einfo " 2. Right-click on the page.  Select \"New\" and then \"String\""
	einfo " 3. Type in the name field: \"network.protocol-handler.app.lastfm\""
	einfo " 4. Type in the value field: \"/usr/bin/lastfm\""
	einfo
	einfo "If you experiance awkward fonts or widgets, you may consider"
	einfo "running \"qtconfig\" and change the settings"
}
