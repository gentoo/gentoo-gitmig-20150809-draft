# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/rar/rar-3.2.0.ebuild,v 1.4 2004/01/03 17:04:38 vapier Exp $

S=${WORKDIR}/${PN}
MY_P=${PN}linux-${PV}
DESCRIPTION="RAR compressor/uncompressor"
HOMEPAGE="http://www.rarsoft.com/"
SRC_URI="http://www.rarlab.com/rar/${MY_P}.tar.gz"

LICENSE="RAR"
SLOT="0"
KEYWORDS="-* x86 ~amd64"

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
