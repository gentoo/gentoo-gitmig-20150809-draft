# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/fbgrab/fbgrab-1.0.ebuild,v 1.7 2004/10/31 05:19:02 vapier Exp $

DESCRIPTION="Framebuffer screenshot utility"
HOMEPAGE="http://hem.bredband.net/gmogmo/fbgrab/"
SRC_URI="http://hem.bredband.net/gmogmo/fbgrab/${PN}-1.0.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~ppc ~sparc x86"
IUSE=""

DEPEND="media-libs/libpng"

S=${WORKDIR}/${PN}-1.0

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -i \
		-e "s:splint:#splint:" \
		-e "s:-Wall:-Wall ${CFLAGS}:" \
		Makefile
}

src_compile() {
	emake || die
}

src_install() {
	dobin fbgrab || die
	newman fbgrab.1.man fbgrab.1
}
