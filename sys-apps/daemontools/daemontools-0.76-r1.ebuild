# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/sys-apps/daemontools/daemontools-0.76-r1.ebuild,v 1.7 2002/09/23 13:47:05 raker Exp $

S=${WORKDIR}/admin/${P}

DESCRIPTION="Collection of tools for managing UNIX services"
SRC_URI="http://cr.yp.to/daemontools/${P}.tar.gz"
HOMEPAGE="http://cr.yp.to/daemontools.html"

KEYWORDS="x86 ppc sparc sparc64"
SLOT="0"
LICENSE="Freeware"

DEPEND="virtual/glibc"
RDEPEND="${DEPEND}"

src_unpack() {

	unpack ${A}
	cd ${S}

	LDFLAGS=
	use static && LDFLAGS="-static"

	echo "gcc ${CFLAGS}" > src/conf-cc
	echo "gcc ${LDFLAGS}" > src/conf-ld
	echo ${S} > src/home

}

src_compile() {

	cd ${S}/src
	emake || die "make failed"

}

src_install() {

	einfo "Creating service directory ..."
	dodir /service
	touch ${D}/service/.keep

	einfo "Installing package ..."
	cd ${S}/src
	exeinto /usr/bin
	for x in `cat ../package/commands`
	do
		doexe $x
	done

	dodoc CHANGES ../package/README TODO

	einfo "Installing the svscan startup file ..."
	insinto /etc/init.d
	insopts -m755
	doins ${FILESDIR}/svscan

}

