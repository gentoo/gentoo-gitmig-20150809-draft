# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmSMPmon/wmSMPmon-2.3.ebuild,v 1.3 2005/04/07 17:09:58 blubb Exp $

S="${WORKDIR}/${PN}-2.x"

IUSE=""
DESCRIPTION="SMP system monitor dockapp"
HOMEPAGE="http://goupilfr.org/?soft=wmsmpmon"
SRC_URI="http://goupilfr.org/arch/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 amd64"

DEPEND="virtual/libc
	virtual/x11
	>=sys-apps/sed-4"

S="${WORKDIR}/${PN}-2.x/${PN}"

src_unpack()
{
	unpack ${A}
	cd ${S}
	sed -i -e "s:-Wall -O3 -m486:${CFLAGS}:" Makefile
}

src_compile()
{
	make || die "make failed"
}

src_install()
{
	dobin wmSMPmon
}
