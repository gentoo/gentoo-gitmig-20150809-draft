# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/mtd/mtd-20050519.ebuild,v 1.3 2006/10/21 19:28:45 dertobi123 Exp $

DESCRIPTION="JFFS2 is a log-structured file system designed for use on flash devices in embedded systems."
HOMEPAGE="http://sources.redhat.com/jffs2/"
SRC_URI="ftp://ftp.uk.linux.org/pub/people/dwmw2/mtd/cvs/${PN}-snapshot-${PV}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~arm ~mips ppc ~x86"
IUSE=""

S=${WORKDIR}/${PN}

DEPEND="sys-libs/zlib
	virtual/libc"

src_unpack() {
	unpack ${A}
	sed -i -e s:'-O2 -Wall':"${CFLAGS}":g -e s:^MANDIR=.*:MANDIR=/usr/share/man: ${S}/util/Makefile || die
}

src_compile() {
	cd ${S}/util
	emake LINUXDIR=${ROOT}/usr/src/linux/ || die
}

src_install() {
	cd ${S}/util
	einstall DESTDIR=${D}
}
