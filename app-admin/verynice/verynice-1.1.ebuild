# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/verynice/verynice-1.1.ebuild,v 1.13 2008/06/16 14:07:32 drac Exp $

DESCRIPTION="A tool for dynamically adjusting the nice-level of processes"
HOMEPAGE="http://ahab.cnde.iastate.edu/~sdh4/verynice/"
SRC_URI="http://thermal.cnde.iastate.edu/~sdh4/verynice/down/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE=""

S=${WORKDIR}/${PN}

src_compile() {
	emake RPM_BUILD_ROOT="${D}" PREFIX=/usr || die "emake failed"
}

src_install(){
	# the install looks for this directory.
	dodir /etc/init.d
	einstall RPM_BUILD_ROOT="${D}" PREFIX=/usr || die

	# odd, the config file is installed +x
	fperms a-x /etc/verynice.conf

	# make the doc install Gentooish
	mv "${D}"/usr/share/doc/${P}/* "${T}" || die "mv failed"
	dodoc "${T}"/{CHANGELOG,README*}
	dohtml "${T}"/*

	doinitd "${FILESDIR}"/verynice || die "doinitd failed"
}
