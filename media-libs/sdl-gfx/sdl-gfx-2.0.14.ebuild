# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/sdl-gfx/sdl-gfx-2.0.14.ebuild,v 1.2 2006/12/25 07:05:27 nyhm Exp $

inherit eutils flag-o-matic

MY_P="${P/sdl-/SDL_}"
DESCRIPTION="Graphics drawing primitives library for SDL"
HOMEPAGE="http://www.ferzkopp.net/~aschiffler/Software/SDL_gfx-2.0/index.html"
SRC_URI="http://www.ferzkopp.net/~aschiffler/Software/SDL_gfx-2.0/${MY_P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~sparc ~x86"
IUSE="mmx"

DEPEND=">=media-libs/libsdl-1.2"

S=${WORKDIR}/${MY_P}

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-gcc34.patch
}

src_compile() {
	filter-flags -finline-functions -funroll-loops #26892 #89749
	replace-flags -O? -O2

	econf \
		--disable-dependency-tracking \
		$(use_enable mmx) || die
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS ChangeLog README
	dohtml -r Docs/*
}

pkg_postinst() {
	ewarn "If you upgraded from sdl-gfx-2.0.13-r1 or earlier, please run"
	ewarn "\"revdep-rebuild\" from app-portage/gentoolkit"
}
