# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/verynice/verynice-1.1.ebuild,v 1.3 2004/02/29 23:07:29 pyrania Exp $

S=${WORKDIR}/${PN}
DESCRIPTION="A tool for dynamically adjusting the nice-level of processes"
HOMEPAGE="http://www.tam.cornell.edu/~sdh4/verynice/"
SRC_URI="http://www.tam.cornell.edu/~sdh4/verynice/down/${P}.tar.gz"

KEYWORDS="x86"
LICENSE="GPL-2"
SLOT="0"

src_compile() {
	emake RPM_BUILD_ROOT=${D} PREFIX=/usr || die "emake failed"
}

src_install(){
	# the install looks for this directory.
	dodir /etc/init.d                            || die "dodir failed"

	einstall RPM_BUILD_ROOT=${D} PREFIX=/usr     || die

	# odd, the config file is installed +x
	fperms a-x /etc/verynice.conf                || die "fperms failed"

	# make the doc install Gentooish
	mv ${D}/usr/share/doc/${P}/* ${T}            || die "mv failed"
	dodoc ${T}/{CHANGELOG,README*}               || die "dodoc failed"
	dohtml ${T}/*                                || die "dohtml failed"
	# html references the COPYING file.
	cp ${T}/COPYING ${D}/usr/share/doc/${P}/html || die "cp failed"

	exeinto /etc/init.d
	doexe ${FILESDIR}/verynice                   || die "doexe failed"
}
