# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/portage/portage-2.0.51-r2.ebuild,v 1.5 2004/11/05 19:44:09 mr_bones_ Exp $

inherit flag-o-matic toolchain-funcs

# If the old /lib/sandbox.so is in /etc/ld.so.preload, it can
# cause everything to segfault !!
export SANDBOX_DISABLED="1"

DESCRIPTION="The Portage Package Management System (Similar to BSD's ports). The primary package management and distribution system for Gentoo."
HOMEPAGE="http://www.gentoo.org/"
SRC_URI="http://zarquon.twobit.net/gentoo/portage/${PF}.tar.bz2 http://gentoo.twobit.net/portage/${PF}.tar.bz2 mirror://gentoo/${PF}.tar.bz2"
RESTRICT="nosandbox sandbox"

LICENSE="GPL-2"
SLOT="0"
IUSE="build selinux"
# Contact carpaski with a reason before you modify any of these.
KEYWORDS="  alpha  amd64  arm  hppa  ia64  mips  ppc  ppc-macos  ppc64  s390  sparc  x86"
#KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc-macos ~ppc64 ~s390 ~sparc ~x86"

RDEPEND="selinux? ( dev-python/python-selinux )
	!build? (
		>=sys-apps/sed-4.0.5
		dev-python/python-fchksum
		>=dev-lang/python-2.2.1
		sys-apps/debianutils
		>=app-shells/bash-2.05a
	)"

S=${WORKDIR}/${PF}

python_version() {
	local tmpstr="$(/usr/bin/python -V 2>&1 )"
	export PYVER_ALL="${tmpstr#Python }"

	export PYVER_MAJOR=$(echo ${PYVER_ALL} | cut -d. -f1)
	export PYVER_MINOR=$(echo ${PYVER_ALL} | cut -d. -f2)
	export PYVER_MICRO=$(echo ${PYVER_ALL} | cut -d. -f3-)
	export PYVER="${PYVER_MAJOR}.${PYVER_MINOR}"
}

check_multilib() {
	has_m32
	if [ "$?" == 0 ]; then
		einfo "Found valid multilib environment."
		einfo "Building with multilib support."
		export MULTILIB="1"
	else
		ewarn "No valid multilib environment found!"
		ewarn "Building without multilib support. If"
		ewarn "you want to have multilib support,"
		ewarn "emerge gcc with \"multilib\" in your"
		ewarn "useflags."
		sleep 5
	fi
}

src_unpack() {
	unpack ${A}
	cd ${S}
}

src_compile() {
	cd ${S}/src; $(tc-getCC) ${CFLAGS} tbz2tool.c -o tbz2tool
	cd ${S}/src/sandbox-1.1
	case ${ARCH} in
		"x86")
			make CFLAGS="-march=i386 -O1 -pipe" || die
			;;
		"amd64")
			check_multilib
			make CFLAGS="-O1 -pipe" HAVE_64BIT_ARCH="${MULTILIB}" || die
			;;
		*)
			if useq macos || useq ppc-macos || useq x86-fbsd; then
				ewarn "NOT BUILDING SANDBOX ON $ARCH"
			else
				make CFLAGS="-O1 -pipe" || die
			fi
			;;
	esac
	cd ${S}/bin
}

