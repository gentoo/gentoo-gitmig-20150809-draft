# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-misc/qcad-parts/qcad-parts-2.1.2.8.ebuild,v 1.1 2008/11/06 12:39:07 bicatali Exp $

MY_PN="partlibrary"
MY_PV="${PV}-1"

DESCRIPTION="Collection of CAD files that can be used from the library browser of QCad"
LICENSE="GPL-2"
HOMEPAGE="http://www.ribbonsoft.com/qcad_library.html"
SRC_URI="ftp://ribbonsoft.com/archives/${MY_PN}/${MY_PN}-${MY_PV}.tar.gz"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~ppc ~x86"
IUSE=""

S="${WORKDIR}/${MY_PN}-${MY_PV}"

src_install() {
	insinto /usr/share/${PN}
	doins -r * || die "Failed installing qcad-parts files"
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
