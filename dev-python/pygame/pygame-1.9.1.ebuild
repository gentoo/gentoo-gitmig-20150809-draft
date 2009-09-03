# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pygame/pygame-1.9.1.ebuild,v 1.1 2009/09/03 12:28:09 patrick Exp $

EAPI="2"

inherit distutils multilib eutils

DESCRIPTION="python bindings to sdl and other libs that facilitate game production"
HOMEPAGE="http://www.pygame.org/"
SRC_URI="http://www.pygame.org/ftp/pygame-${PV}release.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~sparc ~x86 ~x86-fbsd"
IUSE="doc X"

RDEPEND=">=media-libs/libsdl-1.2.5[X?]
	>=media-libs/sdl-ttf-2.0.6
	>=media-libs/sdl-image-1.2.2[png,jpeg]
	>=media-libs/sdl-mixer-1.2.4
	dev-python/numpy
	>=media-libs/smpeg-0.4.4-r1"
DEPEND="${RDEPEND}
	dev-python/setuptools"

S=${WORKDIR}/${P}release

src_prepare() {
	epatch "${FILESDIR}/config.patch"
}

src_compile() {
	python config.py -auto
	sed -i -e 's:X11R6/lib:lib64:g' Setup
	use X || sed -i -e 's:scrap :#scrap :' Setup
	distutils_src_compile
}

src_install() {
	DOCS=WHATSNEW
	distutils_src_install

	if use doc; then
		dohtml -r docs/*

		insinto /usr/share/doc/${PF}
		doins -r "${S}/examples"
	fi
}

src_test() {
	python_version

	#Skip tests that depend on DISPLAY being set. Bug #223055
	SKIP_TESTS="display_test image__save_gl_surface_test movie_test"

	for test_ in $SKIP_TESTS
	do
		einfo "Removing test: ${test_}"
		rm -rf "${S}/test/${test_}.py"
	done

	PYTHONPATH="$(ls -d build/lib.*)" "${python}" run_tests.py || die "tests failed"
}
