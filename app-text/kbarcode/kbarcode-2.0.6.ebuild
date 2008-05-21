# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/kbarcode/kbarcode-2.0.6.ebuild,v 1.2 2008/05/21 17:06:58 nixnut Exp $

inherit kde

MY_P="${P/_/}"
S="${WORKDIR}/${MY_P}"

DESCRIPTION="KBarcode is a barcode and label printing application for KDE."
HOMEPAGE="http://www.kbarcode.net/"
SRC_URI="mirror://sourceforge/kbarcode/${MY_P}.tar.gz
	doc? ( mirror://sourceforge/kbarcode/kbarcode-2.0.0.pdf )"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ppc ~x86"
IUSE="doc"

DEPEND=">=app-text/barcode-0.98
	dev-libs/libpcre"

RDEPEND=">=app-text/barcode-0.98
	dev-libs/libpcre
	virtual/ghostscript"

need-kde 3.5

PATCHES="${FILESDIR}/kbarcode-2.0.6-desktop-entry-fixes.diff"

src_unpack() {
	kde_src_unpack
	# does call unsermake...
	rm configure
}

src_install() {
	kde_src_install
	use doc && cp "${DISTDIR}/kbarcode-2.0.0.pdf" "${D}/usr/share/doc/${PF}"
	# Application installs mime entry in the wrong place.
	dodir /usr/share/mimelnk/application/
	cp "${S}"/kbarcode/kbarcode-label.desktop "${D}"/usr/share/mimelnk/application/
}
