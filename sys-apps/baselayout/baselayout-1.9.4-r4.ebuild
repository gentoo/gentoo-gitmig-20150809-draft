# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/baselayout/baselayout-1.9.4-r4.ebuild,v 1.6 2004/10/28 15:44:24 vapier Exp $

inherit flag-o-matic eutils toolchain-funcs

SV=1.4.16		# rc-scripts version
SVREV=			# rc-scripts rev
SVIV=2.84		# sysvinit version

S="${WORKDIR}/rc-scripts-${SV}${SVREV}"
S2="${WORKDIR}/sysvinit-${SVIV}"
DESCRIPTION="Base layout for Gentoo Linux (incl. initscripts and sysvinit)"
HOMEPAGE="http://www.gentoo.org/"
SRC_URI="ftp://ftp.cistron.nl/pub/people/miquels/software/sysvinit-${SVIV}.tar.gz
	ftp://sunsite.unc.edu/pub/Linux/system/daemons/init/sysvinit-${SVIV}.tar.gz
	mirror://gentoo/rc-scripts-${SV}${SVREV}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64"
IUSE="bootstrap build livecd static selinux uclibc"

# This version of baselayout needs gawk in /bin, but as we do not have
# a c++ compiler during bootstrap, we cannot depend on it if "bootstrap"
# or "build" are in USE.
RDEPEND="!sys-apps/sysvinit
	!build? ( !bootstrap? (
		>=sys-apps/gawk-3.1.1-r2
		>=sys-apps/util-linux-2.11z-r6
	) )
	selinux? ( sys-libs/libselinux )"
DEPEND="virtual/os-headers
	selinux? ( sys-libs/libselinux )"

src_unpack() {
	unpack ${A}

	# Let glibc handle nscd #43076
	rm ${S}/init.d/nscd

	#
	# Baselayout setup
	#
	cd ${S}/etc

	# Fix Sparc specific stuff
	if [[ ${ARCH} == sparc ]]; then
		sed -i -e 's:KEYMAP="us":KEYMAP="sunkeymap":' rc.conf || die
	fi

	# Add serial console for arches that typically have it
	case ${ARCH} in
		sparc|mips|hppa|alpha|ia64)
			sed -i -e \
				's"# TERMINALS"# SERIAL CONSOLE\nc0:12345:respawn:/sbin/agetty 9600 ttyS0 vt100\n\n# TERMINALS"' \
				inittab || die
			;;
	esac

	#
	# sysvinit setup
	#
	if ! use build; then
		cd ${S2}/src

		# Selinux patch for sysvinit
		if use selinux; then
			if has_version '>=sys-libs/libselinux-1.6'; then
				epatch ${FILESDIR}/sysvinit-${SVIV}-selinux1.patch
			else
				epatch ${FILESDIR}/sysvinit-${SVIV}-selinux.patch
			fi
		fi
	fi
}

src_compile() {
	use static && append-ldflags -static

	echo "${ROOT}" > ${T}/ROOT

	einfo "Building utilities..."
	make -C ${S}/src CC="$(tc-getCC)" LD="$(tc-getCC) ${LDFLAGS}" \
		CFLAGS="${CFLAGS}" || die "problem compiling utilities"

	if ! use build; then
		einfo "Building sysvinit..."
		# Note: The LCRYPT define below overrides the test in
		# sysvinit's Makefile.  This is because sulogin must be linked
		# to libcrypt in any case, but when building stage2 in
		# catalyst, /usr/lib/libcrypt.a isn't available.  In truth
		# this doesn't change how sulogin is built since ld would use
		# the shared obj by default anyway!  The other option is to
		# refrain from building sulogin, but that isn't a good option.
		# (09 Jul 2004 agriffis)
		emake -C ${S2}/src CC="$(tc-getCC)" LD="$(tc-getCC)" \
			LDFLAGS="${LDFLAGS}" CFLAGS="${CFLAGS} -D_GNU_SOURCE" \
			LCRYPT="-lcrypt" || die "problem compiling sysvinit"
	else
		einfo "Not building sysvinit because USE=build"
	fi
}

