# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/ysm/ysm-2.7.1.ebuild,v 1.1 2002/08/14 07:56:29 aliz Exp $

MY_PV=${PV//./_}
DESCRIPTION="A console ICQ client supporting versions 7/8"
HOMEPAGE="http://ysmv7.sourceforge.net/"
SRC_URI="mirror://sourceforge/ysmv7/${PN}v7_${MY_PV}.tgz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
DEPEND="virtual/glibc"
RDEPEND="virtual/glibc"

S=${WORKDIR}/${PN}v7_${MY_PV}

src_compile() {
	cd ${S}
	cp GNUmakefile GNUmakefile.orig
	sed "s:CFLAGS = -O2 -Wall -g:CFLAGS = ${CFLAGS}:" GNUmakefile.orig > GNUmakefile

	emake || die
}

src_install () {
	dobin ysm
}

