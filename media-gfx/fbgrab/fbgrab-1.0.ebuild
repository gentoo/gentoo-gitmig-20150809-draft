# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/fbgrab/fbgrab-1.0.ebuild,v 1.13 2011/03/31 20:20:13 ssuominen Exp $

EAPI=2
inherit eutils toolchain-funcs

DESCRIPTION="Framebuffer screenshot utility"
HOMEPAGE="http://hem.bredband.net/gmogmo/fbgrab/"
SRC_URI="http://hem.bredband.net/gmogmo/fbgrab/${PN}-1.0.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm ~hppa ppc ~sparc x86"
IUSE=""

RDEPEND="media-libs/libpng
	sys-libs/zlib"
DEPEND="${RDEPEND}"

S=${WORKDIR}/${PN}-1.0

src_prepare() {
	sed -i \
		-e "s:gcc :\$(CC) :" \
		-e "s:splint:#splint:" \
		-e "s:-Wall:-Wall ${CPPFLAGS} ${CFLAGS} ${LDFLAGS}:" \
		Makefile || die

	epatch "${FILESDIR}"/${P}-zlib_h.patch
}

src_compile() {
	emake CC="$(tc-getCC)" || die
}

src_install() {
	dobin fbgrab || die
	newman fbgrab.1.man fbgrab.1
}
