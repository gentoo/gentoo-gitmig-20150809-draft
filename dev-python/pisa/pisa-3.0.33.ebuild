# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pisa/pisa-3.0.33.ebuild,v 1.2 2010/11/08 18:51:58 arfrever Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"

inherit distutils

DESCRIPTION="Converter for HTML/XHTML and CSS to PDF"
HOMEPAGE="http://www.xhtml2pdf.com/ http://pypi.python.org/pypi/pisa"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-python/html5lib
	dev-python/imaging
	dev-python/pyPdf
	dev-python/reportlab"
RDEPEND="${DEPEND}"

PYTHON_MODNAME="ho sx"
