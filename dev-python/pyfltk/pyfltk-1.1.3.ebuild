# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pyfltk/pyfltk-1.1.3.ebuild,v 1.1 2009/01/09 23:35:04 bicatali Exp $

EAPI=2

inherit eutils distutils

MY_P=pyFltk-${PV}

DESCRIPTION="Python interface to Fltk library"
HOMEPAGE="http://pyfltk.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.gz
	doc? ( http://junk.mikeasoft.com/pyfltkmanual.pdf )"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="doc opengl"

DEPEND="dev-lang/swig
	>=x11-libs/fltk-1.1.9:1.1[opengl]"

RDEPEND=">=x11-libs/fltk-1.1.9:1.1[opengl]"

S="${WORKDIR}/${MY_P}"

DOCS="CHANGES"

src_prepare() {
	distutils_python_version
	[[ "${PYVER}" != 2.4 ]] && epatch "${FILESDIR}"/${PN}-1.1.2-python25.patch
	rm -f python/fltk*
	# move docs because the swig stuff will remove them
	use doc && cp -r fltk fltk.docs
}

src_compile() {
	cd "${S}"/python
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
