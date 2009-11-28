# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pythonmagick/pythonmagick-0.9.1.ebuild,v 1.4 2009/11/28 15:19:36 josejx Exp $

EAPI=2
inherit python flag-o-matic

MY_PN=PythonMagick
MY_P=${MY_PN}-${PV}

DESCRIPTION="Python bindings for ImageMagick"
HOMEPAGE="http://www.imagemagick.org/script/api.php"
SRC_URI="http://www.imagemagick.org/download/python/${MY_P}.tar.gz"

SLOT="0"
LICENSE="GPL-3"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

RDEPEND=">=media-gfx/imagemagick-6.4
	>=dev-libs/boost-1.35.0[python]"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

PYTHON_MODNAME="${MY_PN}"
S="${WORKDIR}/${MY_P}"

pkg_setup() {
	append-flags $(python-config --includes)
	export BOOST_PYTHON_LIB=boost_python
}

src_install() {
	python_need_rebuild
	emake DESTDIR="${D}" install || die "emake install failed"
}
