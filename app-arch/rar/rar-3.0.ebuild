# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-arch/rar/rar-3.0.ebuild,v 1.6 2002/08/14 08:00:35 pvdabeel Exp $

S=${WORKDIR}/${PN}
MY_P=${PN}linux-${PV}
DESCRIPTION="RAR compressor/uncompressor"
SRC_URI="http://www.rarlab.com/rar/${MY_P}.tar.gz"
HOMEPAGE="http://www.rarsoft.com"

SLOT="0"
LICENSE="RAR"
KEYWORDS="x86 ppc"

RDEPEND="virtual/glibc"

src_install () {
	dodir /opt/${PN}
	for i in bin etc lib 
	do
		dodir /opt/${PN}/${i}
	done

	exeinto /opt/${PN}/bin
	doexe rar unrar
	insinto /opt/${PN}/lib
	doins default.sfx
	insinto /opt/${PN}/etc
	doins rarfiles.lst

	dodoc *.{txt,diz}

	dodir /etc/env.d
	insinto /etc/env.d
	doins ${FILESDIR}/10rar
}
