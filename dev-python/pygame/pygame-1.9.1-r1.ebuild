# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pygame/pygame-1.9.1-r1.ebuild,v 1.1 2011/03/31 17:05:45 ssuominen Exp $

EAPI="2"
SUPPORT_PYTHON_ABIS="1"

inherit distutils eutils multilib

DESCRIPTION="python bindings to sdl and other libs that facilitate game production"
HOMEPAGE="http://www.pygame.org/"
SRC_URI="http://www.pygame.org/ftp/pygame-${PV}release.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~sparc ~x86 ~x86-fbsd"
IUSE="doc examples X"

RDEPEND=">=media-libs/libsdl-1.2.5[X?]
	>=media-libs/sdl-ttf-2.0.6
	>=media-libs/sdl-image-1.2.2[png,jpeg]
	>=media-libs/sdl-mixer-1.2.4
	dev-python/numpy
	>=media-libs/smpeg-0.4.4-r1"
DEPEND="${RDEPEND}"

S=${WORKDIR}/${P}release

DOCS="WHATSNEW"

src_prepare() {
	distutils_src_prepare
	epatch \
		"${FILESDIR}"/config.patch \
		"${FILESDIR}"/${P}-linux-headers-2.6.38.patch
}

src_configure() {
	"$(PYTHON -f)" config.py -auto
	sed -i -e 's:X11R6/lib:lib64:g' Setup
	use X || sed -i -e 's:scrap :#scrap :' Setup
}

src_test() {
	# Skip tests that depend on DISPLAY being set. Bug #223055.
	SKIP_TESTS="display_test image__save_gl_surface_test movie_test"

	local test
	for test in ${SKIP_TESTS}; do
		einfo "Removing test: ${test}"
		rm -fr "${S}/test/${test}.py"
	done

	testing() {
		PYTHONPATH="$(ls -d build-${PYTHON_ABI}/lib.*)" "$(PYTHON)" run_tests.py
	}
	python_execute_function testing
}

src_install() {
	distutils_src_install
	rm -fr "${D}"usr/lib*/python*/site-packages/pygame/examples

	if use doc; then
		dohtml -r docs/*
	fi

	if use examples; then
		insinto /usr/share/doc/${PF}
		doins -r "${S}/examples"
	fi
}
