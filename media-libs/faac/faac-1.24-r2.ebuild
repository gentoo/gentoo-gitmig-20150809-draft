# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/faac/faac-1.24-r2.ebuild,v 1.2 2006/04/20 15:12:58 hanno Exp $

inherit libtool eutils autotools

DESCRIPTION="Free MPEG-4 audio codecs by AudioCoding.com"
HOMEPAGE="http://www.audiocoding.com/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc-macos ~ppc64 ~sparc ~x86"
IUSE=""

RDEPEND=">=media-libs/libsndfile-1.0.0"
DEPEND="${RDEPEND}
	>=sys-devel/libtool-1.3.5
	sys-devel/automake
	!<media-libs/faad2-2.0-r3"

S=${WORKDIR}/${PN}

src_unpack() {
	unpack ${A}
	cd ${S}

	epatch "${FILESDIR}/${P}-faad.patch"
	epatch "${FILESDIR}/${P}-tracknumber.patch"
	epatch "${FILESDIR}/${P}-as-needed.patch"

	eautoreconf
	elibtoolize
	epunt_cxx
}

src_install() {
	make DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog NEWS README TODO docs/libfaac.pdf
}
