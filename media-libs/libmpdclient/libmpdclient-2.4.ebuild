# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libmpdclient/libmpdclient-2.4.ebuild,v 1.5 2011/03/01 14:52:05 jer Exp $

EAPI=3

DESCRIPTION="A library for interfacing Music Player Daemon (media-sound/mpd)"
HOMEPAGE="http://www.musicpd.org"
SRC_URI="mirror://sourceforge/musicpd/${P}.tar.bz2"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 arm hppa ppc ~ppc64 sparc ~x86"
IUSE="examples"

src_install() {
	emake install DESTDIR="${D}" || die "emake install failed"
	rm -rf "${D}"/usr/share/doc/${PN}
	dodoc AUTHORS NEWS README
	use examples && dodoc src/example.c
}
