# Copyright 1999-2002 Gentoo Technologies, Inc. 
# Distributed under the terms of the GNU General Public License v2 
# $Header: /var/cvsroot/gentoo-x86/sys-apps/portage/portage-2.0.33_p1.ebuild,v 1.1 2002/08/31 08:36:10 danarmak Exp $

# If the old /lib/sandbox.so is in /etc/ld.so.preload, it can
# cause everything to segfault !!
export SANDBOX_DISABLED="1"

S=${WORKDIR}/${P}
SLOT="0"
DESCRIPTION="Portage ports system"
SRC_URI=""
HOMEPAGE="http://www.gentoo.org"
KEYWORDS="x86 ppc sparc sparc64"
LICENSE="GPL-2"
RDEPEND="!build? ( >=sys-apps/fileutils-4.1.8 dev-python/python-fchksum >=dev-lang/python-2.2.1 sys-apps/debianutils >=sys-apps/bash-2.05a )"

src_unpack() {
	#We are including the Portage bzipped tarball on CVS now, so that if a person's
	#emerge gets hosed, they are not completely stuck.
	cd ${WORKDIR}; tar xjf ${FILESDIR}/portage-${PV}.tar.bz2
}

src_compile() {                           
	cd ${S}/src; gcc ${CFLAGS} tbz2tool.c -o tbz2tool
	cd ${S}/src/sandbox-1.1
	if [ "${ARCH}" = "x86" ]; then
		make CFLAGS="-march=i386 -O1 -pipe" || die
	else
		make || die
	fi
}

src_install() {
	#config files
	cd ${S}/cnf
	insinto /etc
	case "$ARCH" in
		ppc )
		newins make.globals.ppc make.globals
		newins make.conf.ppc make.conf
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


	#binaries, libraries and scripts
	dodir /usr/lib/portage/bin
	cd ${S}/bin
	exeinto /usr/lib/portage/bin
	doexe *
	dosym emake /usr/lib/portage/bin/pmake
	doexe ${S}/src/tbz2tool
	
	#install sandbox
	cd ${S}/src/sandbox-1.1
	make DESTDIR=${D} install || die

	#symlinks
	dodir /usr/bin /usr/sbin
	dosym ../lib/portage/bin/emerge /usr/bin/emerge
	dosym ../lib/portage/bin/pkgmerge /usr/sbin/pkgmerge
	dosym ../lib/portage/bin/ebuild /usr/sbin/ebuild
	dosym ../lib/portage/bin/ebuild.sh /usr/sbin/ebuild.sh
	#dosym /usr/lib/portage/bin/portage-maintain /usr/sbin/portage-maintain
	dosym ../lib/portage/bin/env-update /usr/sbin/env-update
	dosym ../lib/portage/bin/xpak /usr/bin/xpak
	dosym ../lib/portage/bin/repoman /usr/bin/repoman
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

	#fix cache (could contain staleness)
	if [ ! -d ${ROOT}var/cache/edb/dep/sys-apps ]
	then
		if [ ! -d ${ROOT}var/cache/edb/dep ]
		then
			#upgrade /var/db/pkg library; conditional required for build image creation
			if [ -d ${ROOT}var/db/pkg ]
			then
				echo ">>> Database upgrade..."
				cd ${ROOT}var/db/pkg
				for x in *
				do
					[ ! -d "$x" ] && continue
					#go into each category directory so we don't overload the python2.2 command-line
					cd $x
					#fix silly output from this command (hack)
					python2.2 ${ROOT}usr/lib/portage/bin/db-update.py `find -name VIRTUAL` > /dev/null
				cd ..
				done
				echo ">>> Database upgrade complete."
				#remove old virtual directory to prevent virtual deps from getting messed-up
				[ -d ${ROOT}var/db/pkg/virtual ] && rm -rf ${ROOT}var/db/pkg/virtual
			fi
		fi
		install -d -m0755 ${ROOT}var/cache/edb
		install -d -m4755 -o root -g wheel ${ROOT}var/cache/edb/dep
	fi
	rm -f ${ROOT}usr/lib/python2.2/site-packages/portage.py[co]
	chmod 4755 ${ROOT}var/cache/edb/dep ${ROOT}var/cache/edb/dep/*
	chown -R root.wheel ${ROOT}var/cache/edb/dep
	
	# we gotta re-compile these modules and deal with systems with clock skew (stale compiled files)
	python -c "import py_compile; py_compile.compile('${ROOT}usr/lib/python2.2/site-packages/portage.py')" || die
	python -O -c "import py_compile; py_compile.compile('${ROOT}usr/lib/python2.2/site-packages/portage.py')" || die
	
	echo
	echo
	einfo "WARNING: The default behavior for 'emerge rsync' is to have --clean enabled."
	einfo "Please back up any modified files in your Portage tree before running emerge"
	einfo "rsync."
	echo
	einfo "You may want to move any custom ebuilds to a new directory, and then set"
	einfo "PORTDIR_OVERLAY (in /etc/make.conf) to point to this directory.  For example,"
	einfo "make a /usr/portage.local/sys-apps/foo directory and put your ebuild in there."
	einfo "Then set PORTDIR_OVERLAY=\"/usr/portage.local\"  Portage should see your"
	einfo "personal ebuilds.  NOTE: PORTDIR_OVERLAY support is *beta* code; it may not"
	einfo "work correctly yet."
	echo
	echo
	}
