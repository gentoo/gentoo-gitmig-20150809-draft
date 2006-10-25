# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/mplayer-resume/mplayer-resume-1.3.ebuild,v 1.1 2006/10/25 16:27:09 beandog Exp $

inherit depend.php

DESCRIPTION="MPlayer wrapper script to save/resume playback position"
HOMEPAGE="http://www.wonkabar.org/~steve/downloads/mplayer-resume/"
SRC_URI="http://www.wonkabar.org/~steve/downloads/${PN}/${P}.tar.gz"
LICENSE="public-domain"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""
DEPEND=""
RDEPEND="app-misc/lirc media-video/mplayer"

need_php_cli

pkg_setup() {

	require_php_with_use pcre cli

	if ! built_with_use media-video/mplayer lirc
	then
		eerror "media-video/mplayer must also be compiled with the"
		eerror "lirc USE flag to work properly with mplayer-resume."
		die "Fix mplayer USE flags and re-emerge"
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
	einfo "To get mplayer-resume to save playback position with LIRC,"
	einfo "you will need to setup an entry in ~/.lircrc to run "
	einfo "'get_time_pos' and then 'quit'.  More instructions are"
	einfo "detailed in the README, but the position will not be saved"
	einfo "until you set it up."
	echo ""
	einfo "Playback position files are saved in ~/.mplayer/playback"
}
