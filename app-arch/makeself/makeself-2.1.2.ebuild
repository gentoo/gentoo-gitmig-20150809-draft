# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/makeself/makeself-2.1.2.ebuild,v 1.8 2004/10/05 10:59:23 pvdabeel Exp $

inherit eutils

DESCRIPTION="shell script that generates a self-extractible tar.gz"
HOMEPAGE="http://www.megastep.org/makeself/"
SRC_URI="http://www.megastep.org/makeself/${P}.run"

LICENSE="GPL-2"
SLOT="0"
IUSE=""
KEYWORDS="x86 s390 ppc"

DEPEND=""
RDEPEND=""

S=${WORKDIR}

src_unpack() {
	unpack_makeself
}

src_install() {
	dobin makeself-header.sh makeself.sh
	dodoc README TODO makeself.lsm
}
