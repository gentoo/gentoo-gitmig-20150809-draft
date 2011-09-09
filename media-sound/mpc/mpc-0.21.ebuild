# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/mpc/mpc-0.21.ebuild,v 1.2 2011/09/09 17:34:01 mgorny Exp $

EAPI=4
inherit bash-completion-r1

DESCRIPTION="A commandline client for Music Player Daemon (media-sound/mpd)"
HOMEPAGE="http://www.musicpd.org"
SRC_URI="mirror://sourceforge/musicpd/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~arm ~hppa ~ppc ~ppc64 ~sparc ~x86"
IUSE="iconv"

RDEPEND=">=media-libs/libmpdclient-2.2
	iconv? ( virtual/libiconv )"
DEPEND="${RDEPEND}"

DOCS=( AUTHORS NEWS README doc/mpd-m3u-handler.sh doc/mppledit
	doc/mpd-pls-handler.sh )

src_configure() {
	econf $(use_enable iconv)
}

src_install() {
	default
	rm -rf "${ED}"/usr/share/doc/${PN}
	newbashcomp doc/mpc-completion.bash ${PN}
}
