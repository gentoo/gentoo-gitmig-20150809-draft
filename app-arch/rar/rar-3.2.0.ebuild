# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/rar/rar-3.2.0.ebuild,v 1.3 2004/01/02 18:47:53 aliz Exp $

S=${WORKDIR}/${PN}
MY_P=${PN}linux-${PV}
DESCRIPTION="RAR compressor/uncompressor"
SRC_URI="http://www.rarlab.com/rar/${MY_P}.tar.gz"
HOMEPAGE="http://www.rarsoft.com/"

SLOT="0"
LICENSE="RAR"
KEYWORDS="~x86 ~amd64 -ppc -sparc -alpha"

RDEPEND="amd64? ( app-emulation/emul-linux-x86-baselibs )"

src_install() {
	dodir /opt/${PN} /opt/${PN}/{bin,etc,lib}

	exeinto /opt/${PN}/bin
	doexe rar unrar
	insinto /opt/${PN}/lib
	doins default.sfx
	insinto /opt/${PN}/etc
	doins rarfiles.lst

	dodoc *.{txt,diz}

	dodir /opt/bin
	dosym /opt/${PN}/bin/rar /opt/bin/rar
	dosym /opt/${PN}/bin/unrar /opt/bin/unrar
}
