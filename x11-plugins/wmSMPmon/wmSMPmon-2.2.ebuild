# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmSMPmon/wmSMPmon-2.2.ebuild,v 1.1 2002/10/04 18:27:23 raker Exp $

S="${WORKDIR}/${PN}-2.x"

DESCRIPTION="SMP system monitor dockapp"
HOMEPAGE="http://goupilfr.org/?soft=wmsmpmon"
SRC_URI="http://goupilfr.org/arch/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

DEPEND="virtual/glibc
	virtual/x11"
RDEPEND="${DEPEND}"

src_compile() {

	cd ${S}/${PN}
	cp Makefile Makefile.orig
	sed -e "s:-Wall -O3 -m486:${CFLAGS}:" Makefile.orig > Makefile
	make || die "make failed"

}

src_install() {

	cd ${S}/${PN}
	dobin wmSMPmon

}
