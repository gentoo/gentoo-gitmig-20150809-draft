# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libjackasyn/libjackasyn-0.13.ebuild,v 1.3 2007/07/12 03:10:24 mr_bones_ Exp $

inherit eutils toolchain-funcs

IUSE="debug"

DESCRIPTION="An application/library for connecting OSS apps to Jackit."
HOMEPAGE="http://gige.xdv.org/soft/libjackasyn"
SRC_URI="http://gige.xdv.org/soft/libjackasyn/download/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~sparc ~x86"

DEPEND="media-sound/jack-audio-connection-kit
	media-libs/libsamplerate"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch "${FILESDIR}/${P}-qa.patch"
	epatch "${FILESDIR}/${P}-pic.patch"
	epatch "${FILESDIR}/${P}-libdir.patch"
	epatch "${FILESDIR}/${P}-execprefix.patch"
}

src_compile() {
	local myconf
	use debug && myconf="--enable-debug"
	econf ${myconf} || die
	emake CC=$(tc-getCC) CFLAGS="${CFLAGS}" || die
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS CHANGELOG WORKING TODO README
}
