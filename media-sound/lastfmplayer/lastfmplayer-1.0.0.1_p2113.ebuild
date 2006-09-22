# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/lastfmplayer/lastfmplayer-1.0.0.1_p2113.ebuild,v 1.5 2006/09/22 21:50:39 genstef Exp $

inherit eutils subversion versionator

DESCRIPTION="The player allows you to listen to last.fm radio streams"
HOMEPAGE="http://www.last.fm/help/player"
SRC_URI=""
ESVN_REPO_URI="svn://svn.audioscrobbler.net/LastFM_client/trunk"
ESVN_OPTIONS="--revision ${PV#*_p}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="debug"

MY_QT_DEP="=x11-libs/qt-4*"
DEPEND="${MY_QT_DEP}"
RDEPEND="${DEPEND}"

pkg_setup() {
	local qt_version=$(best_version ${MY_QT_DEP})

	if ! built_with_use ${MY_QT_DEP} gif png ; then
		eerror "It is nessary to compile ${qt_version} with gif and png USE flag" 
		eerror
		eerror "To do this, run the following:"
		eerror "echo \"${MY_QT_DEP} gif png\" >> /etc/portage/package.use"
		eerror "and reemerge by running  \"emerge -av1 ${MY_QT_DEP}\""
		die "no gif or png support in qt"
	fi

	if use debug && ! built_with_use ${MY_QT_DEP} debug ; then
		eerror "In order to use debug, you need to compile ${qt_version}"
		eerror "with debug USE flag."
		die "no debug support in qt"
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
	einfo "To use the Last.fm player with a mozilla based browser:"
	einfo " 1. Go to about:config in the browser"
	einfo " 2. Right-click on the page"
	einfo " 3. Select New and then String"
	einfo " 4. For the name: network.protocol-handler.app.lastfm"
	einfo " 5. For the value: /usr/bin/lastfm"
	einfo
	einfo "If you experiance awkward fonts or widgets, try running qtconfig."
}
