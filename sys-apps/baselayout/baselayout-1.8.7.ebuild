# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/baselayout/baselayout-1.8.7.ebuild,v 1.1 2004/04/07 17:41:57 agriffis Exp $

IUSE="bootstrap build livecd static selinux"

SV="1.4.4"
SVREV=
# SysvInit version
SVIV="2.84"

S="${WORKDIR}/rc-scripts-${SV}${SVREV}"
S2="${WORKDIR}/sysvinit-${SVIV}/src"
DESCRIPTION="Base layout for Gentoo Linux (incl. initscripts and sysvinit)"
SRC_URI="ftp://ftp.cistron.nl/pub/people/miquels/software/sysvinit-${SVIV}.tar.gz
	ftp://sunsite.unc.edu/pub/Linux/system/daemons/init/sysvinit-${SVIV}.tar.gz
	mirror://gentoo/rc-scripts-${SV}${SVREV}.tar.bz2"
HOMEPAGE="http://www.gentoo.org/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64 ~ppc ~sparc ~alpha ~mips ~hppa ~ia64 ~ppc64 ~s390"

DEPEND="virtual/os-headers
	selinux? ( sys-libs/libselinux )"

# This version of baselayout needs gawk in /bin, but as we do not have
# a c++ compiler during bootstrap, we cannot depend on it if "bootstrap"
# or "build" are in USE.
RDEPEND="${DEPEND}
	!build? ( !bootstrap? ( >=sys-apps/gawk-3.1.1-r2 ) )
	!build? ( !bootstrap? ( >=sys-apps/util-linux-2.11z-r6 ) )"

src_unpack() {

	unpack ${A}

	# Fix CFLAGS for sysvinit stuff
	cd ${S2}
	cp Makefile Makefile.orig
	sed -e "s:-O2:${CFLAGS}:" Makefile.orig >Makefile || die
	if [ -n "`use build`" ]
	then
		# Do not build sulogin, as it needs libcrypt which is not in the
		# build image.
		cp Makefile Makefile.orig
		sed -e 's:PROGS\t= init halt shutdown killall5 runlevel sulogin:PROGS\t= init halt shutdown killall5 runlevel:g' \
			Makefile.orig > Makefile || die
	fi
	# Selinux
	use selinux && epatch ${FILESDIR}/sysvinit-${SVIV}-selinux.patch

	cd ${S}/etc

	# Fix Sparc specific stuff
	if [ "${ARCH}" = "sparc" ]
	then
		cp rc.conf rc.conf.orig
		sed -e 's:KEYMAP="us":KEYMAP="sunkeymap":' rc.conf.orig >rc.conf || die
		rm -f rc.conf.orig
	fi

	# Add serial console ...
	case ${ARCH} in
		sparc|mips|hppa)
			cp inittab inittab.orig
			sed -e 's"# TERMINALS"# SERIAL CONSOLE\nc0:12345:respawn:/sbin/agetty 9600 ttyS0 vt100\n\n# TERMINALS"' \
				inittab.orig > inittab || die
			rm -f inittab.orig
			;;
	esac
}

src_compile() {

	use static && export LDFLAGS="-static"

	echo "${ROOT}" > ${T}/ROOT

	cd ${S}/src
	einfo "Building utilities..."
	make CC="${CC:-gcc}" LD="${CC:-gcc} ${LDFLAGS}" \
		CFLAGS="${CFLAGS}" || die "problem compiling utilities"

	if [ -z "`use build`" ]
	then
		# Build sysvinit stuff
		cd ${S2}
		einfo "Building sysvinit..."
		emake CC="${CC:-gcc}" LD="${CC:-gcc}" \
			LDFLAGS="${LDFLAGS}" || die "problem compiling sysvinit"
	fi
}

defaltmerge() {

	# Define the "altmerge" variable.
	altmerge=0
	# Special ${T}/ROOT hack because ROOT gets automatically unset during src_install()
	# (because it conflicts with some makefiles)
	if [ -f "${T}/ROOT" ]
	then
#		local ROOT=""
		ROOT="`cat "${T}/ROOT"`"
	fi
	einfo "ROOT=${ROOT}"
	if [ -e "${ROOT}/dev/.devfsd" ]
	then
		# We're installing to a system that has devfs enabled; don't create device
		# nodes.
		altmerge=1
	fi
}

