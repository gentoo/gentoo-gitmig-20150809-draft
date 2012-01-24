# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/scikits_learn/scikits_learn-0.9.ebuild,v 1.3 2012/01/24 10:28:17 jlec Exp $

EAPI="3"
inherit flag-o-matic

PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"
DISTUTILS_SRC_TEST="setup.py"

inherit distutils

MYPN="${PN/scikits_/scikit-}"

DESCRIPTION="A set of python modules for machine learning and data mining"
HOMEPAGE="http://scikit-learn.org"
SRC_URI="mirror://sourceforge/${MYPN}/${MYPN}-${PV}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE="doc examples"

CDEPEND="sci-libs/scipy
	>=sci-libs/libsvm-2.91"
RDEPEND="${CDEPEND}
	sci-libs/scikits
	dev-python/matplotlib"
DEPEND="${CDEPEND}
	dev-python/cython
	dev-python/setuptools
	doc? ( dev-python/sphinx dev-python/matplotlib )"

S="${WORKDIR}/${MYPN}-${PV}"

src_prepare() {
	# use stock libsvm
	cat <<-EOF >> site.cfg
		[libsvm]
		libraries=svm
		library_dirs=${EPREFIX}/usr/$(get_libdir)
		include_dirs=${EPREFIX}/usr/include/
	EOF
	# bug #397605
	[[ ${CHOST} == *-darwin* ]] \
		&& append-ldflags -bundle "-undefined dynamic_lookup" \
		|| append-ldflags -shared
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
