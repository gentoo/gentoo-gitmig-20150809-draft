# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/snipsnap-bin/snipsnap-bin-1.0_beta1.ebuild,v 1.2 2004/09/16 07:34:42 axxo Exp $

DESCRIPTION="A blog/wiki personal content management system"
HOMEPAGE="http://snipsnap.org"
MY_P=${P/-bin}
MY_PN=${PN/-bin}
SRC_URI="ftp://snipsnap.org/${MY_PN}/${MY_PN}-1.0b1-uttoxeter-20040914.tgz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc"
IUSE=""
DEPEND=">=virtual/jre-1.3"
S=${WORKDIR}/${MY_PN}-1.0b1-uttoxeter

src_install() {
	dodir /opt/${MY_PN}
	cp -pR * ${D}/opt/${MY_PN}

	exeinto /opt/${MY_PN}
	newexe ${FILESDIR}/${PV}-run.sh run.sh
	exeinto /etc/init.d
	newexe ${FILESDIR}/${PV}-snipsnap snipsnap
}
