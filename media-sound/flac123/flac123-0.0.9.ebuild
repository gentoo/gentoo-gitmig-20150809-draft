# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/flac123/flac123-0.0.9.ebuild,v 1.7 2007/01/22 17:15:53 corsair Exp $

WANT_AUTOCONF=2.5
WANT_AUTOMAKE=1.6

inherit eutils autotools

DESCRIPTION="console app for playing FLAC audio files"
HOMEPAGE="http://flac-tools.sourceforge.net"
SRC_URI="mirror://sourceforge/flac-tools/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ppc64 sparc x86"
IUSE=""

DEPEND="media-libs/flac
	media-libs/libao"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${P}+flac-1.1.3.patch"
	epatch "${FILESDIR}/${P}-asneeded.patch"
	eautoreconf
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS BUGS ChangeLog NEWS README* TODO
}
