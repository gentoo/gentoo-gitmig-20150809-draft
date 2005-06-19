# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/855resolution/855resolution-0.4.ebuild,v 1.1 2005/06/19 22:07:03 fafhrd Exp $

S=${WORKDIR}/${PN}

DESCRIPTION="Utility to patch VBIOS of Intel 855 / 865 / 915 chipsets."
HOMEPAGE="http://perso.wanadoo.fr/apoirier"
SRC_URI="http://perso.wanadoo.fr/apoirier/${P}.tgz"

LICENSE="public-domain as-is"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="virtual/libc"
#RDEPEND=""

src_compile() {
	emake || die "emake failed"
}

src_install() {
	exeinto /usr/sbin
	doexe ${PN}

	dodoc README.txt

	insinto /etc/conf.d
	newins ${FILESDIR}/${PV}/conf 855resolution
	exeinto /etc/init.d
	newexe ${FILESDIR}/${PV}/init 855resolution
}
