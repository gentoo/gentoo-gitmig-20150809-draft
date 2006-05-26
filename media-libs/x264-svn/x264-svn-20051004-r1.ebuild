# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/x264-svn/x264-svn-20051004-r1.ebuild,v 1.5 2006/05/26 17:41:54 flameeyes Exp $

inherit multilib

IUSE="debug threads"

DESCRIPTION="A free libary for encoding X264/AVC streams."
HOMEPAGE="http://developers.videolan.org/x264.html"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~amd64"

RDEPEND=""
DEPEND="${RDEPEND}
	amd64? ( dev-lang/yasm )
	x86? ( dev-lang/nasm )"

S=${WORKDIR}/${PN}

src_compile() {
	./configure --prefix=/usr \
		--libdir=/usr/$(get_libdir) \
		$(use_enable debug) \
		$(use_enable threads pthread) \
		|| die "configure failed"
	emake -j1 || die "make failed"
}

src_install() {
	make DESTDIR="${D}" install || die
	dodoc AUTHORS TODO COPYING
}
