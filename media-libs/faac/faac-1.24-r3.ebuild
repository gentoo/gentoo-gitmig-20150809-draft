# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/faac/faac-1.24-r3.ebuild,v 1.5 2007/02/13 12:19:01 opfer Exp $

WANT_AUTOCONF=latest
WANT_AUTOMAKE=latest

inherit libtool eutils autotools

DESCRIPTION="Free MPEG-4 audio codecs by AudioCoding.com"
HOMEPAGE="http://www.audiocoding.com/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc-macos ~ppc64 ~sh ~sparc x86 ~x86-fbsd"
IUSE=""

RDEPEND=">=media-libs/libsndfile-1.0.0
	media-libs/libmp4v2"
DEPEND="${RDEPEND}
	!<media-libs/faad2-2.0-r3"

S=${WORKDIR}/${PN}

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}/${P}-tracknumber.patch"
	epatch "${FILESDIR}/${P}-as-needed.patch"

	eautoreconf
	elibtoolize
	epunt_cxx
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog NEWS README TODO docs/libfaac.pdf
}
