# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmSMPmon/wmSMPmon-2.2.ebuild,v 1.5 2004/01/04 18:36:48 aliz Exp $

S="${WORKDIR}/${PN}-2.x"

DESCRIPTION="SMP system monitor dockapp"
HOMEPAGE="http://goupilfr.org/?soft=wmsmpmon"
SRC_URI="http://goupilfr.org/arch/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 amd64"

DEPEND="virtual/glibc
	virtual/x11"

src_unpack() {
	unpack ${A} ; cd ${S}/wmSMPmon

	sed -i -e "s:-Wall -O3 -m486:${CFLAGS}:" Makefile
}

src_compile() {
	make || die "make failed"
	}

src_install() {

	cd ${S}/${PN}
	dobin wmSMPmon

}
