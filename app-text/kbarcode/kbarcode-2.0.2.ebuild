# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/kbarcode/kbarcode-2.0.2.ebuild,v 1.1 2006/04/29 12:12:59 carlo Exp $

inherit kde

MY_P="${P/_/}"
S="${WORKDIR}/${MY_P}"

DESCRIPTION="KBarcode is a barcode and label printing application for KDE."
HOMEPAGE="http://www.kbarcode.net/"
SRC_URI="mirror://sourceforge/kbarcode/${MY_P}.tar.gz
	doc? ( mirror://sourceforge/kbarcode/${PN}-2.0.0.pdf )"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="doc"

DEPEND=">=app-text/barcode-0.98"

RDEPEND=">=app-text/barcode-0.98
	virtual/ghostscript"

need-kde 3.4

src_install() {
	kde_src_install
	use doc && cp ${DISTDIR}/${P}.pdf ${D}/usr/share/doc/${PF}
}