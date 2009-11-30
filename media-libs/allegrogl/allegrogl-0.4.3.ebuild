# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/allegrogl/allegrogl-0.4.3.ebuild,v 1.7 2009/11/30 14:25:25 volkmar Exp $

MY_PN="alleggl"
DESCRIPTION="A library to mix OpenGL graphics with Allegro routines"
HOMEPAGE="http://allegrogl.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${MY_PN}-${PV}.tar.bz2"

LICENSE="ZLIB"
SLOT="0"
KEYWORDS="amd64 ~ppc ~sparc x86"
IUSE="examples"

RDEPEND=">=media-libs/allegro-4.2
	virtual/opengl
	virtual/glu"
DEPEND="${RDEPEND}
	x11-proto/xf86vidmodeproto"

S=${WORKDIR}/${MY_PN}

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i 's:-Wl:${LDFLAGS} -Wl:' configure || die "sed failed"
}

src_compile() {
	econf || die
	emake CFLAGS="${CFLAGS}" lib || die "emake failed"
}

src_install() {
	emake LDCONFIG=/bin/true DESTDIR="${D}" install || die "emake install failed"
	dodoc changelog {bugs,extensions,faq,howto,quickstart,readme,todo}.txt
	dohtml -r docs/html/*
	if use examples ; then
		insinto /usr/share/doc/${PF}/examples
		doins examp/*.{bmp,c,dat,h,pcx,tga} || die "doins failed"
	fi
}
