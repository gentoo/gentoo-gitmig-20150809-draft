# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/xsv/xsv-2.7.ebuild,v 1.9 2010/10/31 22:56:22 arfrever Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"

inherit distutils

MY_PN="XSV"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Python XML Schema Validator"
HOMEPAGE="http://www.ltg.ed.ac.uk/~ht/xsv-status.html"
SRC_URI="ftp://ftp.cogsci.ed.ac.uk/pub/XSV/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc x86"
IUSE=""

DEPEND=">=dev-python/pyltxml-1.3"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${MY_P}"

PYTHON_MODNAME="XSV"

src_install() {
	distutils_src_install

	dodoc xsv-status.xml pc-shrinkwrap || die "dodoc failed"
	dohtml xsv-status.html || die "dohtml failed"
	insinto /usr/share/doc/${PF}/examples
	doins triv.xml triv.xsd tiny.xml tiny.xsd || die "doins failed"

	delete_docs_and_examples() {
		rm -fr "${ED}$(python_get_sitedir)/XSV/"{doc,example}
	}
	python_execute_function -q delete_docs_and_examples
}
