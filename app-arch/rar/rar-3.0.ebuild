# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-arch/rar/rar-3.0.ebuild,v 1.4 2002/07/21 01:19:13 cardoe Exp $

LICENSE="RAR"

S=${WORKDIR}/${PN}

MY_P=${PN}linux-${PV}
SLOT="0"
DESCRIPTION="RAR compressor/uncompressor"
SRC_URI="http://www.rarlab.com/rar/${MY_P}.tar.gz"
SLOT="0"
HOMEPAGE="http://www.rarsoft.com"
KEYWORDS="x86"

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
