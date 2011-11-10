# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/pianobar/pianobar-2011.11.09_p1.ebuild,v 1.1 2011/11/10 00:26:23 radhermit Exp $

EAPI=4

inherit toolchain-funcs flag-o-matic eutils

DESCRIPTION="A console-based replacement for Pandora's flash player"
HOMEPAGE="http://6xq.net/projects/pianobar/"
SRC_URI="http://dev.gentoo.org/~radhermit/distfiles/${P}.tar.bz2"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="aac +mp3"

DEPEND="media-libs/libao
	net-libs/gnutls
	aac? ( media-libs/faad2 )
	mp3? ( media-libs/libmad )"
RDEPEND="${DEPEND}"

REQUIRED_USE="|| ( mp3 aac )"

src_prepare() {
	epatch "${FILESDIR}"/${P}-tests.patch
}

src_compile() {
	local myconf=""
	! use aac && myconf+=" DISABLE_FAAD=1"
	! use mp3 && myconf+=" DISABLE_MAD=1"

	append-cflags -std=c99
	tc-export CC
	emake ${myconf}
}

src_test() {
	cp src/libwaitress/waitress.c src/libwaitress/waitress-test.c
	emake test
}

src_install() {
	emake DESTDIR="${D}" PREFIX=/usr install
	dodoc ChangeLog README

	docinto contrib
	dodoc -r contrib/{config-example,*.sh,eventcmd-examples}
	docompress -x /usr/share/doc/${PF}/contrib
}
