# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-dicts/eblook/eblook-1.6.ebuild,v 1.8 2004/11/22 12:45:39 usata Exp $

IUSE=""

DESCRIPTION="EBlook is an interactive search utility for electronic dictionaries"
HOMEPAGE="http://openlab.ring.gr.jp/edict/eblook/"
SRC_URI="http://openlab.ring.gr.jp/edict/eblook/dist/${P/_/}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc"

DEPEND="!>=dev-libs/eb-4.1
	>=dev-libs/eb-3.3.4"

S="${WORKDIR}/${P%_*}"

src_compile() {
	econf --with-eb-conf=/etc/eb.conf || die
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die

	dodoc AUTHORS ChangeLog INSTALL NEWS README VERSION
}
