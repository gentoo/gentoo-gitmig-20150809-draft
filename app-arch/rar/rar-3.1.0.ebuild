# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/rar/rar-3.1.0.ebuild,v 1.4 2004/03/12 11:11:07 mr_bones_ Exp $

S=${WORKDIR}/${PN}
MY_P=${PN}linux-${PV}
DESCRIPTION="RAR compressor/uncompressor"
SRC_URI="http://www.rarlab.com/rar/${MY_P}.tar.gz"
HOMEPAGE="http://www.rarsoft.com/"

SLOT="0"
LICENSE="RAR"
KEYWORDS="x86 -ppc -sparc -alpha"

RDEPEND="sys-libs/lib-compat"

src_install() {
	dodir /opt/${PN} /opt/${PN}/{bin,etc,lib}

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
