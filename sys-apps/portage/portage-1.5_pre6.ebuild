# Copyright 1999-2001 Gentoo Technologies, Inc. Distributed under the terms
# of the GNU General Public License, v2 or later 
# Author Daniel Robbins <drobbins@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-apps/portage/portage-1.5_pre6.ebuild,v 1.2 2001/02/27 12:11:44 achim Exp $
 
S=${WORKDIR}/${P}
DESCRIPTION="Portage autobuild system"
SRC_URI=""
HOMEPAGE="http://www.gentoo.org"
RDEPEND="sys-devel/spython"
PPV=1.5

src_unpack() {
	mkdir ${S}
	cp ${FILESDIR}/${PPV}/src/*.c ${S}
}

src_compile() {                           
	gcc ${CFLAGS} tbz2tool.c -o tbz2tool
}


src_install() {
	#config files
	cd ${FILESDIR}/${PPV}/cnf
	insinto /etc
	doins make.defaults
	newins make.conf make.conf.eg
	
	#python modules
	cd ${FILESDIR}/${PPV}/pym
	insinto /usr/lib/python2.0
	doins portage.py xpak.py
	
	#binaries and scripts
	dodir /usr/lib/portage/bin
	cd ${FILESDIR}/${PPV}/bin
	exeinto /usr/lib/portage/bin
	doexe * 
	doexe ${S}/tbz2tool
	
	#symlinks
	dodir /usr/bin /usr/sbin
	dosym /usr/lib/portage/bin/pkgmerge /usr/sbin/pkgmerge
	dosym /usr/lib/portage/bin/ebuild	/usr/sbin/ebuild
	dosym /usr/lib/portage/bin/portage-maintain /usr/sbin/portage-maintain
	dosym /usr/lib/portage/bin/env-update /usr/sbin/env-update
	dosym /usr/lib/portage/bin/xpak	/usr/bin/xpak
	dosym /usr/lib/portage/bin/tbz2tool /usr/bin/tbz2tool
	dosym newins /usr/lib/portage/bin/donewins
	
	#man pages
	doman ${FILESDIR}/${PPV}/man/*.[15]

	#docs
	dodoc ${FILESDIR}/${PPV}/doc/*
}

pkg_postinst() {
	if [ ! -e ${ROOT}/etc/make.conf ]
	then
		cp ${ROOT}/etc/make.conf.eg ${ROOT}/etc/make.conf
	fi
}


