# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/portage/portage-2.0.50_pre14.ebuild,v 1.1 2004/01/12 21:27:38 carpaski Exp $

IUSE="build"

# If the old /lib/sandbox.so is in /etc/ld.so.preload, it can
# cause everything to segfault !!
export SANDBOX_DISABLED="1"

S=${WORKDIR}/${PF}
SLOT="0"
DESCRIPTION="Portage ports system"
SRC_URI="http://gentoo.twobit.net/portage/${PF}.tar.bz2 mirror://gentoo/${PF}.tar.bz2"
HOMEPAGE="http://www.gentoo.org"

# Contact carpaski with a reason before you modify any of these.
#KEYWORDS="alpha amd64 arm hppa ia64 mips ppc ppc64 sparc x86"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86"

LICENSE="GPL-2"
RDEPEND="!build? ( >=sys-apps/sed-4.0.5 dev-python/python-fchksum >=dev-lang/python-2.2.1 sys-apps/debianutils >=app-shells/bash-2.05a ) selinux? ( dev-python/python-selinux )"

python_version() {
	local tmpstr="$(/usr/bin/python -V 2>&1 )"
	export PYVER_ALL="${tmpstr#Python }"

	export PYVER_MAJOR=$(echo ${PYVER_ALL} | cut -d. -f1)
	export PYVER_MINOR=$(echo ${PYVER_ALL} | cut -d. -f2)
	export PYVER_MICRO=$(echo ${PYVER_ALL} | cut -d. -f3-)
	export PYVER="${PYVER_MAJOR}.${PYVER_MINOR}"
}

src_unpack() {
	unpack ${A}
	cd ${S}
}

src_compile() {
	cd ${S}/src; ${CC:-gcc} ${CFLAGS} tbz2tool.c -o tbz2tool
	cd ${S}/src/sandbox-1.1
	if [ "${ARCH}" = "x86" ]; then
		make CFLAGS="-march=i386 -O1 -pipe" || die
	else
		make || die
	fi
	cd ${S}/bin
}

