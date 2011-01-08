# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/scikits_learn/scikits_learn-0.6.ebuild,v 1.1 2011/01/08 19:22:56 bicatali Exp $

EAPI="3"

PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"

inherit distutils

MY_P="${P/scikits_/scikits.}"

DESCRIPTION="A set of python modules for machine learning and data mining"
HOMEPAGE="http://scikits-learn.sourceforge.net/"
SRC_URI="mirror://sourceforge/scikit-learn/${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc examples test"

CDEPEND="sci-libs/scipy
	>=sci-libs/libsvm-2.91"
RDEPEND="${CDEPEND}
	sci-libs/scikits
	dev-python/matplotlib"
DEPEND="${CDEPEND}
	dev-python/cython
	dev-python/setuptools
	doc? ( dev-python/sphinx dev-python/matplotlib )"

S="${WORKDIR}/${MY_P}"

src_prepare() {
	# use stock libsvm
	cat <<-EOF >> site.cfg
		[libsvm]
		libraries=svm
		library_dirs=${EPREFIX}/usr/$(get_libdir)
		include_dirs=${EPREFIX}/usr/include/libsvm-2.0/libsvm
	EOF
}

src_compile() {
	distutils_src_compile
	if use doc; then
		cd "${S}/doc"
		export VARTEXFONTS="${T}"/fonts
		MPLCONFIGDIR="${S}/build-$(PYTHON -f --ABI)" \
			PYTHONPATH=$(ls -d "${S}"/build-$(PYTHON -f --ABI)/lib*) \
			emake html latex || die
	fi
}

src_install() {
	find "${S}" -name \*LICENSE.txt -delete
	distutils_src_install
	remove_scikits() {
		rm -f "${ED}"$(python_get_sitedir)/scikits/__init__.py || die
	}
	python_execute_function -q remove_scikits
	insinto /usr/share/doc/${PF}
	if use doc; then
		doins "${DISTDIR}"/scikits.learn.pdf || die
		doins -r build/sphinx/html || die
	fi
	if use examples; then
		doins -r examples || die
	fi
}
