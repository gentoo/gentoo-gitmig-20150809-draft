# Copyright 1999-2001 Gentoo Technologies, Inc. Distributed under the terms
# of the GNU General Public License, v2 or later 
# Author: Daniel Robbins <drobbins@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-apps/portage/portage-1.6.8.ebuild,v 1.1 2001/09/13 02:17:55 drobbins Exp $
 
S=${WORKDIR}/${P}
DESCRIPTION="Portage ports system"
SRC_URI=""
HOMEPAGE="http://www.gentoo.org"
#debianutils is for "readlink"

if [ -z "`use build`" ] ; then
  RDEPEND="sys-devel/spython sys-apps/debianutils"
fi

src_unpack() {
	#We are including the Portage bzipped tarball on CVS now, so that if a person's
	#emerge gets hosed, they are not completely stuck.
	cd ${WORKDIR}; tar xjf ${FILESDIR}/${P}.tar.bz2
}

src_compile() {                           
	cd ${S}/src; gcc ${CFLAGS} tbz2tool.c -o tbz2tool
}

src_install() {
	#config files
	cd ${S}/cnf
	insinto /etc
	doins make.globals make.conf

	#python modules
	cd ${S}/pym
	insinto /usr/lib/portage/pym
	doins xpak.py portage.py
	dodir /usr/lib/python2.0/site-packages
	dosym ../../portage/pym/xpak.py /usr/lib/python2.0/site-packages/xpak.py
	dosym ../../portage/pym/portage.py /usr/lib/python2.0/site-packages/portage.py

	# we gotta compile these modules
	# next lines commented out due to "try" issues.  This allows people to upgrade who need to upgrade
#	try spython -c "import compileall; compileall.compile_dir('${D}/usr/lib/python2.0/site-packages')"
#	try spython -O -c "import compileall; compileall.compile_dir('${D}/usr/lib/python2.0/site-packages')"
	
	#binaries and scripts
	dodir /usr/lib/portage/bin
	cd ${S}/bin
	exeinto /usr/lib/portage/bin
	doexe *
	dosym emake /usr/lib/portage/bin/pmake
	doexe ${S}/src/tbz2tool

	#symlinks
	dodir /usr/bin /usr/sbin
	dosym ../lib/portage/bin/emerge /usr/sbin/emerge
	dosym ../lib/portage/bin/pkgmerge /usr/sbin/pkgmerge
	dosym ../lib/portage/bin/ebuild /usr/sbin/ebuild
	dosym ../lib/portage/bin/ebuild.sh /usr/sbin/ebuild.sh
	#dosym /usr/lib/portage/bin/portage-maintain /usr/sbin/portage-maintain
	dosym ../lib/portage/bin/env-update /usr/sbin/env-update
	dosym ../lib/portage/bin/xpak /usr/bin/xpak
	dosym ../lib/portage/bin/tbz2tool /usr/bin/tbz2tool
	dosym newins /usr/lib/portage/bin/donewins

    if [ -z "`use build`" ] && [ -z "`use bootcd`" ]
    then
	  #man pages
	  doman ${S}/man/*.[15]
	fi
	dodir /var/tmp
	chmod 1777 ${D}/var/tmp
	touch ${D}/var/tmp/.keep
	if [ "`use build`" ] || [ "`use bootcd`" ]
	then
		#convenience; overwrite existing symlink
		ln -sf ../usr/portage/profiles/default-1.0_rc6 ${D}/etc/make.profile
	fi
	dodoc ${S}/ChangeLog
}

pkg_postinst() {
	if [ ! -e ${ROOT}/etc/make.profile ]
	then
		cd ${ROOT}/etc
		ln -s ../usr/portage/profiles/default-1.0_rc6 make.profile
	fi
	local x
	for x in portage xpak
	do
		if [ -e ${ROOT}/usr/lib/python2.0/${x}.py ]
		then
			rm ${ROOT}/usr/lib/python2.0/${x}.py
			rm ${ROOT}/usr/lib/python2.0/${x}.pyc
		fi
	done
}
