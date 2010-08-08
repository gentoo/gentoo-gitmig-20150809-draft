# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/ftgl/ftgl-2.1.3_rc5.ebuild,v 1.11 2010/08/08 16:02:39 armin76 Exp $

inherit eutils flag-o-matic autotools

MY_PV=${PV/_/-}
MY_PV2=${PV/_/\~}
MY_P=${PN}-${MY_PV}
MY_P2=${PN}-${MY_PV2}

DESCRIPTION="library to use arbitrary fonts in OpenGL applications"
HOMEPAGE="http://ftgl.wiki.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.bz2"

LICENSE="MIT"
SLOT="0"
KEYWORDS="alpha amd64 ~arm hppa ~ia64 ~mips ppc ppc64 sparc x86 ~x86-fbsd"
IUSE=""

DEPEND=">=media-libs/freetype-2.0.9
	virtual/opengl
	virtual/glu
	virtual/glut"

S=${WORKDIR}/${MY_P2}

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-gentoo.patch
	AT_M4DIR=m4 eautoreconf
}

src_compile() {
	strip-flags # ftgl is sensitive - bug #112820
	econf
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	rm -rf "${D}"/usr/share/doc/ftgl
	dodoc AUTHORS BUGS ChangeLog INSTALL NEWS README TODO \
		docs/projects_using_ftgl.txt
}
