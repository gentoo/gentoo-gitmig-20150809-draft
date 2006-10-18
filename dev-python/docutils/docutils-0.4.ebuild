# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/docutils/docutils-0.4.ebuild,v 1.6 2006/10/18 13:34:40 uberlord Exp $

inherit distutils eutils elisp-common

DESCRIPTION="Set of python tools for processing plaintext docs into HTML, XML, etc."
HOMEPAGE="http://docutils.sourceforge.net/"
SRC_URI="mirror://sourceforge/docutils/${P}.tar.gz
	glep? ( mirror://gentoo/glep-${PV}.tbz2 )"

LICENSE="public-domain PYTHON BSD"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc-macos ~ppc64 ~s390 ~sh ~sparc ~sparc-fbsd ~x86 ~x86-fbsd"
IUSE="glep emacs"
DEPEND=">=dev-lang/python-2.3
	emacs? ( virtual/emacs )"

EMP=${PN}-0.3.7
SITEFILE=50docutils-0.4-gentoo.el

GLEP_SRC=${WORKDIR}/glep-${PV}

src_unpack() {
	unpack ${A}
	# simplified algorithm to select installing optparse and textwrap
	cd ${S}
	epatch ${FILESDIR}/${EMP}-extramodules.patch
}

src_compile() {
	distutils_src_compile

	# Generate html docs from reStructured text sources.

	# make roman.py available for the doc building process
	ln -s extras/roman.py

	pushd tools

	# Place html4css1.css in base directory. This makes sure the
	# generated reference to it is correct.
	cp ../docutils/writers/html4css1/html4css1.css ..

	PYTHONPATH=.. ${python} ./buildhtml.py --stylesheet-path=../html4css1.css --traceback .. \
		|| die "buildhtml"

	popd

	# clean up after the doc building
	rm roman.py html4css1.css

	if use emacs; then
		pushd tools/editors/emacs; elisp-compile *.el; popd
	fi
}


install_txt_doc() {
	local doc=${1}
	local dir="txt/$(dirname ${doc})"
	docinto ${dir}
	dodoc ${doc}
}

src_test() {
	cd ${S}/test
	PYTHONPATH="${S}" ./alltests.py || die "alltests.py failed"
}

src_install() {
	cd ${S}
	mydoc="*.txt"
	distutils_src_install
	# Tools
	cd ${S}/tools
	for tool in *.py
	do
		dobin ${tool}
	done
	# Docs
	cd ${S}
	dohtml -r docs spec tools
	# manually install the stylesheet file
	insinto /usr/share/doc/${PF}/html
	doins docutils/writers/html4css1/html4css1.css
	for doc in $(find docs spec tools -name '*.txt')
	do
		install_txt_doc $doc
	done

	# installing Gentoo GLEP tools. Uses versioned GLEP distribution
	if use glep
	then
		distutils_python_version
		dobin ${GLEP_SRC}/glep.py || die "newbin failed"
		insinto /usr/lib/python${PYVER}/site-packages/docutils/readers
		newins ${GLEP_SRC}/glepread.py glep.py || die "newins reader failed"
		insinto /usr/lib/python${PYVER}/site-packages/docutils/transforms
		newins ${GLEP_SRC}/glepstrans.py gleps.py || "newins transform failed"
		insinto /usr/lib/python${PYVER}/site-packages/docutils/writers
		doins -r ${GLEP_SRC}/glep_html || die "doins writer failed"
	fi

	if use emacs; then
		elisp-install ${PN} tools/editors/emacs/*.{elc,el}
		elisp-site-file-install ${FILESDIR}/${SITEFILE}
	fi
}

pkg_postinst() {
	use emacs && elisp-site-regen
	distutils_pkg_postinst
}

pkg_postrm() {
	use emacs && elisp-site-regen
	distutils_pkg_postrm
}
