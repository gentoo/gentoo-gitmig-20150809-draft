# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pygame/pygame-1.8.1.ebuild,v 1.8 2008/12/11 19:37:32 klausman Exp $

inherit distutils multilib eutils

DESCRIPTION="python bindings to sdl and other libs that facilitate game production"
HOMEPAGE="http://www.pygame.org/"
SRC_URI="http://www.pygame.org/ftp/pygame-${PV}release.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="alpha amd64 hppa ~ia64 ppc ~sparc x86 ~x86-fbsd"
IUSE="doc"

RDEPEND=">=media-libs/libsdl-1.2.5
	>=media-libs/sdl-ttf-2.0.6
	>=media-libs/sdl-image-1.2.2
	>=media-libs/sdl-mixer-1.2.4
	dev-python/numpy
	>=media-libs/smpeg-0.4.4-r1"
DEPEND="${RDEPEND}
	dev-python/setuptools"

S=${WORKDIR}/${P}release

pkg_setup() {
	if ! built_with_use media-libs/libsdl X ; then
		eerror "Please re-emerge media-libs/libsdl with the X USE-flag set."
		die "Missing USE-flag for media-libs/libsdl"
	fi
	if ! built_with_use media-libs/sdl-image png jpeg ; then
		eerror "Please re-emerge media-libs/sdl-image with the png and jpeg
		USE-flags set."
		die "Missing USE-flag for media-libs/sdl-image"
	fi
}

src_compile() {
	python config.py
	sed -i -e 's:X11R6/lib:lib64:g' Setup

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
	PYTHONPATH="$(ls -d build/lib.*)" "${python}" run_tests.py || die "tests failed"
}
