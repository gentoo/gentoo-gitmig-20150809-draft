# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-zope/documenttemplate/documenttemplate-2.13.1.ebuild,v 1.4 2011/01/13 22:24:39 xarthisius Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.* *-jython"
# DISTUTILS_SRC_TEST="nosetests"

inherit distutils

MY_PN="DocumentTemplate"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Document Templating Markup Language (DTML)"
HOMEPAGE="http://pypi.python.org/pypi/DocumentTemplate"
SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_P}.zip"

LICENSE="ZPL"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ppc ~sparc ~x86"
IUSE=""

RDEPEND="dev-python/restrictedpython
	net-zope/accesscontrol
	net-zope/acquisition
	net-zope/extensionclass
	net-zope/zexceptions
	net-zope/zope-sequencesort
	net-zope/zope-structuredtext"
DEPEND="${RDEPEND}
	app-arch/unzip
	dev-python/setuptools"

# Tests are broken.
RESTRICT="test"

S="${WORKDIR}/${MY_P}"

DOCS="CHANGES.txt README.txt"
PYTHON_MODNAME="DocumentTemplate TreeDisplay"

src_prepare() {
	distutils_src_prepare

	# Disable broken tests.
	rm -f src/DocumentTemplate/sequence/tests/testSequence.py
	sed \
		-e "s/test_fmt_reST_include_directive_raises/_&/" \
		-e "s/test_fmt_reST_raw_directive_disabled/_&/" \
		-e "s/test_fmt_reST_raw_directive_file_option_raises/_&/" \
		-e "s/test_fmt_reST_raw_directive_url_option_raises/_&/" \
		-i src/DocumentTemplate/tests/testDTML.py || die "sed failed"
}

distutils_src_test_pre_hook() {
	local module
	for module in DocumentTemplate; do
		ln -fs "../../$(ls -d build-${PYTHON_ABI}/lib.*)/${module}/c${module}.so" "src/${module}/c${module}.so" || die "Symlinking ${module}/c${module}.so failed with Python ${PYTHON_ABI}"
	done
}

src_install() {
	distutils_src_install
	python_clean_installation_image

	delete_tests() {
		rm -fr "${ED}$(python_get_sitedir)/DocumentTemplate/sequence/tests"
		rm -fr "${ED}$(python_get_sitedir)/DocumentTemplate/tests"
	}
	python_execute_function -q delete_tests
}
