# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# /space/gentoo/cvsroot/gentoo-x86/skel.ebuild,v 1.8 2002/05/30 01:54:49 sandymac Exp

DESCRIPTION="hsflinmodem - Modem driver for Connexant HSF chipset"
HOMEPAGE="http://www.mbsi.ca/cnxtlindrv/"
LICENSE="Conexant"
DEPEND=""
RDEPEND="${DEPEND}"
SLOT="0"
KEYWORDS="x86"

SRC_URI="http://www.mbsi.ca/cnxtlindrv/hsf/hsflinmodem-5.03.03.L3mbsibeta02062500/dl/${PN}-5.03.03.L3mbsibeta02062500.tar.gz"
S=${WORKDIR}/${PN}-5.03.03.L3mbsibeta02062500

src_compile() {
	emake all || die
}

src_install () {
	make PREFIX=${D}/usr/ ROOT=${D} install || die
}

pkg_postinst() {
	echo "To complete the installation and configuration of your HSF modem,"
	echo "please run hsfconfig."
}
