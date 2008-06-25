# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pythonmagick/pythonmagick-0.7-r1.ebuild,v 1.1 2008/06/25 17:57:42 hawking Exp $

NEED_PYTHON=2.5
inherit python multilib toolchain-funcs

MY_PN=PythonMagick
MY_P=${MY_PN}-${PV}

DESCRIPTION="Python bindings for ImageMagick"
HOMEPAGE="http://www.imagemagick.org/script/api.php"
SRC_URI="http://www.imagemagick.org/download/python/${MY_P}.tar.gz"

SLOT="0"
LICENSE="as-is"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=media-gfx/imagemagick-6.2
		>=dev-libs/boost-1.34.0"
RDEPEND="${DEPEND}"

S=${WORKDIR}/${MY_P}

src_compile() {
	filter-ldflags -Wl,--as-needed --as-needed

	econf
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
}

pkg_postinst() {
	python_version
	python_mod_optimize /usr/$(get_libdir)/python${PYVER}/site-packages/${MY_PN}
}

pkg_postrm() {
	python_mod_cleanup /usr/$(get_libdir)/python*/site-packages/${MY_PN}
}