src_install() {
	#config files
	cd ${S}/cnf
	insinto /etc
	case "$ARCH" in
		alpha )
		newins make.globals.alpha make.globals
		newins make.conf.alpha make.conf
		;;
		arm )
		newins make.globals.arm make.globals
		newins make.conf.arm make.conf
		;;
		hppa )
		newins make.globals.hppa make.globals
		newins make.conf.hppa make.conf
		;;
		mips )
		newins make.globals.mips make.globals
		newins make.conf.mips make.conf
		;;
		ppc )
		newins make.globals.ppc make.globals
		newins make.conf.ppc make.conf
		;;
		sparc )
		newins make.globals.sparc make.globals
		newins make.conf.sparc make.conf
		;;
		* )
		doins make.globals make.conf
		;;
	esac

	#This special handling of make.conf is required for catalyst
	#to function properly.
	mv ${D}/etc/make.conf ${D}/etc/make.conf.example

	doins etc-update.conf dispatch-conf.conf

	#python modules
	if [ -x "$(type -p python2.2)" ] || [ -x /usr/bin/python2.2 ]; then
		cd ${S}/src/python-missingos
		chmod +x setup.py
		./setup.py install --root ${D} || die "Failed to install missingos module"
	fi


	dodir /usr/lib/portage/pym
	cd ${S}/pym
	insinto /usr/lib/portage/pym
	doins *.py ../bin/emergehelp.py


	#binaries, libraries and scripts
	dodir /usr/lib/portage/bin
	cd ${S}/bin
	exeinto /usr/lib/portage/bin
	doexe *
	dosym emake /usr/lib/portage/bin/pmake
	doexe ${S}/src/tbz2tool

	#install sandbox
	cd ${S}/src/sandbox-1.1
	make clean
	make DESTDIR=${D} install || die "Failed to compile sandbox"

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
	doman ${S}/man/*.[15]

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

	if [ ! -f "/etc/portage/package.mask" ]; then
	  if [ -f "/etc/portage/profiles/package.mask" ]; then
			ln /etc/portage/profiles/package.mask /etc/portage/package.mask
			einfo "/etc/portage/profiles/package.mask is now /etc/portage/package.mask"
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

	if [ -z "$PORTAGE_TEST" ]; then
		for TICKER in 1 2 3 4 5; do
			# Double beep here.
			echo -ne "\a" ; sleep 0.1 &>/dev/null ; sleep 0,1 &>/dev/null
			echo -ne "\a" ; sleep 1
		done
		sleep 8

		# Kill the existing counter and generate a new one.
		echo -n "Recalculating the counter... "
		mv /var/cache/edb/counter /var/cache/edb/counter.old
		python -c 'import sys; sys.path = ["/usr/lib/portage/pym"]+sys.path; import portage; portage.db["/"]["vartree"].dbapi.counter_tick("/")' &>/dev/null
		if [ -f /var/cache/edb/counter ] ; then
			echo "Counter updated successfully."
			rm -f /var/cache/edb/counter.old
		else
			echo "FAILED to update counter."
			echo "!!! This is a problem."
			mv /var/cache/edb/counter.old /var/cache/edb/counter
		fi

		# Changes in the size of auxdbkeys can cause aux_get() problems.
		echo -n ">>> Clearing invalid entries in dependency cache..."
		cd ${ROOT}var/cache/edb/dep
		#Nick, I changed the following to deal with situations where stderr spits out stuff like: "!!! CANNOT IMPORT FTPLIB:"
		#which causes an infinite loop. (drobbins)
		python -c 'import sys; sys.path = ["/usr/lib/portage/pym"]+sys.path; import portage; myf=open("/tmp/auxdbkl","w"); myf.write(str(len(portage.auxdbkeys))); myf.close()'
		AUXDBKEYLEN=`cat /tmp/auxdbkl`
		rm -f /tmp/auxdbkl
		find ${ROOT}var/cache/edb/dep -type f -exec wc -l {} \; | egrep -v "^ *${AUXDBKEYLEN}" | sed 's:^ \+[0-9]\+ \+\([^ ]\+\)$:\1:' 2>/dev/null | xargs -n 50 -r rm -f
		echo " ...done!"
	fi # PORTAGE_TESTING

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
				#go into each category directory so we don't overload the python command-line
				cd $x
				#fix silly output from this command (hack)
				python ${ROOT}usr/lib/portage/bin/db-update.py `find -name VIRTUAL` > /dev/null
			cd ..
			done
			echo ">>> Database upgrade complete."
			#remove old virtual directory to prevent virtual deps from getting messed-up
			[ -d ${ROOT}var/db/pkg/virtual ] && rm -rf ${ROOT}var/db/pkg/virtual
		fi
		install -d -m0755 ${ROOT}var/cache/edb
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

	chmod 2775 ${ROOT}var/cache/edb/dep ${ROOT}var/cache/edb/dep/*
	chown -R root:portage ${ROOT}var/cache/edb/dep

	# we gotta re-compile these modules and deal with systems with clock skew (stale compiled files)
	python -c "import py_compile; py_compile.compile('${ROOT}usr/lib/portage/pym/portage.py')"
	python -O -c "import py_compile; py_compile.compile('${ROOT}usr/lib/portage/pym/portage.py')"
	python -c "import py_compile; py_compile.compile('${ROOT}usr/lib/portage/pym/output.py')"
	python -O -c "import py_compile; py_compile.compile('${ROOT}usr/lib/portage/pym/output.py')"
	python -c "import py_compile; py_compile.compile('${ROOT}usr/lib/portage/pym/cvstree.py')"
	python -O -c "import py_compile; py_compile.compile('${ROOT}usr/lib/portage/pym/cvstree.py')"
	python -c "import py_compile; py_compile.compile('${ROOT}usr/lib/portage/pym/getbinpkg.py')"
	python -O -c "import py_compile; py_compile.compile('${ROOT}usr/lib/portage/pym/getbinpkg.py')"
	python -c "import py_compile; py_compile.compile('${ROOT}usr/lib/portage/pym/dispatch_conf.py')"
	python -O -c "import py_compile; py_compile.compile('${ROOT}usr/lib/portage/pym/dispatch_conf.py')"
	python -c "import py_compile; py_compile.compile('${ROOT}usr/lib/portage/pym/emergehelp.py')"
	python -O -c "import py_compile; py_compile.compile('${ROOT}usr/lib/portage/pym/emergehelp.py')"

	if has ccache $FEATURES && has userpriv $FEATURES; then
		chown -R portage:portage /var/tmp/ccache &> /dev/null
		chmod -R g+rws /var/tmp/ccache &>/dev/null
	fi

	for X in ${ROOT}etc/._cfg????_make.globals; do
		# Overwrite the globals file automatically.
		[ -e "${X}" ] && mv -f "${X}" "${ROOT}etc/make.globals"
	done
}