src_install() {
	#config files
	cd ${S}/cnf
	insinto /etc
	if [ -f "make.globals.${ARCH}" ]; then
		newins make.globals.${ARCH} make.globals
		newins make.conf.${ARCH} make.conf.example
	else
		eerror ""
		eerror "Portage does not have an arch-specific configuration for this arch."
		eerror "Please notify the arch maintainer about this issue. Using generic."
		eerror ""
		sleep 3
		doins  make.globals
		newins make.conf make.conf.example
	fi

	doins etc-update.conf dispatch-conf.conf

	#python modules
	if [ -x "$(type -p python2.2)" ] || [ -x /usr/bin/python2.2 ]; then
		cd ${S}/src/python-missingos
		chmod +x setup.py
		if [ -x "$(type -p python2.3)" ]; then
			./setup.py install --root ${D} || eerror "Failed to install missingos module -- python2.2 broken?"
		else
			./setup.py install --root ${D} || die "Failed to install missingos module"
		fi
	fi


	dodir /usr/lib/portage/pym
	cd ${S}/pym
	insinto /usr/lib/portage/pym
	doins *.py

	#binaries, libraries and scripts
	dodir /usr/lib/portage/bin
	cd ${S}/bin
	exeinto /usr/lib/portage/bin
	doexe *
	doexe ${S}/src/tbz2tool

	if use macos || use ppc-macos || use x86-fbsd; then
		ewarn "Not installing sandbox on ${ARCH}"
	else
		#install sandbox
		cd ${S}/src/sandbox-1.1
		if [ "$ARCH" == "amd64" ]; then
			check_multilib
			make DESTDIR="${D}" HAVE_64BIT_ARCH="${MULTILIB}" install || \
			die "Failed to compile sandbox"
		else
			make DESTDIR="${D}" install || \
			die "Failed to compile sandbox"
		fi
	fi

	#symlinks
	dodir /usr/bin /usr/sbin
	dosym ../lib/portage/bin/emerge /usr/bin/emerge
	dosym ../lib/portage/bin/pkgmerge /usr/sbin/pkgmerge
	dosym ../lib/portage/bin/ebuild /usr/sbin/ebuild
	dosym ../lib/portage/bin/ebuild.sh /usr/sbin/ebuild.sh

	dosym ../lib/portage/bin/etc-update /usr/sbin/etc-update
	dosym ../lib/portage/bin/dispatch-conf /usr/sbin/dispatch-conf
	dosym ../lib/portage/bin/archive-conf /usr/sbin/archive-conf
	dosym ../lib/portage/bin/fixpackages /usr/sbin/fixpackages

	dosym ../lib/portage/bin/env-update /usr/sbin/env-update
	dosym ../lib/portage/bin/xpak /usr/bin/xpak
	dosym ../lib/portage/bin/repoman /usr/bin/repoman
	dosym ../lib/portage/bin/tbz2tool /usr/bin/tbz2tool
	dosym ../lib/portage/bin/portageq /usr/bin/portageq

	dosym ../lib/portage/bin/g-cpan.pl /usr/bin/g-cpan.pl
	dosym ../lib/portage/bin/quickpkg /usr/bin/quickpkg
	dosym ../lib/portage/bin/regenworld /usr/sbin/regenworld
	dosym ../lib/portage/bin/emerge-webrsync /usr/sbin/emerge-webrsync

	dosym newins /usr/lib/portage/bin/donewins

	# man pages
	doman ${S}/man/*.[0-9]

	# temp dir creation
	dodir /var/tmp
	chmod 1777 ${D}/var/tmp
	touch ${D}/var/tmp/.keep

	#documentation
	dodoc ${S}/ChangeLog
}


pkg_preinst() {
	if has livecvsportage $FEATURES; then
		if [ "$ROOT" == "/" ]; then
			rm -Rf "${IMAGE}"/usr/lib/portage/pym/*

			mv "${IMAGE}"/usr/lib/portage/bin/{sandbox,tbz2tool} ${T}
			rm -Rf "${IMAGE}"/usr/lib/portage/bin/*
			mv "${T}"/{sandbox,tbz2tool} "${IMAGE}"/usr/lib/portage/bin/
		fi
	fi

	# If we return true, then we don't have HIGHEST_PROTOCOL.
	# We need to modify the source for this case.
	if python -c "import cPickle,sys; sys.exit('HIGHEST_PROTOCOL' in dir(cPickle))"; then
		sed -i "s:cPickle.HIGHEST_PROTOCOL:-1:" "${IMAGE}"/usr/lib/portage/pym/*.py
	fi
}

pkg_postinst() {
	local x

	[ -f "${ROOT}etc/make.conf" ] || touch ${ROOT}etc/make.conf

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

	install -o root -g portage -m 0755 -d "${ROOT}/etc/portage"
	install -o root -g portage -m 2775 -d "${ROOT}/etc/portage/sets"
	# u+rwx,g+srwx --- This is a secure directory for temp files.

	install -o root -g portage -m 2770 -d "${ROOT}/var/lib/portage"
	einfo "Checking ${ROOT}/var/lib/portage for bad/illegal files:"
	find "${ROOT}/var/lib/portage" ! -group portage -o -perm -002 -print0 | ${XARGS} -0n 500 rm -Rvf

	OLDWORLD="${ROOT}/var/cache/edb/world"
	NEWWORLD="${ROOT}/var/lib/portage/world"

	if [ ! -f "${NEWWORLD}" ]; then
		cp "${OLDWORLD}" "${NEWWORLD}" && \
		rm -f "${OLDWORLD}" && \
		ln ../../lib/portage/world "${NEWWORLD}"
	fi

	if [ ! -f "/etc/portage/package.mask" ]; then
	  if [ -f "/etc/portage/profile/package.mask" ]; then
			ln /etc/portage/profile/package.mask /etc/portage/package.mask
			einfo "/etc/portage/profile/package.mask is now /etc/portage/package.mask"
			einfo "a hardlink has been created to the new location if it exists in profiles"
			einfo "already."
			echo
		fi
	fi
	echo

	einfo "Feature additions are noted in help and make.conf descriptions."
	echo
	einfo "Update configs using 'etc-update' please. Maintaining current configs"
	einfo "for portage and other system packages is fairly important for the"
	einfo "continued health of your system."
	echo
	ewarn "NOTICE: There have been changes in the location of some internal files"
	ewarn "        to better match the FHS. The changes do not directly affect users"
	ewarn "        but please be advised that changing between versions of portage"
	ewarn "        with and without these changes may introduce some inconsistencies"
	ewarn "        in package data regarding 'world' and 'virtuals' (provides)."
	echo
	einfo "        /var/cache/edb/world has moved to /var/lib/portage/world"
	echo
	einfo "        /var/cache/edb/virtuals has been deprecated and is now calculated"
	einfo "        on demand. Strictly _USER_ modifications to virtuals may go into"
	einfo "        /etc/portage/profile/virtuals and will not be modified by portage."
	echo

	if [ -z "$PORTAGE_TEST" ]; then
		for TICKER in 1 2 3 4 5 6 7 8 9 10; do
			echo -ne "\a" ; sleep 0.$(( $RANDOM % 9 + 1)) &>/dev/null ; sleep 0,$(( $RANDOM % 9 + 1)) &>/dev/null
		done
		sleep 5

		# Kill the existing counter and generate a new one.
		echo -n "Recalculating the counter... "
		mv /var/cache/edb/counter /var/cache/edb/counter.old
		python -c 'import sys; sys.path = ["/usr/lib/portage/pym"]+sys.path; import portage; portage.db["/"]["vartree"].dbapi.counter_tick("/")' &>/dev/null
		if [ -f /var/cache/edb/counter ] ; then
			echo "Counter updated successfully."
			rm -f /var/cache/edb/counter.old
		else
			echo "FAILED to update counter."
			ls -l /var/cache/edb/counter.old
			echo "!!! This is a problem."
			mv /var/cache/edb/counter.old /var/cache/edb/counter
		fi
	fi # PORTAGE_TESTING

	if [ ! -d "${ROOT}var/cache/edb/dep" ]
	then
		install -d -m2755 ${ROOT}var/cache/edb
		install -d -m2775 -o root -g portage ${ROOT}var/cache/edb/dep
	fi

	# Old place of install
	rm -f ${ROOT}usr/lib/python2.2/site-packages/portage.py[co]
	rm -f ${ROOT}usr/lib/python2.2/site-packages/xpak.py[co]
	rm -f ${ROOT}usr/lib/python2.2/site-packages/output.py[co]
	rm -f ${ROOT}usr/lib/python2.2/site-packages/cvstree.py[co]
	rm -f ${ROOT}usr/lib/python2.2/site-packages/getbinpkg.py[co]
	rm -f ${ROOT}usr/lib/python2.2/site-packages/emergehelp.py[co]
	rm -f ${ROOT}usr/lib/python2.2/site-packages/dispatch_conf.py[co]

	# New old place of install
	rm -f ${ROOT}usr/lib/portage/pym/*.py[co]

	# we gotta re-compile these modules and deal with systems with clock skew (stale compiled files)
	einfo "Compiling python modules..."
	python -c 'import compileall; compileall.compile_path()' &> /dev/null
	python -c "import compileall; compileall.compile_dir('${ROOT}usr/lib/portage/pym')" &> /dev/null

	if has ccache $FEATURES && has userpriv $FEATURES; then
		chown -R portage:portage /var/tmp/ccache &> /dev/null
		chmod -R g+rws /var/tmp/ccache &>/dev/null
	fi

	if [ -d "${ROOT}usr/portage/distfiles" ]; then
		find "${ROOT}usr/portage/distfiles" -type f -maxdepth 1 -print0 | \
		${XARGS} -0 -n 500 chgrp portage &> /dev/null

		find "${ROOT}usr/portage/distfiles" -type f -maxdepth 1 -print0 | \
		${XARGS} -0 -n 500 chmod 0644 &> /dev/null

		find "${ROOT}usr/portage/distfiles/cvs-src" -type f -maxdepth 1 -print0 | \
		${XARGS} -0 -n 500 chown portage &> /dev/null

		find "${ROOT}usr/portage/distfiles/cvs-src" -type f -maxdepth 1 -print0 | \
		${XARGS} -0 -n 500 chmod u+w &> /dev/null

		chmod 2775 "${ROOT}usr/portage/distfiles"
		chmod 2775 "${ROOT}usr/portage/distfiles/cvs-src"
	fi
	if [ -d "${ROOT}/${PORTDIR}/distfiles" ]; then
		find "${ROOT}/${PORTDIR}/distfiles" -type f -maxdepth 1 -print0 | \
		${XARGS} -0 -n 500 chgrp portage &> /dev/null

		find "${ROOT}/${PORTDIR}/distfiles" -type f -maxdepth 1 -print0 | \
		${XARGS} -0 -n 500 chmod 0644 &> /dev/null

		find "${ROOT}/${PORTDIR}/distfiles/cvs-src" -type f -maxdepth 1 -print0 | \
		${XARGS} -0 -n 500 chown portage &> /dev/null

		find "${ROOT}/${PORTDIR}/distfiles/cvs-src" -type f -maxdepth 1 -print0 | \
		${XARGS} -0 -n 500 chmod u+w &> /dev/null

		chmod 2775 "${ROOT}/${PORTDIR}/distfiles"
		chmod 2775 "${ROOT}/${PORTDIR}/distfiles/cvs-src"
	fi

	chown -R root:portage ${ROOT}var/cache/edb
	find ${ROOT}var/cache/edb -type f -print0 | ${XARGS} -0 -n 500 chmod 664

	for X in ${ROOT}etc/._cfg????_make.globals; do
		# Overwrite the globals file automatically.
		[ -e "${X}" ] && mv -f "${X}" "${ROOT}etc/make.globals"
	done

	einfo "You may run 'emerge metadata' to perform cache updates if you have"
	einfo "changed versions of portage. This will provide a fairly dramatic"
	einfo "speedup. Alternatively, you may 'emerge sync' if it has been more"
	einfo "than 30 minutes since your last sync."
}
