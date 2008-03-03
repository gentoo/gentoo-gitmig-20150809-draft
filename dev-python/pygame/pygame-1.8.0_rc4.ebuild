# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pygame/pygame-1.8.0_rc4.ebuild,v 1.1 2008/03/03 13:44:25 dev-zero Exp $

inherit distutils

MY_P="${PN}-${PV/_}"

DESCRIPTION="python bindings to sdl and other libs that facilitate game production"
HOMEPAGE="http://www.pygame.org/"
SRC_URI="http://rene.f0o.com/~rene/stuff/${MY_P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~sparc ~x86 ~x86-fbsd"
IUSE="doc"

RDEPEND=">=media-libs/libsdl-1.2.5
	>=media-libs/sdl-ttf-2.0.6
	>=media-libs/sdl-image-1.2.2
	>=media-libs/sdl-mixer-1.2.4
	dev-python/numpy
	>=media-libs/smpeg-0.4.4-r1"
DEPEND="${DEPEND}
	dev-python/setuptools"

S="${WORKDIR}/${MY_P}"


src_unpack() {
	unpack ${A}
	# Search correct libdir for existing sdl libs
	sed -i -e "s:/lib:/$(get_libdir):" ${S}/config_unix.py || die
}

src_compile() {
	distutils_src_install

	# Copy missing icon-file
	cp lib/pygame_icon.bmp build/lib.*/pygame/
}

src_install() {
	DOCS=WHATSNEW
	distutils_src_install

	if use doc; then
		dohtml -r docs/*
		insinto /usr/share/doc/${PF}/examples
		doins ${S}/examples/*
		insinto /usr/share/doc/${PF}/examples/data
		doins ${S}/examples/data/*
	fi
}

src_test() {
	python_version
	PYTHONPATH="$(ls -d build/lib.*)" "${python}" run_tests.py || die "tests failed"
}
