# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Maintainer: Matthew Kennedy <mkennedy@gentoo.org>
# Author: Matthew Kennedy <mkennedy@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/app-arch/rar/rar-3.0_beta7.ebuild,v 1.1 2002/05/13 03:07:03 mkennedy Exp $

LICENSE="RAR"

S=${WORKDIR}/rar

DESCRIPTION="RAR compressor/uncompressor"
SRC_URI="http://www.rarlab.com/rar/rarlinux-${PV/_beta/.b}.tar.gz"
HOMEPAGE="http://www.rarsoft.com"

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
