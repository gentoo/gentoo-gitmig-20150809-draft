# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/x264-svn/x264-svn-20060302-r1.ebuild,v 1.3 2006/03/18 16:17:02 corsair Exp $

inherit multilib eutils

IUSE="debug mp4 threads"

DESCRIPTION="A free libary for encoding X264/AVC streams."
HOMEPAGE="http://developers.videolan.org/x264.html"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="-* ~amd64 ~ppc ~ppc64 ~x86"

RDEPEND="mp4? ( >=media-video/gpac-0.4.1_pre20060122 )"

DEPEND="${RDEPEND}
	amd64? ( dev-lang/yasm )
	x86? ( dev-lang/nasm )"

S=${WORKDIR}/${PN}

src_unpack() {
	unpack ${A}
	cd ${S}

	epatch "${FILESDIR}/${P}-nostrip.patch"
}

src_compile() {
	./configure --prefix=/usr \
		--libdir=/usr/$(get_libdir) \
		--enable-pic \
		$(use_enable debug) \
		$(use_enable threads pthread) \
		$(use_enable mp4 mp4-output) \
		$myconf \
		|| die "configure failed"
	emake -j1 || die "make failed"
}

src_install() {
	make DESTDIR="${D}" install || die
	dodoc AUTHORS TODO COPYING
}
