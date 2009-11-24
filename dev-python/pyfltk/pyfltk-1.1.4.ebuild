# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pyfltk/pyfltk-1.1.4.ebuild,v 1.6 2009/11/24 00:03:53 bicatali Exp $

EAPI="2"
SUPPORT_PYTHON_ABIS="1"

inherit eutils distutils

MY_P="pyFltk-${PV}"

DESCRIPTION="Python interface to Fltk library"
HOMEPAGE="http://pyfltk.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.gz
	doc? ( http://junk.mikeasoft.com/pyfltkmanual.pdf )"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE="doc"

RDEPEND=">=x11-libs/fltk-1.1.9:1.1[opengl]"
DEPEND="${RDEPEND}
	dev-lang/swig"

RESTRICT_PYTHON_ABIS="3*"

PYTHON_MODNAME="fltk"

S="${WORKDIR}/${MY_P}"

DOCS="CHANGES"

src_prepare() {
	rm -f python/fltk*
	# move docs because the swig stuff will remove them
	use doc && cp -r fltk fltk.docs
}

src_compile() {
	cd "${S}"/python
	${python} MakeSwig.py || die "swigging wrappers failed"
	cd "${S}"
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