# Only do a keepdir on mounts if they are not mounted ...
keepdir_mount() {
	local x=
	local y=
	local doit=0

	[ -z "$1" ] && return 1

	[ ! -e /proc/mounts ] && return 1

	for y in $*
	do
		doit=0

		# Create a list so that we can try verify that they exists
		# after install ...
		echo "${Y}" >> "${T}/dirlist.txt"

		for x in $(gawk '{print $2}' /proc/mounts)
		do
			[ "${x}" = "${y}" ] && doit=1
		done

		if [ "${doit}" -ne 1 ]
		then
			keepdir "${y}"
		fi
	done

	return 0
}

create_dev_nodes() {

	if [ -z "${DEST}" ]; then
		DEST=${D}
	fi

	export PATH="${DEST}/sbin:${PATH}"

	case ${ARCH} in
		amd64)
			# amd64 must use generic-i386 because amd64/x86_64 does not have
			# a generic option at this time, and the default 'generic' ends
			# up erroring out, because MAKEDEV internally doesn't know what
			# to use
			einfo "Using generic-i386 to make amd64 device nodes..."
			${DEST}/sbin/MAKEDEV generic-i386
			;;
		x86)
			einfo "Using generic-i386 to make device nodes..."
			${DEST}/sbin/MAKEDEV generic-i386
			;;
		ppc)
			einfo "Using generic-powerpc to make device nodes..."
			${DEST}/sbin/MAKEDEV generic-powerpc
			;;
		ppc64)
			einfo "Using generic-powerpc to make device nodes..."
			${DEST}/sbin/MAKEDEV generic-powerpc
			;;
		sparc)
			einfo "Using generic-sparc to make device nodes..."
			${DEST}/sbin/MAKEDEV generic-sparc
			;;
		mips)
			einfo "Using generic-mips to make device nodes..."
			${DEST}/sbin/MAKEDEV generic-mips
			;;
		arm)
			einfo "Using generic-arm to make device nodes..."
			${DEST}/sbin/MAKEDEV generic-arm
			;;
		hppa)
			einfo "Using generic-hppa to make device nodes..."
			${DEST}/sbin/MAKEDEV generic-hppa
			;;
		*)
			einfo "Using generic to make device nodes..."
			${DEST}/sbin/MAKEDEV generic
			;;
	esac

	${DEST}/sbin/MAKEDEV sg scd rtc hde hdf hdg hdh input audio video
}

