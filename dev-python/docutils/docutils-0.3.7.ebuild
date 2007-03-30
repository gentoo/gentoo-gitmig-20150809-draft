# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/docutils/docutils-0.3.7.ebuild,v 1.17 2007/03/30 19:07:38 grobian Exp $

inherit distutils eutils elisp-common multilib

DESCRIPTION="Set of python tools for processing plaintext docs into HTML, XML, etc."
HOMEPAGE="http://docutils.sourceforge.net/"
SRC_URI="mirror://sourceforge/docutils/${P}.tar.gz
	glep? ( mirror://gentoo/glep-${PV}.tbz2 )"

LICENSE="public-domain PYTHON BSD"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 m68k mips ppc ppc64 s390 sh sparc x86"
IUSE="glep emacs"
DEPEND=">=dev-lang/python-2.2
	emacs? ( virtual/emacs )"

SITEFILE=50docutils-gentoo.el

GLEP_SRC=${WORKDIR}/glep-${PV}

src_unpack() {
	unpack ${A}
	# simplified algorithm to select installing optparse and textwrap
	epatch ${FILESDIR}/${P}-extramodules.patch
}

src_compile() {
	distutils_src_compile

	# Generate html docs from reStructured text sources
	PYTHONPATH=${S}/build/lib ${python} \
		tools/buildhtml.py --config=tools/docutils.conf
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
	mydoc="MANIFEST.in *.txt"
	distutils_src_install
	# Tools
	cd ${S}/tools
	for tool in *.py
	do
		newbin ${tool} docutils-${tool}
	done
	# Docs
	cd ${S}
	dohtml -r docs spec tools
	for doc in $(find docs spec tools -name '*.txt')
	do
		install_txt_doc $doc
	done

	# installing Gentoo GLEP tools. Uses versioned GLEP distribution
	if use glep
	then
		distutils_python_version
		newbin ${GLEP_SRC}/glep.py docutils-glep.py || die "newbin failed"
		insinto /usr/$(get_libdir)/python${PYVER}/site-packages/docutils/readers
		newins ${GLEP_SRC}/glepread.py glep.py || die "newins reader failed"
		insinto /usr/$(get_libdir)/python${PYVER}/site-packages/docutils/transforms
		newins ${GLEP_SRC}/glepstrans.py gleps.py || "newins transform failed"
		insinto /usr/$(get_libdir)/python${PYVER}/site-packages/docutils/writers
		newins ${GLEP_SRC}/glep_htmlwrite.py glep_html.py || die "newins writer failed"
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
