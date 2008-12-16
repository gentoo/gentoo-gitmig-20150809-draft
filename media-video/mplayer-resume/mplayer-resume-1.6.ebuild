# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/mplayer-resume/mplayer-resume-1.6.ebuild,v 1.1 2008/12/16 20:38:27 beandog Exp $

inherit depend.php

DESCRIPTION="MPlayer wrapper script to save/resume playback position"
HOMEPAGE="http://www.spaceparanoids.org/trac/bend/wiki/mplayer-resume"
SRC_URI="http://spaceparanoids.org/downloads/mplayer-resume/${P}.tar.gz"
LICENSE="public-domain"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
DEPEND=""
RDEPEND="app-misc/lirc
	media-video/mplayer"

need_php_cli

pkg_setup() {

	require_php_with_use pcre cli

	if ! built_with_use media-video/mplayer lirc
	then
		eerror "media-video/mplayer must also be compiled with the"
		eerror "lirc use flag to work properly with mplayer-resume."
		die "Fix mplayer use flags and re-emerge"
	fi
}

src_compile() {
	return;
}

src_install() {
	dobin mplayer-resume
	dodoc ChangeLog README
}

pkg_postinst() {
	elog "To get mplayer-resume to save playback position with LIRC,"
	elog "you will need to setup an entry in ~/.lircrc to run "
	elog "'get_time_pos' and then 'quit'.  More instructions are"
	elog "detailed in the README, but the position will not be saved"
	elog "until you set it up."
	elog ""
	elog "Playback position files are saved in ~/.mplayer/playback"
}
