# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmSMPmon/wmSMPmon-2.2.ebuild,v 1.4 2003/10/16 16:10:23 drobbins Exp $

S="${WORKDIR}/${PN}-2.x"

DESCRIPTION="SMP system monitor dockapp"
HOMEPAGE="http://goupilfr.org/?soft=wmsmpmon"
SRC_URI="http://goupilfr.org/arch/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 amd64"

DEPEND="virtual/glibc
	virtual/x11"

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
