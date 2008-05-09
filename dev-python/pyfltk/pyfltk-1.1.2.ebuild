# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pyfltk/pyfltk-1.1.2.ebuild,v 1.4 2008/05/09 20:02:51 maekke Exp $

inherit eutils distutils

MY_P=pyFltk-${PV}

DESCRIPTION="Python interface to Fltk library"
HOMEPAGE="http://pyfltk.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.gz
	doc? ( http://junk.mikeasoft.com/pyfltkmanual.pdf )"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc x86"
IUSE="doc opengl"

DEPEND=">=dev-lang/swig-1.3.29
	>=x11-libs/fltk-1.1.7"

RDEPEND=">=x11-libs/fltk-1.1.7"

S="${WORKDIR}/${MY_P}"

DOCS="CHANGES"

src_unpack() {
	unpack ${A}
	cd "${S}"
	distutils_python_version
	[[ "${PYVER}" == 2.5 ]] && epatch "${FILESDIR}"/${P}-python25.patch
	# move docs because the swig stuff will remove them
	use doc && cp -r fltk fltk.docs
}

src_compile() {
	cd python
	rm -f fltk*
	${python} MakeSwig.py || die "swigging wrappers failed"
	cd "${S}"
	distutils_src_compile \
		$(use opengl || echo "--disable-gl")
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
