# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dialup/serlook/serlook-0.3.2.ebuild,v 1.1 2006/03/18 10:11:52 mrness Exp $

inherit kde

DESCRIPTION="serlook is a tool aimed to inspect and debug serial line data traffic"
HOMEPAGE="http://serlook.sunsite.dk/"
SRC_URI="http://serlook.sunsite.dk/${P}.tar.gz
	mirror://gentoo/${P}-resouces.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~ppc ~x86"
IUSE=""

S="${WORKDIR}/${PN}"

PATCHES="${WORKDIR}/makefile.patch"

need-kde 3

src_install() {
	kde_src_install
	mv "${D}/usr/share/doc/serlook" "${D}/usr/share/doc/${PF}"
}