src_install() {

	local bar=
	local foo=

	defaltmerge
	keepdir /sbin /usr/sbin

	keepdir_mount /usr
	keepdir /usr/bin
	keepdir /lib /usr/lib
	keepdir /var /var/run /var/lock/subsys /var/state
	keepdir /var/spool /var/tmp /var/lib/misc
	keepdir /var/log/news
	dosym ../var/tmp /usr/tmp

	# Symlinks so that LSB compliant apps work
	# /lib64 is especially required since its the default place for ld.so
	if [ "${ARCH}" = "amd64" -o "${ARCH}" = "ppc64" ]
	then
		dosym lib /lib64
		dosym lib /usr/lib64
		dosym lib /usr/X11R6/lib64
	fi

	keepdir /home
	keepdir /usr/include /usr/src
	keepdir /usr/X11R6/include/{X11,GL} /usr/X11R6/lib
	keepdir /usr/X11R6/lib /usr/X11R6/man /usr/X11R6/share

	# If it already exist, do not recreate, else we get
	# problems when /usr/portage mounted as ro NFS, etc.
	keepdir_mount /usr/portage

	#dosym ../src/linux/include/linux /usr/include/linux
	#dosym ../src/linux/include/asm-i386 /usr/include/asm
	# Important note: Gentoo Linux 1.0_rc6 no longer uses symlinks to /usr/src for includes.
	# We now rely on the special sys-kernel/linux-headers package, which takes a snapshot of
	# the currently-installed includes in /usr/src and copies them to /usr/include/linux and
	# /usr/include/asm.  This is the recommended approach so that kernel includes can remain
	# constant.  The kernel includes should really only be upgraded when you upgrade glibc.
	keepdir /usr/include/linux /usr/include/asm
	keepdir /usr/share/man /usr/share/info /usr/share/doc /usr/share/misc

	for foo in games lib sbin share bin share/doc share/man src
	do
		keepdir /usr/local/${foo}
	done
	# Local FHS compat symlinks
	dosym share/man /usr/local/man
	dosym share/doc	/usr/local/doc

	# FHS compatibility symlinks stuff
	dosym share/man /usr/man
	dosym share/doc /usr/doc
	dosym share/info /usr/info
	dosym ../../share/info	/usr/X11R6/share/info
	dosym ../X11R6/include/X11 /usr/include/X11
	dosym ../X11R6/include/GL /usr/include/GL
	dosym ../X11R6/lib/X11 /usr/lib/X11
	# End FHS compatibility symlinks stuff

	# The .keep file messes up Portage when looking in /var/db/pkg
	dodir /var/db/pkg
	fperms 1777 /var/tmp
	keepdir /root

	# /proc is very likely mounted right now so a keepdir will fail on merge
	dodir /proc

	fperms go-rx /root
	keepdir /tmp /var/lock
	fperms 1777 /tmp
	fperms 1777 /var/tmp
	fowners root:uucp /var/lock
	fperms 775 /var/lock
	insopts -m0644

	keepdir /opt /etc/opt

	insinto /etc
	dosym  ../proc/filesystems /etc/filesystems
	for foo in hourly daily weekly monthly
	do
		keepdir /etc/cron.${foo}
	done
	for foo in ${S}/etc/*
	do
		# Install files, not dirs
		[ -f "${foo}" ] && doins ${foo}
	done
	fperms go-rwx /etc/shadow
	# We do not want to overwrite the user's settings during bootstrap ...
	[ -f "${ROOT}/etc/hosts" ] && rm -f ${D}/etc/hosts

	keepdir /mnt
	keepdir_mount /mnt/floppy /mnt/cdrom
	fperms go-rwx /mnt/floppy /mnt/cdrom

	into /
	dosbin ${S}/sbin/MAKEDEV
	dosym ../../sbin/MAKEDEV /usr/sbin/MAKEDEV
	keepdir /lib/dev-state /lib/udev-state
	if [ "${altmerge}" -eq "1" ]
	then
		# rootfs and devfs
		#dosym ../../sbin/MAKEDEV /lib/dev-state/MAKEDEV
		# This is not needed anymore...
		#keepdir /lib/dev-state/pts /lib/dev-state/shm

		# Commented 07 Apr 2004 by agriffis... Make /dev in
		# pkg_postinst instead to cope with portage borking when
		# merging onto a mounted filesystem
		#keepdir_mount /dev /dev/shm # /dev/pts
		true
	else
		# Normal
		keepdir_mount /dev /dev/pts /dev/shm
		#dosym ../sbin/MAKEDEV /dev/MAKEDEV
	fi

	cd ${S}/sbin
	into /
	dosbin rc rc-update
	# Need this in /sbin, as it could be run before
	# /usr is mounted.
	dosbin modules-update
	# Compat symlinks until I can get things synced.
	dosym modules-update /sbin/update-modules
	dosym ../../sbin/modules-update /usr/sbin/update-modules
	# These moved from /etc/init.d/ to /sbin to help newb systems
	# from breaking
	dosbin runscript.sh functions.sh
	use livecd && dosbin livecd-functions.sh
	exeinto /lib/rcscripts/sh
	doexe rc-services.sh rc-daemon.sh rc-help.sh
	cd ${S}/bin
	dobin rc-status

	dodir /etc/init.d
	exeinto /etc/init.d
	for foo in ${S}/init.d/*
	do
		[ -f "${foo}" ] && doexe ${foo}
	done

	cd ${S}/sbin
	# We can only install new, fast awk versions of scripts
	# if 'build' or 'bootstrap' is not in USE.  This will
	# change if we have sys-apps/gawk-3.1.1-r1 or later in
	# the build image ...
	if [ -z "`use build`" ]
	then
		# This is for new depscan.sh and env-update.sh
		# written in awk
		into /
		dosbin depscan.sh
		dosbin env-update.sh
		insinto /lib/rcscripts/awk
		for foo in ${S}/src/awk/*.awk
		do
			[ -f "${foo}" ] && doins ${foo}
		done
	fi

	# Compat symlinks (some stuff have hardcoded paths)
	dosym ../../sbin/depscan.sh /etc/init.d/depscan.sh
	dosym ../../sbin/runscript.sh /etc/init.d/runscript.sh
	dosym ../../sbin/functions.sh /etc/init.d/functions.sh

	cd ${S}/src
	einfo "Installing utilities..."
	make DESTDIR="${D}" install || die "problem installing utilities"

	if [ -z "`use build`" ]
	then
		# Install sysvinit stuff
		cd ${S2}
		einfo "Installing sysvinit..."
		into /
		dosbin init halt killall5 runlevel shutdown sulogin
		dosym init /sbin/telinit
		dobin last mesg utmpdump wall
		dosym killall5 /sbin/pidof
		dosym halt /sbin/reboot
		dosym halt /sbin/poweroff
		dosym last /bin/lastb
		# SysvInit include
		insinto /usr/include
		doins initreq.h
		# SysvInit docs
		cd ${S2}/../
		for foo in ${S2}/../man/*.[1-9]
		do
			[ -f "${foo}" ] && doman ${foo}
		done
		docinto sysvinit-${SVIV}
		dodoc COPYRIGHT README doc/*
	fi

	for foo in ${S}/man/*
	do
		[ -f "${foo}" ] && doman ${foo}
	done
	docinto /
	dodoc ${FILESDIR}/copyright
	dodoc ${S}/ChangeLog

	# env-update stuff
	keepdir /etc/env.d
	insinto /etc/env.d
	doins ${S}/etc/env.d/00basic

	keepdir /etc/devfs.d

	keepdir /etc/modules.autoload.d
	insinto /etc/modules.autoload.d
	for foo in in ${S}/etc/modules.autoload.d/*
	do
		[ -f "${foo}" ] && doins ${foo}
	done

	keepdir /etc/modules.d
	insinto /etc/modules.d
	doins ${S}/etc/modules.d/aliases ${S}/etc/modules.d/i386

	keepdir /etc/conf.d
	insinto /etc/conf.d
	for foo in ${S}/etc/conf.d/*
	do
		[ -f "${foo}" ] && doins ${foo}
	done

	# Now ships with net-dialup/ppp ...
	rm -f ${D}/etc/{conf,init}.d/net.ppp*

	dodir /etc/skel
	insinto /etc/skel
	for foo in $(find ${S}/etc/skel -type f -maxdepth 1)
	do
		[ -f "${foo}" ] && doins ${foo}
	done

	keepdir ${svcdir} >/dev/null 2>&1

	if [ -n "$(use build)" -o -n "$(use bootstrap)" -o \
	     ! -f "${ROOT}/lib/udev-state/devices.tar.bz2" ]
	then
		# Ok, create temp device nodes
		mkdir -p "${T}/udev-$$"
		cd "${T}/udev-$$"
		echo
		einfo "Making device nodes (this could take a minute or so...)"
		create_dev_nodes
		# Now create tarball that can also be used for udev
		tar -jclpf "${T}/devices-$$.tar.bz2" *
		insinto /lib/udev-state
		newins "${T}/devices-$$.tar.bz2" devices.tar.bz2
	fi

	# Put this where we can get it again ...
	insinto /usr/share/baselayout
	doins "${T}/dirlist.txt"

	# Skip this if we are merging to ROOT
	[ "${ROOT}" = "/" ] && return 0

	# Set up default runlevel symlinks
	for foo in default boot nonetwork single
	do
		keepdir /etc/runlevels/${foo}
		for bar in $(cat ${S}/rc-lists/${foo})
		do
			[ -e "${S}/init.d/${bar}" ] && \
				dosym /etc/init.d/${bar} /etc/runlevels/${foo}/${bar}
		done
	done

}

pkg_preinst() {
	if [ -f ${ROOT}/etc/modules.autoload -a ! -d ${ROOT}/etc/modules.autoload.d ]
	then
		mkdir -p ${ROOT}/etc/modules.autoload.d
		mv -f ${ROOT}/etc/modules.autoload \
			${ROOT}/etc/modules.autoload.d/kernel-2.4
		ln -snf modules.autoload.d/kernel-2.4 ${ROOT}/etc/modules.autoload
	fi

	if [ -f "${ROOT}/lib/udev-state/devices.tar.bz2" -a -e "${ROOT}/dev/.udev" ]
	then
		mv -f "${ROOT}/lib/udev-state/devices.tar.bz2" \
			"${ROOT}/lib/udev-state/devices.tar.bz2.old"
	fi
}

pkg_postinst() {
	local x=

	# Make sure all needed dirs exist ...
	for x in $(cat "${ROOT}/usr/share/baselayout/dirlist.txt")
	do
		[ ! -d "${x}" ] && mkdir -m0666 -p "${x}" &>/dev/null
	done

	# Create /dev and /dev/shm (is it okay to leave perms default?)
	mkdir -p ${ROOT}/dev ${ROOT}/dev/shm

	if [ -f "${ROOT}/lib/udev-state/devices.tar.bz2.old" ]
	then
		# Rather use our current device tarball ...
		mv -f "${ROOT}/lib/udev-state/devices.tar.bz2.old" \
			"${ROOT}/lib/udev-state/devices.tar.bz2"
	else
		# Make sure our tarball do not get removed ...
		touch -m "${ROOT}/lib/udev-state/devices.tar.bz2"
	fi

	defaltmerge
	# We dont want to create devices if this is not a bootstrap and devfs
	# is used, as this was the cause for all the devfs problems we had
	# ($altmerge will be '1' if '${ROOT}/dev/.devfsd' exists ...)
	if [ "${altmerge}" -eq "0" -a ! -e "${ROOT}/dev/.udev" -a \
	     -f "${ROOT}/lib/udev-state/devices.tar.bz2" ]
	then
		if [ -n "$(use build)" -o -n "$(use bootstrap)" ]
		then
			einfo "Populating /dev with device nodes..."
			if [ -f "${ROOT}/lib/udev-state/devices.tar.bz2" ]
			then
				tar -jxpf "${ROOT}/lib/udev-state/devices.tar.bz2" \
					-C "${ROOT}/dev" || die
			else
				# devices.tar.bz2 will not exist with binary packages ...
				cd ${ROOT}/dev
				DEST="${ROOT}" create_dev_nodes
			fi
		fi
	fi

	echo

	# We create the /boot directory here so that /boot doesn't get deleted when a previous
	# baselayout is unmerged with /boot unmounted.
	install -d ${ROOT}/boot
	touch ${ROOT}/boot/.keep
	if [ ! -L ${ROOT}/boot/boot ]
	then
		ln -snf . ${ROOT}/boot/boot
	fi
	if [ -d "${ROOT}/dev" ]
	then
		ln -snf ../sbin/MAKEDEV ${ROOT}/dev/MAKEDEV
	fi
	# We create this here so we don't overwrite an existing /etc/hosts during bootstrap
	if [ ! -e ${ROOT}/etc/hosts ]
	then
		cat << EOF >> ${ROOT}/etc/hosts
127.0.0.1	localhost
# IPV6 versions of localhost and co
::1 ip6-localhost ip6-loopback
fe00::0 ip6-localnet
ff00::0 ip6-mcastprefix
ff02::1 ip6-allnodes
ff02::2 ip6-allrouters
ff02::3 ip6-allhosts
EOF
	fi
	if [ -L ${ROOT}/etc/mtab ]
	then
		rm -f ${ROOT}/etc/mtab
		if [ "$ROOT" = "/" ]
		then
			cp /proc/mounts ${ROOT}/etc/mtab
		else
			touch ${ROOT}/etc/mtab
		fi
	fi
	# We should only install empty files if these files don't already exist.
	for x in log/lastlog run/utmp log/wtmp
	do
		[ -e ${ROOT}/var/${x} ] || touch ${ROOT}/var/${x}
	done
	for x in run/utmp log/wtmp
	do
		chgrp utmp ${ROOT}/var/${x}
		chmod 0664 ${ROOT}/var/${x}
	done

	# Touching /etc/passwd and /etc/shadow after install can be fatal, as many
	# new users do not update them properly.  thus remove all ._cfg files if
	# we are not busy with a bootstrap.
	if [ -z "`use build`" -a -z "`use bootstrap`" ]
	then
		ewarn "Removing invalid backup copies of critical config files..."
		rm -f ${ROOT}/etc/._cfg????_{passwd,shadow}
	fi

	# Reload init to fix unmounting problems of / on next reboot
	# this is really needed, as without the new version of init cause init
	# not to quit properly on reboot, and causes a fsck of / on next reboot.
	if [ "${ROOT}" = "/" -a -z "`use build`" -a -z "`use bootstrap`" ]
	then
		echo
		# Do not return an error if this fails
		/sbin/init U &>/dev/null || :

		/sbin/depscan.sh &>/dev/null

		# We need to regenerate /etc/modules.conf, else it will fail at next
		# boot.
		einfo "Updating module dependencies..."
		/sbin/modules-update force &> /dev/null

	elif [ -f "${ROOT}/etc/modules.conf" ]
	then
		rm -f ${ROOT}/etc/modules.conf
	fi

	# Enable shadow groups (we need ROOT=/ here, as grpconv only
	# operate on / ...).
	if [ "${ROOT}" = "/" -a \
	     ! -f /etc/gshadow -a -x /usr/sbin/grpck -a -x /usr/sbin/grpconv ]
	then
		/usr/sbin/grpck -r &>/dev/null
		if [ "$?" -eq 0 ]
		then
			/usr/sbin/grpconv
		else
			echo
			ewarn "Running 'grpck' returned errors.  Please run it by hand, and then"
			ewarn "run 'grpconv' afterwards!"
			echo
		fi
	fi

	# Simple Release version for testing of features that *should* be
	# present in the rc-scripts, etc.
	echo "Gentoo Base System version ${SV}" > ${ROOT}/etc/gentoo-release

	echo
	ewarn "Please be sure to update all pending '._cfg*' files in /etc are updated,"
	ewarn "else things might break at your next reboot!  You can use 'etc-update'"
	ewarn "to accomplish this:"
	echo
	ewarn "  # etc-update"
	echo
}

