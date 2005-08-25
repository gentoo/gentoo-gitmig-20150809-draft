# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnustep-apps/viewpdf/viewpdf-0.9.ebuild,v 1.4 2005/08/25 18:57:12 swegener Exp $

inherit gnustep

S=${WORKDIR}/ViewPDF

DESCRIPTION="PDF viewer (requires PDFKit)"
HOMEPAGE="http://home.gna.org/gsimageapps/"
SRC_URI="http://download.gna.org/gsimageapps/ViewPDF-${PV}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc ~x86"

IUSE=""
DEPEND="${GS_DEPEND}
	gnustep-libs/pdfkit"
RDEPEND="${GS_RDEPEND}
	gnustep-libs/pdfkit"

egnustep_install_domain "System"
