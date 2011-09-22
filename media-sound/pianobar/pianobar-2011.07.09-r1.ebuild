# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/pianobar/pianobar-2011.07.09-r1.ebuild,v 1.1 2011/09/22 05:57:02 radhermit Exp $

EAPI=4

inherit toolchain-funcs flag-o-matic eutils

DESCRIPTION="A console-based replacement for Pandora's flash player"
HOMEPAGE="http://6xq.net/projects/pianobar/"
SRC_URI="http://6xq.net/static/projects/${PN}/${P}.tar.bz2"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="aac +mp3"

DEPEND="media-libs/libao
	aac? ( media-libs/faad2 )
	mp3? ( media-libs/libmad )"
RDEPEND="${DEPEND}"

REQUIRED_USE="|| ( mp3 aac )"

src_prepare() {
	epatch "${FILESDIR}"/${P}-tests.patch \
		"${FILESDIR}"/${P}-protocol-bump.patch
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
