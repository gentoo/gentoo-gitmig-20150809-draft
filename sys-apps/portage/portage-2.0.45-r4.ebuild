# Copyright 1999-2002 Gentoo Technologies, Inc. 
# Distributed under the terms of the GNU General Public License v2 
# $Header: /var/cvsroot/gentoo-x86/sys-apps/portage/portage-2.0.45-r4.ebuild,v 1.1 2002/12/11 15:28:57 carpaski Exp $

IUSE="build"

# If the old /lib/sandbox.so is in /etc/ld.so.preload, it can
# cause everything to segfault !!
export SANDBOX_DISABLED="1"

S=${WORKDIR}/${PF}
SLOT="0"
DESCRIPTION="Portage ports system"
SRC_URI="http://gentoo.twobit.net/portage/${PF}.tar.bz2"
HOMEPAGE="http://www.gentoo.org"
KEYWORDS="x86 ppc sparc alpha"
LICENSE="GPL-2"
RDEPEND="!build? ( >=sys-apps/fileutils-4.1.8 dev-python/python-fchksum >=dev-lang/python-2.2.1 sys-apps/debianutils >=sys-apps/bash-2.05a )"

src_unpack() {
	cd ${WORKDIR}
	echo tar xjf ${DISTDIR}/${PF}.tar.bz2
	tar xjf ${DISTDIR}/${PF}.tar.bz2 || die "No portage tarball in distfiles."
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
	doins etc-update.conf
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
	dosym ../lib/portage/bin/etc-update /usr/sbin/etc-update
	
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

	#disable global sandbox if it's active (it's been deprecated)
	if [ -f /etc/ld.so.preload ] ; then
		cp /etc/ld.so.preload ${T}
		grep -v libsandbox ${T}/ld.so.preload > /etc/ld.so.preload
	fi
	
	#remove possible previous sandbox files that could cause conflicts
	if [ -d /usr/lib/sandbox ]; then
		rm -f ${ROOT}/usr/lib/portage/bin/ebuild.sh.orig
		rm -f ${ROOT}/usr/lib/portage/pym/portage.py.orig
		rm -f ${ROOT}/usr/bin/sandbox
		rm -rf ${ROOT}/usr/lib/sandbox
	fi
	
	#yank old cache files
	if [ -d /var/cache/edb ]
	then
		rm -f /var/cache/edb/xcache.p
		rm -f /var/cache/edb/mtimes
	fi

	#fix cache (could contain staleness)
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
		install -d -m0755 ${ROOT}var/cache/edb
		install -d -m2775 -o root -g wheel ${ROOT}var/cache/edb/dep
	fi
	rm -f ${ROOT}usr/lib/python2.2/site-packages/portage.py[co]
	rm -f ${ROOT}usr/lib/python2.2/site-packages/output.py[co]
	chmod 2775 ${ROOT}var/cache/edb/dep ${ROOT}var/cache/edb/dep/*
	chown -R root.wheel ${ROOT}var/cache/edb/dep
	
	# we gotta re-compile these modules and deal with systems with clock skew (stale compiled files)
	python -c "import py_compile; py_compile.compile('${ROOT}usr/lib/python2.2/site-packages/portage.py')" || die
	python -O -c "import py_compile; py_compile.compile('${ROOT}usr/lib/python2.2/site-packages/portage.py')" || die
	python -c "import py_compile; py_compile.compile('${ROOT}usr/lib/python2.2/site-packages/output.py')" || die
	python -O -c "import py_compile; py_compile.compile('${ROOT}usr/lib/python2.2/site-packages/output.py')" || die

	# Changes in the size of auxdbkeys can cause aux_get() problems.
	echo -n ">>> Clearing invalid entries in dependancy cache..."
	cd ${ROOT}var/cache/edb/dep
	# 2>&1 >/dev/null <---- Kills stdout, replaces it with stderr
	AUXDBKEYLEN="$(python -c 'import portage,sys; sys.stderr.write(str(len(portage.auxdbkeys)))' 2>&1 >/dev/null)"
	find ${ROOT}var/cache/edb/dep -type f -exec wc -l {} \; | egrep -v "^ *${AUXDBKEYLEN}" | sed 's:^ \+[0-9]\+ \+\([^ ]\+\)$:\1:' 2>/dev/null | xargs -n 50 -r rm -f
	echo " ...done!"

	# Fix the long(time.time()) problems users might have.
	echo -n "Looking for problems in CONTENTS files... "
	for FILE in $(find ${ROOT}/var/db/pkg -name CONTENTS); do
		if egrep -q '^obj.*L$' ${FILE}; then
			echo ${FILE}
			mv ${FILE} ${FILE}.orig
			sed '/^obj.*L$/s/L$//' ${FILE}.orig > ${FILE}
			rm ${FILE}.orig
		fi
	done
	echo "...done!"
	
	echo
	echo
	einfo "WARNING: The default behavior for 'emerge rsync' is to have --clean enabled."
	einfo "Please back up any modified files in your Portage tree before emerge rsync."
	echo
	einfo "You may want to move any custom ebuilds to a new directory, and then set"
	einfo "PORTDIR_OVERLAY (in /etc/make.conf) to point to this directory.  For example,"
	einfo "make a /usr/portage.local/sys-apps/foo directory and put your ebuild in there."
	einfo "Then set PORTDIR_OVERLAY=\"/usr/portage.local\"  Portage should see your"
	einfo "personal ebuilds.  NOTE: PORTDIR_OVERLAY support is *beta* code; it may not"
	einfo "work correctly yet."
	echo
	einfo "NOTICE: PLEASE update your make.globals. All user changes to varaibles"
	einfo "in make.globals should be placed in make.conf. DO NOT MODIFY make.globals."
	einfo "AUTOCLEAN's default has been changed to 'yes' to ensure that libraries are"
	einfo "treated properly during merges. NOT updating make.globals may result in you"
	einfo "experiencing missing symlinks, failed compiles, and the inability to log in"
	einfo "to your system. Running 'ldconfig' should fix the majority of these problems,"
	einfo "but you may need to boot from a gentoo cd and execute the following:"
	einfo "chroot /mnt/gentoo /sbin/ldconfig"
	echo
	echo
	}
