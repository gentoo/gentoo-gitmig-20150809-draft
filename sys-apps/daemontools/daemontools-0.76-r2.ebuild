# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/daemontools/daemontools-0.76-r2.ebuild,v 1.4 2003/02/27 02:44:30 vapier Exp $

inherit eutils

DESCRIPTION="Collection of tools for managing UNIX services"
SRC_URI="http://cr.yp.to/daemontools/${P}.tar.gz"
HOMEPAGE="http://cr.yp.to/daemontools.html"

KEYWORDS="~x86 ~ppc ~sparc "
SLOT="0"
LICENSE="freedist"

DEPEND="virtual/glibc"

S=${WORKDIR}/admin/${P}

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PV}-errno.patch

	use static && LDFLAGS="${LDFLAGS} -static"

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
	newins ${FILESDIR}/svscan-r2 svscan
}
