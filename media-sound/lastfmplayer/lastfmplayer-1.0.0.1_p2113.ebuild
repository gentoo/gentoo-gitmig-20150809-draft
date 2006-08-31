# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/lastfmplayer/lastfmplayer-1.0.0.1_p2113.ebuild,v 1.4 2006/08/31 00:08:11 genstef Exp $

inherit eutils subversion versionator

DESCRIPTION="The Last.fm player allows you to listen to their internet radio which is tailored to your music profile"
HOMEPAGE="http://www.last.fm/help/player"
SRC_URI=""
ESVN_REPO_URI="svn://svn.audioscrobbler.net/LastFM_client/trunk"
ESVN_OPTIONS="--revision ${PV#*_p}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="debug"

DEPEND="=x11-libs/qt-4*"
RDEPEND="${DEPEND}"

pkg_setup() {
	if ! built_with_use x11-libs/qt gif png ; then
		eerror "It appears that qt was compiled without the gif or png USE flag"
		eerror
		eerror "In order to work, you need to enable these USE flag(s)"
		eerror "To do this, run the following in a command window:"
		eerror "echo \"x11-libs/qt gif png\" >> /etc/portage/package.use"
		eerror "and recompile qt using \"emerge -avN1 qt\""

		die "no gif or png support in qt"
	fi

	if use debug && ! built_with_use x11-libs/qt debug ; then
		eerror "In order to use debug, you need to compile Qt 4"
		eerror "with debug USE flag."
	fi
}

src_compile() {
	if use debug ; then
		qmake CONFIG+=debug || die "qmake failed"
	else
		qmake CONFIG-=debug QMAKE_TARGET=LastFM || die "qmake failed"
	fi
	emake -j1 qmake_all || die "emake qmake_all failed"
	epatch ${FILESDIR}/lastfmplayer-amd64.patch
	emake -j1 || die "emake failed"
}

src_install() {
	# Docs
	dodoc ChangeLog HACKING README TODO

	# The root at which the player, data, and cache
	# are to be installed
	local destination="/opt/lastfm"
	cd bin

	#Bin name
	if ! use debug ; then
		MY_B=LastFM
	else
		MY_B=LastFM_debug
	fi

	# Install the player
	exeinto ${destination}
	doexe ${MY_B}

	# Install libraries and symlinks
	v=( $(get_version_components ) )
	base=libLastFMTools.so
	one=${base}.${v[0]}
	two=${one}.${v[1]}
	three=${two}.${v[2]}
	dosym ${three} ${destination}/${two}
	dosym ${two} ${destination}/${one}
	dosym ${one} ${destination}/${base}

	insinto ${destination}
	doins -r data extensions services ${three}

	# Make a folder such that album art cache works
	diropts -m0775 -g audio
	dodir ${destination}/cache
	keepdir ${destination}/cache

	# Icon, menu, protcol
	make_wrapper lastfm ./${MY_B} ${destination} ${destination}
	newicon data/icon.png lastfm.png
	make_desktop_entry lastfm "Last.fm Player" lastfm.png

	insinto /usr/share/services
	doins ${FILESDIR}/lastfm.protocol
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
	einfo
	einfo "To configure a browser you need to add something like"
	einfo "\"Browser=/usr/bin/firefox\" under [general] in ~/.config/last.fm/player.ini"
}
