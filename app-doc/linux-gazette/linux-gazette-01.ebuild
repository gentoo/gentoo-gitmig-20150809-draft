# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: 

DESCRIPTION="Sharing ideas and discoveries and Making Linux just a little more fun"
HOMEPAGE="http://www.linuxgazette.com/"
SRC_URI="ftp://ftp.ssc.com/pub/lg/lg-issue01to08.tar.gz"

LICENSE="OPL"
SLOT="${PV}"
KEYWORDS="x86 ppc"

DEPEND=">=app-doc/linux-gazette-base-${PV}"

src_install() {
	dodir /usr/share/doc
	mv ${WORKDIR}/lg ${D}/usr/share/doc/${PN}
}
