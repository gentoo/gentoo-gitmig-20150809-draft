# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libmp3splt/libmp3splt-0.5.2.ebuild,v 1.2 2009/01/09 16:29:58 josejx Exp $

inherit autotools eutils

DESCRIPTION="a library for mp3splt to split mp3 and ogg files without decoding."
HOMEPAGE="http://mp3splt.sourceforge.net"
SRC_URI="mirror://sourceforge/mp3splt/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

DEPEND="media-libs/libmad
	media-libs/libvorbis media-libs/libogg
	media-libs/libid3tag"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-ceilf.patch
	# Can't get it to link properly to libltdl without eautoreconfing it
	eautoreconf
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed."
	dodoc AUTHORS ChangeLog LIMITS NEWS README TODO
}
