# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dialup/serlook/serlook-0.3.2.ebuild,v 1.3 2006/07/07 02:01:59 vapier Exp $

inherit kde

DESCRIPTION="tool to inspect and debug serial line data traffic"
HOMEPAGE="http://serlook.sunsite.dk/"
SRC_URI="http://serlook.sunsite.dk/${P}.tar.gz
	mirror://gentoo/${P}-resouces.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc x86"
IUSE=""

S=${WORKDIR}/${PN}

PATCHES="${WORKDIR}/makefile.patch"

need-kde 3

src_install() {
	kde_src_install
	mv "${D}"/usr/share/doc/serlook "${D}"/usr/share/doc/${PF}
}
