# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/scanmem/scanmem-0.07.ebuild,v 1.2 2007/07/12 01:05:42 mr_bones_ Exp $

inherit eutils

DESCRIPTION="Locate and modify variables in executing processes"
HOMEPAGE="http://taviso.decsystem.org/scanmem.html"
SRC_URI="http://taviso.decsystem.org/files/scanmem/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="sys-libs/readline"
RDEPEND="${DEPEND}"

src_install() {
	dobin scanmem
	doman scanmem.1
	dodoc README TODO ChangeLog
}
