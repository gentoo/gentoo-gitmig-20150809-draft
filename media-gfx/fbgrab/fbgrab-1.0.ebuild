# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/fbgrab/fbgrab-1.0.ebuild,v 1.11 2008/05/18 19:23:25 solar Exp $

inherit toolchain-funcs

DESCRIPTION="Framebuffer screenshot utility"
HOMEPAGE="http://hem.bredband.net/gmogmo/fbgrab/"
SRC_URI="http://hem.bredband.net/gmogmo/fbgrab/${PN}-1.0.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~arm amd64 ~hppa ppc ~sparc x86"
IUSE=""

DEPEND="media-libs/libpng"

S=${WORKDIR}/${PN}-1.0

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i \
		-e "s:gcc :\$(CC) :" \
		-e "s:splint:#splint:" \
		-e "s:-Wall:-Wall ${CPPFLAGS} ${CFLAGS} ${LDFLAGS}:" \
		Makefile
}

src_compile() {
	tc-export CC
	emake CC="${CC}" || die
}

src_install() {
	dobin fbgrab || die
	newman fbgrab.1.man fbgrab.1
}
