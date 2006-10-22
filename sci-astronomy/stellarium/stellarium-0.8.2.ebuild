# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-astronomy/stellarium/stellarium-0.8.2.ebuild,v 1.2 2006/10/22 20:52:25 malc Exp $

inherit eutils flag-o-matic

DESCRIPTION="Stellarium renders 3D photo-realistic skies in real time."
HOMEPAGE="http://www.stellarium.org/"
SRC_URI="mirror://sourceforge/stellarium/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE="nls"

RDEPEND="virtual/opengl
	virtual/glu
	media-libs/libsdl
	media-libs/libpng
	media-libs/sdl-mixer
	media-libs/freetype
	nls? ( virtual/libintl )"
DEPEND="${RDEPEND}
	nls? ( sys-devel/gettext )
	|| ( x11-libs/libXt virtual/x11 )"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${P}-amd64.patch"
}


src_compile() {
	append-flags -fno-strict-aliasing
	econf \
		--disable-dependency-tracking \
		$(use_enable nls) \
		|| die
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	make_desktop_entry stellarium Stellarium
	dodoc AUTHORS ChangeLog README TODO
}
