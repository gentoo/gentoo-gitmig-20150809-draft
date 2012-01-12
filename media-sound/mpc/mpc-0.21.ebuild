# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/mpc/mpc-0.21.ebuild,v 1.7 2012/01/12 21:10:15 maekke Exp $

EAPI=4
inherit bash-completion-r1

DESCRIPTION="A commandline client for Music Player Daemon (media-sound/mpd)"
HOMEPAGE="http://www.musicpd.org"
SRC_URI="mirror://sourceforge/musicpd/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm ~hppa ppc ppc64 sparc ~x86"
IUSE="iconv"

RDEPEND=">=media-libs/libmpdclient-2.2
	iconv? ( virtual/libiconv )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

DOCS=( AUTHORS NEWS README doc/mpd-m3u-handler.sh doc/mppledit
	doc/mpd-pls-handler.sh )

src_configure() {
	econf $(use_enable iconv) \
		--docdir="${EPREFIX}"/usr/share/doc/${PF}
}

src_install() {
	default
	newbashcomp doc/mpc-completion.bash ${PN}
}
