# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/eselect-opencascade/eselect-opencascade-0.ebuild,v 1.1 2013/04/26 20:47:03 xmw Exp $

EAPI=4

DESCRIPTION="Manages opencascade env file"
HOMEPAGE="http://www.gentoo.org/proj/en/eselect/"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="!=sci-libs/opencascade-6.5"
RDEPEND="${DEPEND}"

S="${WORKDIR}"

src_install() {
	dodir /etc/env.d/opencascade
	insinto /usr/share/eselect/modules
	newins "${FILESDIR}"/${P}.eselect opencascade.eselect
}

pkg_postrm() {
	rm -v ${EROOT}etc/env.d/50opencascade
}
