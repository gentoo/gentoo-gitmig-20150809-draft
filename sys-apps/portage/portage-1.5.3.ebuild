# Copyright 1999-2001 Gentoo Technologies, Inc. Distributed under the terms
# of the GNU General Public License, v2 or later 
# Author Daniel Robbins <drobbins@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-apps/portage/portage-1.5.3.ebuild,v 1.5 2001/08/05 19:08:21 drobbins Exp $
 
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
	doins make.globals make.conf

	#python modules
	cd ${FILESDIR}/${PPV}/pym
	insinto /usr/lib/portage/pym
	doins xpak.py portage.py
	dodir /usr/lib/python2.0/site-packages
	dosym /usr/lib/portage/pym/xpak.py /usr/lib/python2.0/site-packages/xpak.py
	dosym /usr/lib/portage/pym/portage.py /usr/lib/python2.0/site-packages/portage.py

	# we gotta compile these modules
	try spython -c \""import compileall; compileall.compile_dir('${D}/usr/lib/python2.0/site-packages')"\"
	try spython -O -c \""import compileall; compileall.compile_dir('${D}/usr/lib/python2.0/site-packages')"\"
	
	#binaries and scripts
	dodir /usr/lib/portage/bin
	cd ${FILESDIR}/${PPV}/bin
	exeinto /usr/lib/portage/bin
	doexe *
	dosym emake /usr/lib/portage/bin/pmake
	doexe ${S}/tbz2tool

	#symlinks
	dodir /usr/bin /usr/sbin
	dosym /usr/lib/portage/bin/emerge /usr/sbin/emerge
	dosym /usr/lib/portage/bin/pkgmerge /usr/sbin/pkgmerge
	dosym /usr/lib/portage/bin/ebuild /usr/sbin/ebuild
	dosym /usr/lib/portage/bin/ebuild.sh /usr/sbin/ebuild.sh
	#dosym /usr/lib/portage/bin/portage-maintain /usr/sbin/portage-maintain
	dosym /usr/lib/portage/bin/env-update /usr/sbin/env-update
	dosym /usr/lib/portage/bin/xpak	/usr/bin/xpak
	dosym /usr/lib/portage/bin/tbz2tool /usr/bin/tbz2tool
	dosym newins /usr/lib/portage/bin/donewins

    if [ -z "`use build`" ] && [ -z "`use bootcd`" ]
    then
	  #man pages
	  doman ${FILESDIR}/${PPV}/man/*.[15]

	  #docs
	  dodoc ${FILESDIR}/${PPV}/doc/*
   fi
}

pkg_postinst() {
	if [ ! -e ${ROOT}/etc/make.profile ]
	then
		cd ${ROOT}/etc
		ln -s /usr/portage/profiles/default make.profile
	fi
	local x
	for x in portage xpak
	do
		if [ -e ${ROOT}/usr/lib/python2.0/${x}.py ]
		then
			rm ${ROOT}/usr/lib/python2.0/${x}.py
			rm -f ${ROOT}/usr/lib/python2.0/${x}.pyc
		fi
	done
}
