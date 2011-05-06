# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/pianobar/pianobar-2011.04.27.ebuild,v 1.1 2011/05/06 08:19:33 radhermit Exp $

EAPI=4

inherit toolchain-funcs flag-o-matic eutils

DESCRIPTION="A console-based replacement for Pandora's flash player"
HOMEPAGE="http://6xq.net/html/00/17.html"
SRC_URI="http://6xq.net/media/00/16/${P}.tar.bz2"

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
	epatch "${FILESDIR}"/${P}-linking.patch
}

src_compile() {
	local myconf=""
	! use aac && myconf+=" DISABLE_FAAD=1"
	! use mp3 && myconf+=" DISABLE_MAD=1"

	append-cflags -std=c99
	emake CC=$(tc-getCC) CFLAGS="${CFLAGS}" LDFLAGS="${LDFLAGS}" ${myconf}
}

src_install() {
	emake DESTDIR="${D}" PREFIX=/usr install
	dodoc ChangeLog README

	insinto /usr/share/doc/${PF}/contrib
	doins -r contrib/{config-example,*.sh,eventcmd-examples}
	docompress -x /usr/share/doc/${PF}/contrib
}
