# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/verynice/verynice-1.1.ebuild,v 1.6 2004/10/25 23:15:08 slarti Exp $

DESCRIPTION="A tool for dynamically adjusting the nice-level of processes"
HOMEPAGE="http://www.tam.cornell.edu/~sdh4/verynice/"
SRC_URI="http://www.tam.cornell.edu/~sdh4/verynice/down/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~amd64"
IUSE=""

S=${WORKDIR}/${PN}

src_compile() {
	emake RPM_BUILD_ROOT=${D} PREFIX=/usr || die "emake failed"
}

src_install(){
	# the install looks for this directory.
	dodir /etc/init.d
	einstall RPM_BUILD_ROOT=${D} PREFIX=/usr || die

	# odd, the config file is installed +x
	fperms a-x /etc/verynice.conf

	# make the doc install Gentooish
	mv ${D}/usr/share/doc/${P}/* ${T} || die "mv failed"
	dodoc ${T}/{CHANGELOG,README*}
	dohtml ${T}/*
	# html references the COPYING file.
	cp ${T}/COPYING ${D}/usr/share/doc/${P}/html

	exeinto /etc/init.d
	doexe ${FILESDIR}/verynice || die "doexe failed"
}
