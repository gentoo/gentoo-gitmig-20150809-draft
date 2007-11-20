# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pythonmagick/pythonmagick-0.7.ebuild,v 1.1 2007/11/20 01:03:38 hawking Exp $

inherit eutils python multilib toolchain-funcs

MY_PN=PythonMagick
MY_P=${MY_PN}-${PV}

DESCRIPTION="Python bindings for ImageMagick"
HOMEPAGE="http://www.imagemagick.org/script/api.php"
SRC_URI="http://www.imagemagick.org/download/python/${MY_P}.tar.gz"

SLOT="0"
LICENSE="as-is"
KEYWORDS="~x86"
IUSE=""

RDEPEND=">=media-gfx/imagemagick-1.1.7
		>=dev-libs/boost-1.34.0"
DEPEND="${RDEPEND}
		dev-util/scons"

S=${WORKDIR}/${MY_P}

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${PN}-0.6-gentoo_misc_fixes.patch"
}

src_compile() {
	python_version
	sed -i \
		-e "s#\(BOOST\)=.*#\1='/usr/include/boost'#" \
		-e "s#\(BOOSTLIBPATH\)=.*#\1='/usr/lib'#" \
		-e "s#\(PYTHON_INCLUDE\)=.*#\1='/usr/include/python${PYVER}'#" \
		-e "s#\(Environment(\)#\1 CXX='$(tc-getCXX)',#" \
		-e "s#\(CPPFLAGS\)=#\1='${CXXFLAGS}'.split()+#" \
		SConstruct || die "sed failed"

	# FIXME: Until we have a var or function for it
	numjobs=$(sed -e 's/.*\(\-j[ 0-9]\+\) .*/\1/' <<< ${MAKEOPTS})

	scons mode=release ${numjobs} || die "scons failed"
}

src_install() {
	insinto /usr/lib/python${PYVER}/site-packages
	doins -r PythonMagick
}

pkg_postinst() {
	python_version
	python_mod_optimize "${ROOT}"usr/$(get_libdir)/python${PYVER}/site-packages/${MY_PN}
}

pkg_postrm() {
	python_mod_cleanup
}
