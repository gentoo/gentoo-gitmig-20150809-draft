# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/portage/portage-2.0.51_pre15.ebuild,v 1.1 2004/08/03 18:42:47 carpaski Exp $

IUSE="build multilib selinux"

# If the old /lib/sandbox.so is in /etc/ld.so.preload, it can
# cause everything to segfault !!
export SANDBOX_DISABLED="1"

S=${WORKDIR}/${PF}
SLOT="0"
DESCRIPTION="Portage ports system"
SRC_URI="http://gentoo.twobit.net/portage/${PF}.tar.bz2 mirror://gentoo/${PF}.tar.bz2"
HOMEPAGE="http://www.gentoo.org"

# Contact carpaski with a reason before you modify any of these.
KEYWORDS="  alpha  amd64  arm  hppa  ia64  mips  ppc  ppc64  s390  sparc  x86"
#KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sparc ~x86"

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

check_multilib() {
	use !multilib && return
	echo "main() {}" > ./check-multilib.c
	/usr/bin/gcc -m32 -o ./check-multilib ./check-multilib.c > /dev/null 2>&1
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
	cd ${S}/src; ${CC:-gcc} ${CFLAGS} tbz2tool.c -o tbz2tool
	cd ${S}/src/sandbox-1.1
	case ${ARCH} in
		"x86")
			make CFLAGS="-march=i386 -O1 -pipe" || die
			;;
		"amd64")
		check_multilib
		make CFLAGS="-O2 -pipe" HAVE_64BIT_ARCH="${MULTILIB}" || die
			;;
		*)
		make || die
			;;
	esac
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
	dosym emake /usr/lib/portage/bin/pmake
	doexe ${S}/src/tbz2tool

	#install sandbox
	cd ${S}/src/sandbox-1.1
	make clean
	make DESTDIR=${D} \
		HAVE_64BIT_ARCH="${MULTILIB}" \
		install || die "Failed to compile sandbox"

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

	install -o root -g portage -m 0755 -d "${ROOT}/etc/portage"
	install -o root -g portage -m 2775 -d "${ROOT}/etc/portage/sets"
	# u+rwx,g+srwx --- This is a secure directory for temp files.

	install -o root -g portage -m 2770 -d "${ROOT}/var/lib/portage"
	einfo "Checking ${ROOT}/var/lib/portage for bad/illegal files:"
	find "${ROOT}/var/lib/portage" ! -gid $(id -g portage) -o -perm -002 -print0 | xargs -0n 500 rm -Rvf

	OLDWORLD="${ROOT}/var/cache/edb/world"
	NEWWORLD="${ROOT}/var/lib/portage/world"

	if [ ! -L "${OLDWORLD}" ]; then
		# edb/world is not a symlink
		if [ -s "${NEWWORLD}" ]; then
			# portage/world exists
			if cmp "${OLDWORLD}" "${NEWWORLD}"; then
				# They are identical. Delete the real file and symlink it.
				rm "${OLDWORLD}"
				ln -s "../../../var/lib/portage/world" "${OLDWORLD}"
				rm /etc/portage/sets/world
				ln -s "../../../var/lib/portage/world" "/etc/portage/sets/world"
			else
				# They don't match. Complain and do nothing.
				ewarn "A world file exists in both ${NEWWORLD} and"
				ewarn "in ${OLDWORLD} --- you will need to merge these"
				ewarn "files by hand to ensure that your world is proper. For compatibility"
				ewarn "the file in /var should be a symlink to the one in /etc."
			fi
		else
			# portage/world does not yet exist.
			ewarn "Moving world file into ${NEWWORLD}"
			mv "${OLDWORLD}" "${NEWWORLD}"
			chown root:portage "${NEWWORLD}"
			chmod 0660 "${NEWWORLD}"
			ln -s "../../lib/portage/world" "${OLDWORLD}"
		fi
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
	ewarn "NOTICE: There have been changes in the location of some internal files"
	ewarn "        to better match the FHS. The changes do not directly affect users"
	ewarn "        but please be advised that changing between versions of portage"
	ewarn "        with and without these changes may introduce some inconsistencies"
	ewarn "        in package data regarding 'world' and 'virtuals' (provides)."
	echo
	einfo "        /var/cache/edb/world has moved to /var/lib/portage/world"
	einfo "        with a convenience symlink at /etc/portage/sets/world"
	echo
	einfo "        /var/cache/edb/virtuals has been deprecated and is now calculated"
	einfo "        on demand. Strictly _USER_ modifications to virtuals may go into"
	einfo "        /etc/portage/virtuals and will never be modified by portage."
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

	chmod 2775 ${ROOT}var/cache/edb/dep ${ROOT}var/cache/edb/dep/*
	chown -R root:portage ${ROOT}var/cache/edb/dep

	# we gotta re-compile these modules and deal with systems with clock skew (stale compiled files)
	python -c "import py_compile; py_compile.compile('${ROOT}usr/lib/portage/pym/emergehelp.py')"
	python -O -c "import py_compile; py_compile.compile('${ROOT}usr/lib/portage/pym/emergehelp.py')"

	python -c "import py_compile; py_compile.compile('${ROOT}usr/lib/portage/pym/cvstree.py')"
	python -O -c "import py_compile; py_compile.compile('${ROOT}usr/lib/portage/pym/cvstree.py')"

	python -c "import py_compile; py_compile.compile('${ROOT}usr/lib/portage/pym/dcdialog.py')"
	python -O -c "import py_compile; py_compile.compile('${ROOT}usr/lib/portage/pym/dcdialog.py')"

	python -c "import py_compile; py_compile.compile('${ROOT}usr/lib/portage/pym/dispatch_conf.py')"
	python -O -c "import py_compile; py_compile.compile('${ROOT}usr/lib/portage/pym/dispatch_conf.py')"

	python -c "import py_compile; py_compile.compile('${ROOT}usr/lib/portage/pym/getbinpkg.py')"
	python -O -c "import py_compile; py_compile.compile('${ROOT}usr/lib/portage/pym/getbinpkg.py')"

	python -c "import py_compile; py_compile.compile('${ROOT}usr/lib/portage/pym/output.py')"
	python -O -c "import py_compile; py_compile.compile('${ROOT}usr/lib/portage/pym/output.py')"

	python -c "import py_compile; py_compile.compile('${ROOT}usr/lib/portage/pym/portage.py')"
	python -O -c "import py_compile; py_compile.compile('${ROOT}usr/lib/portage/pym/portage.py')"

	python -c "import py_compile; py_compile.compile('${ROOT}usr/lib/portage/pym/portage_db_anydbm.py')"
	python -O -c "import py_compile; py_compile.compile('${ROOT}usr/lib/portage/pym/portage_db_anydbm.py')"

	python -c "import py_compile; py_compile.compile('${ROOT}usr/lib/portage/pym/portage_db_cpickle.py')"
	python -O -c "import py_compile; py_compile.compile('${ROOT}usr/lib/portage/pym/portage_db_cpickle.py')"

	python -c "import py_compile; py_compile.compile('${ROOT}usr/lib/portage/pym/portage_db_flat.py')"
	python -O -c "import py_compile; py_compile.compile('${ROOT}usr/lib/portage/pym/portage_db_flat.py')"

	python -c "import py_compile; py_compile.compile('${ROOT}usr/lib/portage/pym/portage_db_template.py')"
	python -O -c "import py_compile; py_compile.compile('${ROOT}usr/lib/portage/pym/portage_db_template.py')"

	python -c "import py_compile; py_compile.compile('${ROOT}usr/lib/portage/pym/portage_dep.py')"
	python -O -c "import py_compile; py_compile.compile('${ROOT}usr/lib/portage/pym/portage_dep.py')"

	python -c "import py_compile; py_compile.compile('${ROOT}usr/lib/portage/pym/xpak.py')"
	python -O -c "import py_compile; py_compile.compile('${ROOT}usr/lib/portage/pym/xpak.py')"


	if has ccache $FEATURES && has userpriv $FEATURES; then
		chown -R portage:portage /var/tmp/ccache &> /dev/null
		chmod -R g+rws /var/tmp/ccache &>/dev/null
	fi


#
# Take a shot at fixing the world file...
# This finds all specific-version ebuilds without modifiers.
#
	addwrite ${ROOT}var/cache/edb/
	python -c "
import portage
world = portage.grabfile('${ROOT}var/cache/edb/world')
newlist = []

for x in world:
	try:
		if portage.catpkgsplit(x) and (x == portage.dep_getcpv(x)):
			newlist.append('='+x)
			continue
	except:
		pass
	newlist.append(x)

if newlist and (len(newlist) == len(world)):
	myworld=open('${ROOT}var/cache/edb/world','w')
	for x in newlist:
		myworld.write(x+'\\n')

	myworld.close()

"

	for X in ${ROOT}etc/._cfg????_make.globals; do
		# Overwrite the globals file automatically.
		[ -e "${X}" ] && mv -f "${X}" "${ROOT}etc/make.globals"
	done
}
