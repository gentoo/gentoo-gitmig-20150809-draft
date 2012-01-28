# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/xhtml2pdf/xhtml2pdf-0.0.3.ebuild,v 1.2 2012/01/28 10:27:55 nelchael Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"

inherit distutils

DESCRIPTION="PDF generator using HTML and CSS"
HOMEPAGE="http://www.xhtml2pdf.com/ http://pypi.python.org/pypi/xhtml2pdf"
SRC_URI="mirror://pypi/${PN}/${PN}/${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-python/html5lib
	dev-python/imaging
	dev-python/pyPdf
	dev-python/reportlab"
RDEPEND="${DEPEND}"

PYTHON_MODNAME="xhtml2pdf"
