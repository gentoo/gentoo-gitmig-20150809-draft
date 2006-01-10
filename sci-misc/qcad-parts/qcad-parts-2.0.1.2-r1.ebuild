# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-misc/qcad-parts/qcad-parts-2.0.1.2-r1.ebuild,v 1.1 2006/01/10 03:14:43 markusle Exp $

MY_PN="partlibrary"
MY_PV="${PV}-1"

DESCRIPTION="Collection of CAD files that can be used from the library browser of QCad"
LICENSE="GPL-2"
HOMEPAGE="http://www.ribbonsoft.com/qcad_library.html"
SRC_URI="http://www.ribbonsoft.com/archives/partlibrary/partlibrary-${MY_PV}.zip"

SLOT="0"
KEYWORDS="~x86 ~ppc ~amd64"
IUSE=""

DEPEND="app-arch/unzip"

S="${WORKDIR}/${MY_PN}-${MY_PV}"

src_install() {
	cd "${S}"
	einfo "Fixing permissions - this might take a while"
	insinto /usr/share/${PN}
	doins -r ./* || die "Failed installing qcad-parts files"
}

pkg_postinst() {
	einfo
	einfo "The QCad parts library was installed in"
	einfo "/usr/share/${PN}"
	einfo "Please set this path in QCad's preferences to access it."
	einfo "(Edit->Application Preferences->Paths->Part Libraries)"
	einfo
	einfo "After restarting QCad, you can use the library by selecting"
	einfo "View->Views->Library Browser"
	einfo
}
