# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/mpc/mpc-0.20.ebuild,v 1.3 2011/02/27 22:09:50 hwoarang Exp $

EAPI=2
inherit bash-completion

DESCRIPTION="A commandline client for Music Player Daemon (media-sound/mpd)"
HOMEPAGE="http://www.musicpd.org"
SRC_URI="mirror://sourceforge/musicpd/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm ~hppa ppc ~ppc64 sparc ~x86"
IUSE="iconv"

RDEPEND=">=media-libs/libmpdclient-2.2
	iconv? ( virtual/libiconv )"
DEPEND="${RDEPEND}"

src_configure() {
	econf --disable-dependency-tracking \
		$(use_enable iconv)
}

src_install() {
	emake install DESTDIR="${D}" || die "emake install failed"
	dodoc AUTHORS NEWS README
	dodoc doc/mpd-m3u-handler.sh doc/mppledit doc/mpd-pls-handler.sh
	rm -rf "${D}"/usr/share/doc/${PN}

	dobashcompletion doc/mpc-completion.bash
}
