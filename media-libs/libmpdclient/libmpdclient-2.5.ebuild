# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libmpdclient/libmpdclient-2.5.ebuild,v 1.1 2011/07/06 17:13:56 angelos Exp $

EAPI=3

DESCRIPTION="A library for interfacing Music Player Daemon (media-sound/mpd)"
HOMEPAGE="http://www.musicpd.org"
SRC_URI="mirror://sourceforge/musicpd/${P}.tar.bz2"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~arm ~hppa ~ppc ~ppc64 ~sparc ~x86"
IUSE="examples static-libs"

src_configure() {
	econf \
		--docdir="${EPREFIX}"/usr/share/doc/${PF} \
		$(use_enable static-libs static)
}

src_install() {
	emake install DESTDIR="${D}" || die "emake install failed"
	if use examples; then
		dodoc src/example.c || die "dodoc failed"
	fi
	find "${ED}" -name "*.la" -delete || die "failed to delete .la files"
}