# ${PATH} should include where to get MAKEDEV when calling this
# function
create_dev_nodes() {
	case ${ARCH} in
		# amd64 must use generic-i386 because amd64/x86_64 does not have
		# a generic option at this time, and the default 'generic' ends
		# up erroring out, because MAKEDEV internally doesn't know what
		# to use
		amd64)	suffix=-i386 ;;
		x86)	suffix=-i386 ;;
		ppc*)	suffix=-powerpc ;;
		alpha)	suffix=-alpha ;;
		ia64)	suffix=-ia64 ;;
		sparc*)	suffix=-sparc ;;
		mips)	suffix=-mips ;;
		arm)	suffix=-arm ;;
		hppa)	suffix=-hppa ;;
	esac

	einfo "Using generic${suffix} to make ${ARCH} device nodes..."
	MAKEDEV generic${suffix}
	MAKEDEV sg scd rtc hde hdf hdg hdh input audio video
}

# This is a temporary workaround until bug 9849 is completely solved
# in portage.  We need to create the directories so they're available
# during src_install, but when src_install is finished, call unkdir
# to remove any empty directories instead of leaving them around.
kdir() {
	typeset -a args
	typeset d

	# Create the directories for the remainder of src_install, and
	# remember how to create the directories later.
	for d in "$@"; do
		if [[ $d == /* ]]; then
			install -d "${args[@]}" "${D}/${d}"
			cat >> "${D}/usr/share/baselayout/mkdirs.sh" <<EOF
install -d ${args[@]} "\${ROOT}/${d}" 2>/dev/null \\
	|| ewarn "  can't create ${d}"
touch "\${ROOT}/${d}/.keep" 2>/dev/null \\
	|| ewarn "  can't create ${d}/.keep"
EOF
		else
			args=("${args[@]}" "${d}")
		fi
	done
}

# Continued from kdir above...  This function removes any empty
# directories as a temporary workaround for bug 9849.  The directories
# (and .keep files) are re-created in pkg_postinst, which means they
# aren't listed in CONTENTS, unfortunately.
unkdir() {
	einfo "Running unkdir to workaround bug 9849"
	find ${D} -depth -type d -exec rmdir {} \; 2>/dev/null
	if [[ $? == 127 ]]; then
		ewarn "Problem running unkdir: find command not found"
	fi
}

src_install() {
	local foo bar

	# ROOT is purged from the environment prior to calling
	# src_install.  Good thing we saved it in a temporary file.
	# Otherwise ROOT will be NULL, which hopefully is correct!
	# (I don't know why it was in the environment in the first
	# place... could have just used a shell variable?)
	if [[ -f ${T}/ROOT ]]; then
		ROOT=$(cat ${T}/ROOT)
	fi

	# This directory is to stash away things that will be used in
	# pkg_postinst
	dodir /usr/share/baselayout

	einfo "Creating directories..."
	kdir /boot
	kdir /dev
	kdir /dev/pts
	kdir /dev/shm
	kdir /etc/conf.d
	kdir /etc/cron.daily
	kdir /etc/cron.hourly
	kdir /etc/cron.monthly
	kdir /etc/cron.weekly
	kdir /etc/env.d
	kdir /etc/modules.autoload.d
	kdir /etc/modules.d
	kdir /etc/opt
	kdir /home
	kdir /lib
	kdir /lib/dev-state
	kdir /lib/udev-state
	kdir /mnt
	kdir -m 0700 /mnt/cdrom
	kdir -m 0700 /mnt/floppy
	kdir /opt
	kdir -o root -g uucp -m0775 /var/lock
	kdir /proc
	kdir -m 0700 /root
	kdir /sbin
	kdir /sys			# needed for 2.6 kernels, fixes bug 52703
	kdir /usr
	kdir /usr/bin
	kdir /usr/include
	kdir /usr/include/asm
	kdir /usr/include/linux
	kdir /usr/lib
	kdir /usr/local/bin
	kdir /usr/local/games
	kdir /usr/local/lib
	kdir /usr/local/sbin
	kdir /usr/local/share
	kdir /usr/local/share/doc
	kdir /usr/local/share/man
	kdir /usr/local/src
	kdir /usr/portage
	kdir /usr/sbin
	kdir /usr/share/doc
	kdir /usr/share/info
	kdir /usr/share/man
	kdir /usr/share/misc
	kdir /usr/src
	kdir /usr/X11R6/include/GL
	kdir /usr/X11R6/include/X11
	kdir /usr/X11R6/lib
	kdir /usr/X11R6/lib
	kdir /usr/X11R6/man
	kdir /usr/X11R6/share
	kdir -m 1777 /tmp
	kdir /var
	kdir /var/lib/misc
	kdir /var/lock/subsys
	kdir /var/log/news
	kdir /var/run
	kdir /var/spool
	kdir /var/state
	kdir -m 1777 /var/tmp

	dodir /etc/init.d		# .keep file might mess up init.d stuff
	dodir /var/db/pkg		# .keep file messes up Portage when looking in /var/db/pkg

	# Symlinks so that LSB compliant apps work
	# /lib64 is especially required since its the default place for ld.so
	if [[ ${ARCH} == amd64 || ${ARCH} == ppc64 ]]; then
		dosym lib /lib64
		dosym lib /usr/lib64
		dosym lib /usr/X11R6/lib64
	fi

	# FHS compatibility symlinks stuff
	dosym ../var/tmp /usr/tmp
	dosym share/man /usr/man
	dosym share/doc /usr/doc
	dosym share/info /usr/info
	dosym ../../share/info	/usr/X11R6/share/info
	dosym ../X11R6/include/X11 /usr/include/X11
	dosym ../X11R6/include/GL /usr/include/GL
	dosym ../X11R6/lib/X11 /usr/lib/X11
	dosym share/man /usr/local/man
	dosym share/doc	/usr/local/doc

	#
	# Setup files in /etc
	#
	dosym  ../proc/filesystems /etc/filesystems

	insopts -m0644
	insinto /etc
	find ${S}/etc -type f -maxdepth 1 -print0 | xargs --null doins

	fperms 0600 /etc/shadow

	exeinto /etc/init.d
	doexe ${S}/init.d/*
	insinto /etc/conf.d
	doins ${S}/etc/conf.d/*
	insinto /etc/env.d
	doins ${S}/etc/env.d/*
	insinto /etc/modules.autoload.d
	doins ${S}/etc/modules.autoload.d/*
	insinto /etc/modules.d
	doins ${S}/etc/modules.d/*
	insinto /etc/skel
	find ${S}/etc/skel -type f -maxdepth 1 -print0 | xargs --null doins

	rm -f ${D}/etc/{conf,init}.d/net.ppp*	# now ships with net-dialup/ppp

	# Set up default runlevel symlinks
	if [[ ${ROOT} != / ]]; then
		for foo in default boot nonetwork single; do
			kdir /etc/runlevels/${foo}
			for bar in $(cat ${S}/rc-lists/${foo}); do
				[[ -e ${S}/init.d/${bar} ]] && \
					dosym /etc/init.d/${bar} /etc/runlevels/${foo}/${bar}
			done
		done
	fi

	# We do not want to overwrite the user's settings during
	# bootstrap;  put this somewhere for safekeeping until pkg_postinst
	mv ${D}/etc/hosts ${D}/usr/share/baselayout

	# rc-scripts version for testing of features that *should* be present
	echo "Gentoo Base System version ${SV}" > ${D}/etc/gentoo-release

	#
	# Setup files related to /dev
	#
	into /
	dosbin ${S}/sbin/MAKEDEV
	dosym ../../sbin/MAKEDEV /usr/sbin/MAKEDEV
	dosym ../sbin/MAKEDEV /dev/MAKEDEV

	if use build || use bootstrap || \
			[[ ! -f "${ROOT}/lib/udev-state/devices.tar.bz2" ]]; then
		# Ok, create temp device nodes
		mkdir -p "${T}/udev-$$"
		cd "${T}/udev-$$"
		echo
		einfo "Making device nodes (this could take a minute or so...)"
		PATH="${D}/sbin:${PATH}" create_dev_nodes

		# Now create tarball that can also be used for udev.
		# Need GNU tar for -j so call it by absolute path.
		/bin/tar -cjlpf "${T}/devices-$$.tar.bz2" *
		insinto /lib/udev-state
		newins "${T}/devices-$$.tar.bz2" devices.tar.bz2
	fi

	#
	# Setup files in /bin
	#
	cd ${S}/bin
	dobin rc-status
	if use livecd; then
		dobin bashlogin
	fi

	#
	# Setup files in /sbin
	#
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

	# Compat symlinks between /etc/init.d and /sbin
	# (some stuff have hardcoded paths)
	dosym ../../sbin/depscan.sh /etc/init.d/depscan.sh
	dosym ../../sbin/runscript.sh /etc/init.d/runscript.sh
	dosym ../../sbin/functions.sh /etc/init.d/functions.sh

	#
	# Setup files in /lib/rcsripts/sh
	#
	cd ${S}/sbin
	exeinto /lib/rcscripts/sh
	doexe rc-services.sh rc-daemon.sh rc-help.sh

	# We can only install new, fast awk versions of scripts
	# if 'build' or 'bootstrap' is not in USE.  This will
	# change if we have sys-apps/gawk-3.1.1-r1 or later in
	# the build image ...
	if ! use build; then
		# This is for new depscan.sh and env-update.sh
		# written in awk
		cd ${S}/sbin
		into /
		dosbin depscan.sh
		dosbin env-update.sh
		insinto /lib/rcscripts/awk
		doins ${S}/src/awk/*.awk
	fi

	#
	# Install baselayout documentation
	#
	if ! use build ; then
		doman ${S}/man/*.*
		docinto /
		dodoc ${FILESDIR}/copyright
		dodoc ${S}/ChangeLog
	fi

	#
	# Install baselayout utilities
	#
	cd ${S}/src
	einfo "Installing utilities..."
	make DESTDIR="${D}" install || die "problem installing utilities"

	#
	# Install sysvinit
	#
	if ! use build; then
		cd ${S2}/src
		einfo "Installing sysvinit..."
		into /
		dosbin init halt killall5 runlevel shutdown sulogin
		dosym init /sbin/telinit
		dobin last mesg utmpdump wall
		dosym killall5 /sbin/pidof
		dosym halt /sbin/reboot
		dosym halt /sbin/poweroff
		dosym last /bin/lastb
		insinto /usr/include
		doins initreq.h
		# sysvinit docs
		cd ${S2}
		doman man/*.[1-9]
		docinto sysvinit-${SVIV}
		dodoc COPYRIGHT README doc/*
	fi

	use uclibc && rm -f ${D}/etc/nsswitch.conf

	# Hack to fix bug 9849, continued in pkg_postinst
	unkdir
}

pkg_preinst() {
	if [[ -f ${ROOT}/etc/modules.autoload && \
			! -d ${ROOT}/etc/modules.autoload.d ]]; then
		mkdir -p ${ROOT}/etc/modules.autoload.d
		mv -f ${ROOT}/etc/modules.autoload \
			${ROOT}/etc/modules.autoload.d/kernel-2.4
		ln -snf modules.autoload.d/kernel-2.4 ${ROOT}/etc/modules.autoload
	fi

	if [[ -f "${ROOT}/lib/udev-state/devices.tar.bz2" &&
			-e "${ROOT}/dev/.udev" ]]; then
		mv -f "${ROOT}/lib/udev-state/devices.tar.bz2" \
			"${ROOT}/lib/udev-state/devices.tar.bz2.current"
	fi
}

pkg_postinst() {
	local x

	# Reincarnate dirs from kdir/unkdir (hack for bug 9849)
	einfo "Creating directories and .keep files."
	einfo "Some of these might fail if they're read-only mounted"
	einfo "filesystems, for example /dev or /proc.  That's okay!"
	source ${ROOT}/usr/share/baselayout/mkdirs.sh

	if [[ -f "${ROOT}/lib/udev-state/devices.tar.bz2.current" ]]; then
		# Rather use our current device tarball ... this was saved off
		# in pkg_preinst
		mv -f "${ROOT}/lib/udev-state/devices.tar.bz2.current" \
			"${ROOT}/lib/udev-state/devices.tar.bz2"
	else
		# Make sure our tarball does not get removed; update the
		# timestamp so that it doesn't match CONTENTS
		touch "${ROOT}/lib/udev-state/devices.tar.bz2"
	fi

	# We don't want to create devices if this is not a bootstrap and devfs
	# is used, as this was the cause for all the devfs problems we had
	if use build || use bootstrap; then
		if [[ ! -e "${ROOT}/dev/.devfsd" && ! -e "${ROOT}/dev/.udev" ]]; then
			einfo "Populating /dev with device nodes..."
			cd ${ROOT}/dev
			if [ -f "${ROOT}/lib/udev-state/devices.tar.bz2" ]; then
				tar -jxpf "${ROOT}/lib/udev-state/devices.tar.bz2" || die
			else
				# devices.tar.bz2 will not exist with binary packages ...
				PATH="${ROOT}/sbin:${PATH}" create_dev_nodes
			fi
		fi
	fi

	# Create /boot/boot symlink in pkg_postinst because sometimes
	# /boot is a FAT filesystem.  When that is the case, then the
	# symlink will fail.  Consequently, if we create it in
	# src_install, then merge will fail.  AFAIK there is no point to
	# this symlink except for misconfigured grubs.  See bug 50108
	# (05 May 2004 agriffis)
	ln -sn . ${ROOT}/boot/boot 2>/dev/null

	# Create /etc/hosts in pkg_postinst so we don't overwrite an
	# existing file during bootstrap
	if [[ ! -e ${ROOT}/etc/hosts ]]; then
		cp ${ROOT}/usr/share/baselayout/hosts ${ROOT}/etc
	fi

	# Under what circumstances would mtab be a symlink?  It would be
	# nice if there were an explanatory comment here
	if [[ -L ${ROOT}/etc/mtab ]]; then
		rm -f "${ROOT}/etc/mtab"
		if [[ ${ROOT} == / ]]; then
			cp /proc/mounts "${ROOT}/etc/mtab"
		else
			touch "${ROOT}/etc/mtab"
		fi
	fi

	# We should only install empty files if these files don't already exist.
	[[ -e ${ROOT}/var/log/lastlog ]] || \
		touch "${ROOT}/var/log/lastlog"
	[[ -e ${ROOT}/var/run/utmp ]] || \
		install -m 0664 -g utmp /dev/null "${ROOT}/var/run/utmp"
	[[ -e ${ROOT}/var/log/wtmp ]] || \
		install -m 0664 -g utmp /dev/null "${ROOT}/var/log/wtmp"

	# Touching /etc/passwd and /etc/shadow after install can be fatal, as many
	# new users do not update them properly.  thus remove all ._cfg files if
	# we are not busy with a bootstrap.
	if ! use build && ! use bootstrap; then
		einfo "Removing invalid backup copies of critical config files..."
		rm -f "${ROOT}"/etc/._cfg????_{passwd,shadow}
	fi

	# Reload init to fix unmounting problems of / on next reboot.
	# This is really needed, as without the new version of init cause init
	# not to quit properly on reboot, and causes a fsck of / on next reboot.
	if [[ ${ROOT} == / ]] && ! use build && ! use bootstrap; then
		# Do not return an error if this fails
		/sbin/init U &>/dev/null

		# Regenerate init.d dependency tree
		/sbin/depscan.sh &>/dev/null

		# Regenerate /etc/modules.conf, else it will fail at next boot
		einfo "Updating module dependencies..."
		/sbin/modules-update force &>/dev/null
	else
		rm -f ${ROOT}/etc/modules.conf
	fi

	# Enable shadow groups (we need ROOT=/ here, as grpconv only
	# operate on / ...).
	if [[ ${ROOT} == / && \
	     ! -f /etc/gshadow && -x /usr/sbin/grpck && -x /usr/sbin/grpconv ]]
	then
		if /usr/sbin/grpck -r &>/dev/null; then
			/usr/sbin/grpconv
		else
			echo
			ewarn "Running 'grpck' returned errors.  Please run it by hand, and then"
			ewarn "run 'grpconv' afterwards!"
			echo
		fi
	fi

	# This is also written in src_install (so it's in CONTENTS), but
	# write it here so that the new version is immediately in the file
	# (without waiting for the user to do etc-update)
	rm -f ${ROOT}/etc/._cfg????_gentoo-release
	echo "Gentoo Base System version ${SV}" > ${ROOT}/etc/gentoo-release

	echo
	einfo "Please be sure to update all pending '._cfg*' files in /etc,"
	einfo "else things might break at your next reboot!  You can use 'etc-update'"
	einfo "to accomplish this:"
	einfo
	einfo "  # etc-update"
	echo
}
