# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/baselayout/baselayout-1.8.6.13.ebuild,v 1.1 2004/02/08 15:08:58 azarah Exp $

# This ebuild needs to be merged "live".  You can't simply make a package
# of it and merge it later.

IUSE="bootstrap build livecd static selinux"

SV="1.4.3.13"
SVREV=
# SysvInit version
SVIV="2.84"

S="${WORKDIR}/rc-scripts-${SV}${SVREV}"
S2="${WORKDIR}/sysvinit-${SVIV}/src"
DESCRIPTION="Base layout for Gentoo Linux filesystem (incl. initscripts and sysvinit)"
SRC_URI="ftp://ftp.cistron.nl/pub/people/miquels/software/sysvinit-${SVIV}.tar.gz
	ftp://sunsite.unc.edu/pub/Linux/system/daemons/init/sysvinit-${SVIV}.tar.gz
	mirror://gentoo/rc-scripts-${SV}${SVREV}.tar.bz2"
HOMEPAGE="http://www.gentoo.org/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 amd64 ppc sparc alpha mips arm hppa ia64 ppc64"

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

	if [ -z "`use build`" -a -z "`use bootstrap`" ]
	then
		# Sanity check to see if has version works
		if has_version '>=sys-apps/baselayout-1.8' &> /dev/null
		then
			einfo "Checking if we need to tweak CONFIG_PROTECT_MASK"
			# Make sure user get things updated first time he merge 1.8.6 ...
			if ! has_version '>=sys-apps/baselayout-1.8.6' &> /dev/null
			then
				touch "${WORKDIR}/update_init_d"
			fi
		fi
	fi
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
	local ROOT=""
	ROOT="`cat ${T}/ROOT`"
	if [ -e ${ROOT}/dev/.devfsd ]
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
	export PATH="${D}/sbin:${PATH}"

	case ${ARCH} in
		amd64)
			# amd64 must use generic-i386 because amd64/x86_64 does not have
			# a generic option at this time, and the default 'generic' ends
			# up erroring out, because MAKEDEV internally doesn't know what
			# to use
			einfo "Using generic-i386 to make amd64 device nodes..."
			${D}/sbin/MAKEDEV generic-i386
			;;
		x86)
			einfo "Using generic-i386 to make device nodes..."
			${D}/sbin/MAKEDEV generic-i386
			;;
		ppc)
			einfo "Using generic-powerpc to make device nodes..."
			${D}/sbin/MAKEDEV generic-powerpc
			;;
		sparc)
			einfo "Using generic-sparc to make device nodes..."
			${D}/sbin/MAKEDEV generic-sparc
			;;
		mips)
			einfo "Using generic-mips to make device nodes..."
			${D}/sbin/MAKEDEV generic-mips
			;;
		arm)
			einfo "Using generic-arm to make device nodes..."
			${D}/sbin/MAKEDEV generic-arm
			;;
		hppa)
			einfo "Using generic-hppa to make device nodes..."
			${D}/sbin/MAKEDEV generic-hppa
			;;
		*)
			einfo "Using generic to make device nodes..."
			${D}/sbin/MAKEDEV generic
			;;
	esac

	${D}/sbin/MAKEDEV sg scd rtc hde hdf hdg hdh input audio video
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
	if [ "${ARCH}" = "amd64" ]
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
		[ -f ${foo} ] && doins ${foo}
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
		echo >/dev/null
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
	use livecd && livecd-functions.sh
	exeinto /lib/rcscripts/sh
	doexe rc-services.sh rc-daemon.sh rc-help.sh
	cd ${S}/bin
	dobin rc-status

	dodir /etc/init.d
	exeinto /etc/init.d
	for foo in ${S}/init.d/*
	do
		[ -f ${foo} ] && doexe ${foo}
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
			[ -f ${foo} ] && doins ${foo}
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
			[ -f ${foo} ] && doman ${foo}
		done
		docinto sysvinit-${SVIV}
		dodoc COPYRIGHT README doc/*
	fi

	for foo in ${S}/man/*
	do
		[ -f ${foo} ] && doman ${foo}
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
		[ -f ${foo} ] && doins ${foo}
	done

	keepdir /etc/modules.d
	insinto /etc/modules.d
	doins ${S}/etc/modules.d/aliases ${S}/etc/modules.d/i386

	keepdir /etc/conf.d
	insinto /etc/conf.d
	for foo in ${S}/etc/conf.d/*
	do
		[ -f ${foo} ] && doins ${foo}
	done

	# Now ships with net-dialup/ppp ...
	rm -f ${D}/etc/{conf,init}.d/net.ppp*

	dodir /etc/skel
	insinto /etc/skel
	for foo in $(find ${S}/etc/skel -type f -maxdepth 1)
	do
		[ -f ${foo} ] && doins ${foo}
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

	# Skip this if we are merging to ROOT
	[ "${ROOT}" = "/" ] && return 0

	# Set up default runlevel symlinks
	for foo in default boot nonetwork single
	do
		keepdir /etc/runlevels/${foo}
		for bar in $(cat ${S}/rc-lists/${foo})
		do
			[ -e ${S}/init.d/${bar} ] && \
				dosym /etc/init.d/${bar} /etc/runlevels/${foo}/${bar}
		done
	done

}

pkg_preinst() {
	# Make sure symlinks of these get installed.
	if [ -e ${ROOT}/etc/init.d/depscan.sh ] && \
	   [ ! -L ${ROOT}/etc/init.d/depscan.sh ]
	then
		rm -f ${ROOT}/etc/init.d/depscan.sh
	fi
	if [ -e ${ROOT}/etc/init.d/runscript.sh ] && \
	   [ ! -L ${ROOT}/etc/init.d/runscript.sh ]
	then
		rm -f ${ROOT}/etc/init.d/runscript.sh
	fi
	if [ -e ${ROOT}/etc/init.d/functions.sh ] && \
	   [ ! -L ${ROOT}/etc/init.d/functions.sh ]
	then
		rm -f ${ROOT}/etc/init.d/functions.sh
	fi
	if [ -e ${ROOT}/etc/init.d/rc-help.sh ]
	then
		rm -f ${ROOT}/etc/init.d/rc-help.sh
	fi

	# This one was borked, so make sure fixed one gets installed.
	if [ -L ${ROOT}/usr/lib/X11 ]
	then
		rm -f ${ROOT}/usr/lib/X11
	fi

	if [ -f ${ROOT}/etc/modules.autoload -a ! -d ${ROOT}/etc/modules.autoload.d ]
	then
		mkdir -p ${ROOT}/etc/modules.autoload.d
		mv -f ${ROOT}/etc/modules.autoload \
			${ROOT}/etc/modules.autoload.d/kernel-2.4
		ln -snf modules.autoload.d/kernel-2.4 ${ROOT}/etc/modules.autoload
	fi

	# Make sure user get things updated first time he merge 1.8.6 ...
	if [ -f "${WORKDIR}/update_init_d" ]
	then
		# Update CONFIG_PROTECT_MASK to exclude /etc/init.d from
		# CONFIG_PROTECT ...
		ewarn "Changing CONFIG_PROTECT_MASK to ensure critical files are updated ..."
		echo "CONFIG_PROTECT_MASK=\"/etc/init.d\"" \
			> ${ROOT}/etc/env.d/99foo
		env-update &> /dev/null
		export CONFIG_PROTECT_MASK="${CONFIG_PROTECT_MASK}:/etc/init.d"

		if [ -d "${ROOT}/etc/init.d" ]
		then
			# Backup /etc/init.d if it exists ...
			einfo "Backing up /etc/init.d ..."
			cp -af "${ROOT}/etc/init.d" "${ROOT}/etc/init_d.old"
		fi
	fi

	if [ -f "${ROOT}/lib/udev-state/devices.tar.bz2" -a -e "${ROOT}/dev/.udev" ]
	then
		mv -f "${ROOT}/lib/udev-state/devices.tar.bz2" \
			"${ROOT}/lib/udev-state/devices.tar.bz2.old"
	fi
}

pkg_postinst() {
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
			[ ! -e "${ROOT}/dev" ] && mkdir -p "${ROOT}/dev"
			tar -jxpf "${ROOT}/lib/udev-state/devices.tar.bz2" \
				-C "${ROOT}/dev" || die
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
	local x=
	for x in log/lastlog run/utmp log/wtmp
	do
		[ -e ${ROOT}/var/${x} ] || touch ${ROOT}/var/${x}
	done
	for x in run/utmp log/wtmp
	do
		chgrp utmp ${ROOT}/var/${x}
		chmod 0664 ${ROOT}/var/${x}
	done

	# Make sure we get everything ready for $svcdir that moved to
	# /var/lib/init.d ....
	if [ -z "`use build`" -a -z "`use bootstrap`" ]
	then
		local oldsvcdir="${svcdir}"
		local rcconfd="/etc/conf.d/rc"
		local inittab="/etc/inittab"

		# Remove old backup /etc/conf.d/rc files ...
		rm -f ${ROOT}/etc/conf.d/._cfg????_rc
		# Remove old backup /etc/inittab files ...
		rm -f ${ROOT}/etc/._cfg????_inittab

		# Replace and backup /etc/conf.d/rc (unless already in new format)
		if [ -f "${ROOT}/${rcconfd}" ] && \
		   ([ -z "$(grep '^svcmount' "${ROOT}/${rcconfd}")" ] || \
		    [ -z "$(grep '^svcdir=\"\/var\/lib\/init.d\"' "${ROOT}/${rcconfd}")" ])
			#svcdir="/var/lib/init.d"
		then
			ewarn "Backing up your old /etc/conf.d/rc, and replacing with new!"
			ewarn "This is needed, as \$svcdir moved from /mnt/.init.d to"
			ewarn "/var/state/init.d"
			echo
			cp -f "${ROOT}/${rcconfd}" "${ROOT}/${rcconfd}.old"
			cp -f "${S}/${rcconfd}" "${ROOT}/${rcconfd}"
		fi

		# Replace and backup /etc/inittab (unless already in new format)
		if [ -f "${ROOT}/${inittab}" ] && \
		   [ -z "$(grep '^si::sysinit:/sbin/rc sysinit' "${ROOT}/${inittab}")" ]
		then
			ewarn "Backing up your old /etc/inittab, and replacing with new!"
			ewarn "This is needed, as there were critical changes to /sbin/rc"
			echo
			cp -f "${ROOT}/${inittab}" "${ROOT}/${inittab}.old"
			cp -f "${S}/${inittab}" "${ROOT}/${inittab}"
		fi

		source ${ROOT}/etc/conf.d/rc

		# Handle the ${svcdir} that changed in location
		if [ ! -d "${ROOT}/${svcdir}/started" ]
		then
			einfo "Trying to move SVCDIR to new location..."
			echo
			mkdir -p "${ROOT}/${svcdir}"
#			mount -t tmpfs tmpfs ${ROOT}/${svcdir}
			if [ -d "${ROOT}/${oldsvcdir}/started" ]
			then
				cp -ax "${ROOT}/${oldsvcdir}"/* "${ROOT}/${svcdir}"

			elif [ -d "${ROOT}/mnt/.init.d/started" ]
			then
				cp -ax "${ROOT}/mnt/.init.d"/* "${ROOT}/${svcdir}"
			fi
		fi
	fi

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
	     ! -f /etc/gshadow -a -x /usr/sbin/grpconv ]
	then
		/usr/sbin/grpconv
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

	if [ -f "${ROOT}/etc/env.d/99foo" ]
	then
		echo
		ewarn "Due to large changes from 1.8.5 to 1.8.6, all your files in /etc/init.d"
		ewarn "have been updated automatically.  If you did make any changes directly"
		ewarn "to your old files, they can be found in /etc/init_d.old.  Please just"
		ewarn "make sure to edit the new files, and not just copy the old over!"
		echo

		rm -f "${ROOT}/etc/env.d/99foo"

		echo -ne "\a" ; sleep 1 ; echo -ne "\a" ; sleep 1 ; echo -ne "\a" ; sleep 1
		echo -ne "\a" ; sleep 1 ; echo -ne "\a" ; sleep 1 ; echo -ne "\a" ; sleep 1
		sleep 8
	fi
}

pkg_postrm() {

	# Fix problematic links
	ln -snf ../X11R6/include/X11 ${ROOT}/usr/include/X11
	ln -snf ../X11R6/include/GL ${ROOT}/usr/include/GL
	ln -snf ../X11R6/lib/X11 ${ROOT}/usr/lib/X11
}

