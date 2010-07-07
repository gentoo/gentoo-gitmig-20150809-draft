# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/docutils/docutils-0.7.ebuild,v 1.1 2010/07/07 19:57:50 arfrever Exp $

EAPI="3"
SUPPORT_PYTHON_ABIS="1"

inherit distutils eutils

DESCRIPTION="Set of python tools for processing plaintext docs into HTML, XML, etc..."
HOMEPAGE="http://docutils.sourceforge.net/ http://pypi.python.org/pypi/docutils"
SRC_URI="mirror://sourceforge/docutils/${P}.tar.gz
	glep? ( mirror://gentoo/glep-0.4-r1.tbz2 )"

LICENSE="public-domain PYTHON BSD"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~sparc-fbsd ~x86-fbsd ~x86-freebsd ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris ~x86-solaris"
IUSE="glep emacs"

DEPEND="dev-python/setuptools"
RDEPEND=""
# Emacs support is in PDEPEND to avoid a dependency cycle (bug #183242)
PDEPEND="emacs? ( || ( >=app-emacs/rst-0.4 >=virtual/emacs-23 ) )"

DOCS="*.txt"

GLEP_SRC="${WORKDIR}/glep-0.4-r1"

src_prepare() {
	# Delete internal copies of optparse and textwrap modules.
	rm -f extras/{optparse.py,textwrap.py}

	# Fix installation of extra modules.
	epatch "${FILESDIR}/${PN}-0.6-extra_modules.patch"

	sed -e "s/from distutils.core/from setuptools/" -i setup.py || die "sed setup.py failed"
}

src_compile() {
	distutils_src_compile

	# Generate html docs from reStructured text sources.

	# Make roman.py available for the doc building process
	ln -s extras/roman.py

	# Place html4css1.css in base directory. This makes sure the
	# generated reference to it is correct.
	cp docutils/writers/html4css1/html4css1.css .

	pushd tools > /dev/null

	echo PYTHONPATH="../build-$(PYTHON -f --ABI)/lib" "$(PYTHON -f)" $([[ -f ../build-$(PYTHON -f --ABI)/lib/tools/buildhtml.py ]] && echo ../build-$(PYTHON -f --ABI)/lib/tools/buildhtml.py || echo ../tools/buildhtml.py) --stylesheet-path=../html4css1.css --traceback ..
	PYTHONPATH="../build-$(PYTHON -f --ABI)/lib" "$(PYTHON -f)" $([[ -f ../build-$(PYTHON -f --ABI)/lib/tools/buildhtml.py ]] && echo ../build-$(PYTHON -f --ABI)/lib/tools/buildhtml.py || echo ../tools/buildhtml.py) --stylesheet-path=../html4css1.css --traceback .. || die "buildhtml.py failed"

	popd > /dev/null

	# Clean up after the doc building.
	rm roman.py html4css1.css
}

src_test() {
	testing() {
		echo PYTHONPATH="build-${PYTHON_ABI}/lib" "$(PYTHON)" $([[ -f build-${PYTHON_ABI}/lib/test/alltests.py ]] && echo build-${PYTHON_ABI}/lib/test/alltests.py || echo test/alltests.py)
		PYTHONPATH="build-${PYTHON_ABI}/lib" "$(PYTHON)" $([[ -f build-${PYTHON_ABI}/lib/test/alltests.py ]] && echo build-${PYTHON_ABI}/lib/test/alltests.py || echo test/alltests.py)
	}
	python_execute_function testing
}

install_txt_doc() {
	local doc="${1}"
	local dir="txt/$(dirname ${doc})"
	docinto "${dir}"
	dodoc "${doc}"
}

src_install() {
	distutils_src_install

	# Tools
	cd tools
	local tool
	for tool in *.py; do
		dobin "${tool}"
	done

	# Docs
	cd "${S}"
	dohtml -r docs tools
	# Manually install the stylesheet file
	insinto /usr/share/doc/${PF}/html
	doins docutils/writers/html4css1/html4css1.css
	local doc
	for doc in $(find docs tools -name "*.txt"); do
		install_txt_doc "${doc}"
	done

	# installing Gentoo GLEP tools. Uses versioned GLEP distribution
	if use glep; then
		dobin ${GLEP_SRC}/glep.py || die "dobin failed"

		installation_of_glep_tools() {
			insinto $(python_get_sitedir)/docutils/readers
			newins ${GLEP_SRC}/glepread.py glep.py || die "newins reader failed"
			insinto $(python_get_sitedir)/docutils/transforms
			newins ${GLEP_SRC}/glepstrans.py gleps.py || die "newins transform failed"
			insinto $(python_get_sitedir)/docutils/writers
			doins -r ${GLEP_SRC}/glep_html || die "doins writer failed"
		}
		python_execute_function --action-message 'Installation of GLEP tools with $(python_get_implementation) $(python_get_version)...' installation_of_glep_tools
	fi
}

pkg_postinst() {
	python_mod_optimize docutils roman.py
}

pkg_postrm() {
	python_mod_cleanup docutils roman.py
}
