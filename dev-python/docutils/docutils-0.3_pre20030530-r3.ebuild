# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/docutils/docutils-0.3_pre20030530-r3.ebuild,v 1.2 2003/06/21 22:30:24 drobbins Exp $

DESCRIPTION="Set of python tools for processing plaintext docs into HTML, XML, etc."
HOMEPAGE="http://docutils.sourceforge.net/"
SRC_URI="mirror://gentoo/${P}.tgz"

LICENSE="public-domain PYTHON BSD"
SLOT="0"
KEYWORDS="x86 amd64"
IUSE=""

inherit distutils

DEPEND=">=dev-lang/python-2.1"
S=${WORKDIR}/${PN}

src_compile() {
	distutils_src_compile

	# Generate html docs from reStructured text sources
	PYTHONPATH=${S}/build/lib ${python} \
		tools/buildhtml.py --config=tools/docutils.conf
}


install_txt_doc() {
	local doc=${1}
	local dir="txt/$(dirname ${doc})"
	docinto ${dir}
	dodoc ${doc}
}

src_install() {
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
	# Gentoo GLEP tools
	newbin ${FILESDIR}/glep.py docutils-glep.py
	distutils_python_version
	insinto /usr/lib/python${PYVER}/site-packages/docutils/readers
	newins ${FILESDIR}/glepread.py glep.py
	insinto /usr/lib/python${PYVER}/site-packages/docutils/transforms
	newins ${FILESDIR}/glepstrans.py gleps.py
	insinto /usr/lib/python${PYVER}/site-packages/docutils/writers
	newins ${FILESDIR}/glep_htmlwrite.py glep_html.py
}

