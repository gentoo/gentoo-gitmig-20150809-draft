# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-doc/kchmviewer/kchmviewer-4.0_beta1.ebuild,v 1.1 2007/09/28 17:10:51 pva Exp $

inherit qt4 fdo-mime

MY_P="${PN}-${PV/_beta/b}"

DESCRIPTION="KchmViewer is a feature rich chm file viewer, based on Qt."
HOMEPAGE="http://www.kchmviewer.net/"
SRC_URI="mirror://sourceforge/kchmviewer/${MY_P}.tar.gz"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="$(qt4_min_version 4.2)
	app-doc/chmlib"

S=${WORKDIR}/${MY_P}

src_compile() {
	eqmake4
	emake || die "make failed"
}

src_install() {
	dobin bin/kchmviewer || die "dobin kchmviewer failed"
	insinto /usr/share/applications
	doins lib/kio-msits/kchmviewer.desktop
	dodoc ChangeLog README
}

pkg_postinst() {
	fdo-mime_desktop_database_update
}
