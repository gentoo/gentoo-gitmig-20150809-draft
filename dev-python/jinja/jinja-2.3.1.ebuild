# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/jinja/jinja-2.3.1.ebuild,v 1.3 2010/08/18 09:53:34 djc Exp $

EAPI="2"
SUPPORT_PYTHON_ABIS="1"
DISTUTILS_SRC_TEST="setup.py"

inherit distutils eutils

MY_PN="Jinja2"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="A small but fast and easy to use stand-alone template engine written in pure python."
HOMEPAGE="http://jinja.pocoo.org/ http://pypi.python.org/pypi/Jinja2"
SRC_URI="mirror://pypi/J/${MY_PN}/${MY_P}.tar.gz"
LICENSE="BSD"
KEYWORDS="alpha amd64 arm hppa ia64 ppc ppc64 s390 sh sparc x86 ~x86-fbsd ~amd64-linux ~ia64-linux ~x86-linux ~x86-macos"
SLOT="0"
IUSE="doc examples i18n test"

CDEPEND="dev-python/setuptools"
DEPEND="${CDEPEND}
	doc? ( >=dev-python/sphinx-0.6 )"
RDEPEND="${CDEPEND}
	i18n? ( >=dev-python/Babel-0.9.3 )"

S="${WORKDIR}/${MY_P}"

DISTUTILS_GLOBAL_OPTIONS=("--with-speedups")
DOCS="CHANGES"
PYTHON_MODNAME="jinja2"

src_prepare() {
	distutils_src_prepare

	epatch "${FILESDIR}/jinja2-2.3.1-python-3.patch"
	epatch "${FILESDIR}/jinja2-2.3.1-python-3.2.patch"
}

src_compile(){
	distutils_src_compile

	if use doc; then
		cd "${S}/docs"
		PYTHONPATH=.. emake html || die "Building of documentation failed"
	fi
}

src_install(){
	distutils_src_install

	# Don't install C sources.
	find "${D}"usr/$(get_libdir)/python*/site-packages -name "*.c" | xargs rm -f

	if use doc; then
		dohtml -r docs/_build/html/* || die "Installation of documentation failed"
	fi

	if use examples; then
		# Eliminate .pyc files going into /usr/share
	    find examples -name "*.pyc" -print0 | xargs -0 rm -fr

		insinto "/usr/share/doc/${PF}"
		doins -r examples || die "Failed to install examples"
	fi
}
