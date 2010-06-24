# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pyfltk/pyfltk-1.1.5.ebuild,v 1.3 2010/06/24 11:17:14 angelos Exp $

EAPI="2"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"

inherit eutils distutils

MY_P="pyFltk-${PV}"

DESCRIPTION="Python interface to Fltk library"
HOMEPAGE="http://pyfltk.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.gz
	doc? ( http://junk.mikeasoft.com/pyfltkmanual.pdf )"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc ~x86"
IUSE="doc"

RDEPEND=">=x11-libs/fltk-1.1.9:1.1[opengl]"
DEPEND="${RDEPEND}
	dev-lang/swig"
RESTRICT_PYTHON_ABIS="3.*"

S="${WORKDIR}/${MY_P}"

DOCS="CHANGES"

PYTHON_MODNAME="fltk"

src_prepare() {
	rm -f python/fltk*
	# move docs because the swig stuff will remove them
	use doc && cp -r fltk fltk.docs
}

src_compile() {
	pushd python > /dev/null
	"$(PYTHON -f)" MakeSwig.py || die "swigging wrappers failed"
	popd > /dev/null

	distutils_src_compile
}

src_install() {
	distutils_src_install --install-data /usr/share/doc/${PF}
	if use doc; then
		insinto /usr/share/doc/${PF}
		doins "${DISTDIR}"/pyfltkmanual.pdf || die
		dohtml fltk.docs/docs/* || die
		doins -r fltk.docs/test || die
	fi
}
