# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/x264-svn/x264-svn-20060302.ebuild,v 1.3 2006/04/09 16:34:09 lu_zero Exp $

inherit multilib

IUSE="debug threads"

DESCRIPTION="A free library for encoding X264/AVC streams."
HOMEPAGE="http://developers.videolan.org/x264.html"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="-* ~amd64 ~ppc ~x86"

RDEPEND=""
DEPEND="${RDEPEND}
	amd64? ( dev-lang/yasm )
	x86? ( dev-lang/nasm )"

S=${WORKDIR}/${PN}

src_compile() {
	./configure --prefix=/usr \
		--libdir=/usr/$(get_libdir) \
		--enable-pic \
		$(use_enable debug) \
		$(use_enable threads pthread) \
		|| die "configure failed"
	emake -j1 || die "make failed"
}

src_install() {
	make DESTDIR="${D}" install || die
	dodoc AUTHORS TODO COPYING
}
