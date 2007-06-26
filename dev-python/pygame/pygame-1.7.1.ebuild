# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pygame/pygame-1.7.1.ebuild,v 1.9 2007/06/26 07:20:27 opfer Exp $

inherit distutils

MY_P="${PN}-${PV}release"
S="${WORKDIR}/${MY_P}"

DESCRIPTION="python bindings to sdl and other libs that facilitate game production"
HOMEPAGE="http://www.pygame.org/"
SRC_URI="http://www.pygame.org/ftp/${MY_P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~alpha amd64 hppa ~ia64 ppc sparc x86 ~x86-fbsd"
IUSE="doc"

DEPEND="virtual/python
	>=media-libs/libsdl-1.2.5
	>=media-libs/sdl-ttf-2.0.6
	>=media-libs/sdl-image-1.2.2
	>=media-libs/sdl-mixer-1.2.4
	>=dev-python/numeric-22.0
	>=media-libs/smpeg-0.4.4-r1"

src_unpack() {
	unpack ${A}
	# Search correct libdir for existing sdl libs
	sed -i -e "s:/lib:/$(get_libdir):" ${S}/config_unix.py || die
}

src_install() {
	mydoc=WHATSNEW
	distutils_src_install

	if use doc; then
		dohtml -r docs/*
		insinto /usr/share/doc/${PF}/examples
		doins ${S}/examples/*
		insinto /usr/share/doc/${PF}/examples/data
		doins ${S}/examples/data/*
	fi
}
