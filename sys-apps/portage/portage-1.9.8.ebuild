# Copyright 1999-2002 Gentoo Technologies, Inc. Distributed under the terms
# of the GNU General Public License, v2 or later 
# $Header: /var/cvsroot/gentoo-x86/sys-apps/portage/portage-1.9.8.ebuild,v 1.1 2002/05/07 05:12:55 drobbins Exp $
 
S=${WORKDIR}/${P}
SLOT="0"
DESCRIPTION="Portage ports system"
SRC_URI=""
HOMEPAGE="http://www.gentoo.org"
#debianutils is for "readlink"
#We need this if/then/else clause for compatibility with stuff that doesn't know !build?
if [ "`use build`" ]
then
	RDEPEND=""
else
	RDEPEND=">=sys-apps/fileutils-4.1.8 dev-python/python-fchksum >=dev-lang/python-2.2.1 sys-apps/debianutils"
fi

src_unpack() {
	#We are including the Portage bzipped tarball on CVS now, so that if a person's
	#emerge gets hosed, they are not completely stuck.
	cd ${WORKDIR}; tar xjf ${FILESDIR}/portage-${PV}.tar.bz2
}

src_compile() {                           
	cd ${S}/src; gcc ${CFLAGS} tbz2tool.c -o tbz2tool
	cd ${S}/src/sandbox
	emake || die
}

pkg_preinst() {
	if [ -d /var/db/pkg/sys-apps/bash-2.05a ] && [ ! -d /var/db/pkg/sys-apps/bash-2.05a-r1 ]
	then
		eerror "You have to update your bash-2.05a installation."
		eerror "Please execute 'emerge sys-apps/bash' as root"
		eerror "before installing this version of portage."
		die
	fi
}

src_install() {
	#config files
	cd ${S}/cnf
	insinto /etc
	case "$ARCH" in
		ppc )
		doins ${FILESDIR}/ppc-${PV}/*
		;;
		* )
		doins make.globals make.conf
		;;
	esac

	#python modules
	cd ${S}/src/python-missingos
	chmod +x setup.py
	./setup.py install --root ${D} || die
	cd ${S}/pym
	insinto /usr/lib/python2.2/site-packages
	doins xpak.py portage.py output.py

	# we gotta compile these modules
	python -c "import compileall; compileall.compile_dir('${D}/usr/lib/python2.2/site-packages')" || die
	python -O -c "import compileall; compileall.compile_dir('${D}/usr/lib/python2.2/site-packages')" || die
	
	#binaries, libraries and scripts
	dodir /usr/lib/portage/bin
	cd ${S}/bin
	exeinto /usr/lib/portage/bin
	doexe *
	dosym emake /usr/lib/portage/bin/pmake
	doexe ${S}/src/tbz2tool
	
	into /usr/lib/portage
	dobin ${S}/src/sandbox/sandbox
	dodir /usr/lib/portage/lib
	exeinto /lib
	doexe ${S}/src/sandbox/libsandbox.so
	insinto //usr/lib/portage/lib
	doins ${S}/src/sandbox/sandbox.bashrc
	#reset into
	into /usr

	#symlinks
	dodir /usr/bin /usr/sbin
	dosym ../lib/portage/bin/emerge /usr/bin/emerge
	dosym ../lib/portage/bin/pkgmerge /usr/sbin/pkgmerge
	dosym ../lib/portage/bin/ebuild /usr/sbin/ebuild
	dosym ../lib/portage/bin/ebuild.sh /usr/sbin/ebuild.sh
	#dosym /usr/lib/portage/bin/portage-maintain /usr/sbin/portage-maintain
	dosym ../lib/portage/bin/env-update /usr/sbin/env-update
	dosym ../lib/portage/bin/xpak /usr/bin/xpak
	dosym ../lib/portage/bin/tbz2tool /usr/bin/tbz2tool
	dosym newins /usr/lib/portage/bin/donewins
	
	# man pages
	doman ${S}/man/*.[15]
	
	# temp dir creation
	dodir /var/tmp
	chmod 1777 ${D}/var/tmp
	touch ${D}/var/tmp/.keep
	
	#documentation
	dodoc ${S}/ChangeLog
}

pkg_postinst() {
	if [ ! -e ${ROOT}/etc/make.profile ]
	then
		cd ${ROOT}/etc
		case "$ARCH" in
		ppc )
			ln -sf ../usr/portage/profiles/default-ppc-1.0 make.profile
			;;
		sparc )
			ln -sf ../usr/portage/profiles/default-sparc-1.0 make.profile
			;;
		sparc64 )
			ln -sf ../usr/portage/profiles/default-sparc64-1.0 make.profile
			;;
		x86 )
			ln -sf ../usr/portage/profiles/default-1.0 make.profile
			;;
		esac

	fi
	local x
	#remove possible previous sandbox files that could cause conflicts
	if [ -d /usr/lib/sandbox ]; then
		if [ -f /etc/ld.so.preload ]; then
			mv /etc/ld.so.preload /etc/ld.so.preload_orig
			grep -v libsandbox.so /etc/ld.so.preload_orig > /etc/ld.so.preload
			rm /etc/ld.so.preload_orig
		fi
		
		rm -f ${ROOT}/usr/lib/portage/bin/ebuild.sh.orig
		rm -f ${ROOT}/usr/lib/portage/pym/portage.py.orig
		rm -f ${ROOT}/usr/bin/sandbox
		rm -rf ${ROOT}/usr/lib/sandbox
	fi

	#upgrade /var/db/pkg library; conditional required for build image creation
	if [ -d ${ROOT}var/db/pkg ]
	then
		cd ${ROOT}var/db/pkg
		python2.2 ${ROOT}usr/lib/portage/bin/db-update.py `find -name VIRTUAL`
	fi

	#fix cache (could contain staleness)
	if [ -d ${ROOT}var/cache/edb/dep ]
	then
		rm -rf ${ROOT}var/cache/edb/dep/*
	else
		install -d ${ROOT}var/cache/edb/dep
	fi	
}
