# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnustep-libs/pdfkit/pdfkit-0.8-r1.ebuild,v 1.1 2004/10/29 20:36:52 fafhrd Exp $

inherit gnustep

S=${WORKDIR}/${PN/pdfk/PDFK}

DESCRIPTION="PDFKit is a framework that supports rendering of PDF content in GNUstep applications"
HOMEPAGE="http://home.gna.org/gsimageapps/"
SRC_URI="http://download.gna.org/gsimageapps/${P/pdfk/PDFK}.tar.bz2"
LICENSE="GPL-2"
KEYWORDS="~ppc ~x86"
SLOT="0"

IUSE="${IUSE}"
DEPEND="${GS_DEPEND}
	!gnustep-libs/imagekits"
RDEPEND="${GS_RDEPEND}
	!gnustep-libs/imagekits"

src_unpack()
{
	gnustep_src_unpack
	( cd xpdf/xpdf-3.00/xpdf; epatch ${FILESDIR}/xpdf-3.00-CESA-2004-007.diff.bz2 )
}

