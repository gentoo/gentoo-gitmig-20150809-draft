# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/baselayout/baselayout-1.10.2.ebuild,v 1.1 2004/08/02 20:05:44 agriffis Exp $

inherit flag-o-matic eutils

SV=1.5.2 		# rc-scripts version
SVREV=			# rc-scripts rev

S="${WORKDIR}/rc-scripts-${SV}${SVREV}"
DESCRIPTION="Filesystem baselayout and init scripts"
HOMEPAGE="http://www.gentoo.org/"
SRC_URI="mirror://gentoo/rc-scripts-${SV}${SVREV}.tar.bz2
	http://dev.gentoo.org/~agriffis/rc-scripts/rc-scripts-${SV}${SVREV}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~mips ~alpha ~arm ~hppa ~amd64 ~ia64 ~ppc64 ~s390"
IUSE="bootstrap build livecd static uclibc"

DEPEND="virtual/os-headers"

# This version of baselayout needs gawk in /bin, but as we do not have
# a c++ compiler during bootstrap, we cannot depend on it if "bootstrap"
# or "build" are in USE.
RDEPEND="${DEPEND}
	!build? ( !bootstrap? (
		>=sys-apps/gawk-3.1.1-r2
		>=sys-apps/util-linux-2.11z-r6
	) )
	>=sys-apps/sysvinit-2.84"

src_unpack() {
	unpack ${A}

	# Fix Sparc specific stuff
	if [[ ${ARCH} == sparc ]]; then
		sed -i -e 's:KEYMAP="us":KEYMAP="sunkeymap":' ${S}/etc/rc.conf || die
	fi
}

src_compile() {
	use static && append-ldflags -static

	make -C ${S}/src CC="${CC:-gcc}" LD="${CC:-gcc} ${LDFLAGS}" \
		CFLAGS="${CFLAGS}" || die
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
	# This directory is to stash away things that will be used in
	# pkg_postinst; it's needed first for kdir to function
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
	kdir /etc/devfs.d
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
	kdir -o root -g uucp -m0755 /var/lock
	kdir /proc
	kdir -m 0700 /root
	kdir /sbin
	kdir /sys	# for 2.6 kernels
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

	dodir /etc/init.d	# .keep file might mess up init.d stuff
	dodir /var/db/pkg	# .keep file messes up Portage

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

	# As of baselayout-1.10-1-r1, sysvinit is its own package again, and
	# provides the inittab itself
	rm -f ${D}/etc/inittab

	# We do not want to overwrite the user's settings during
	# bootstrap;  put this somewhere for safekeeping until pkg_postinst
	mv ${D}/etc/hosts ${D}/usr/share/baselayout

	# Stash the rc-lists for use during pkg_postinst
	cp -r ${S}/rc-lists ${D}/usr/share/baselayout

	# uclibc doesn't need nsswitch.conf... added by solar
	use uclibc && rm -f ${D}/etc/nsswitch.conf

	# rc-scripts version for testing of features that *should* be present
	echo "Gentoo Base System version ${SV}" > ${D}/etc/gentoo-release

	#
	# Setup files related to /dev
	#
	into /
	dosbin ${S}/sbin/MAKEDEV
	dosym ../../sbin/MAKEDEV /usr/sbin/MAKEDEV
	dosym ../sbin/MAKEDEV /dev/MAKEDEV

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
	make DESTDIR="${D}" install || die

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
}

pkg_postinst() {
	local x y

	# Reincarnate dirs from kdir/unkdir (hack for bug 9849)
	einfo "Creating directories and .keep files."
	einfo "Some of these might fail if they're read-only mounted"
	einfo "filesystems, for example /dev or /proc.  That's okay!"
	source ${ROOT}/usr/share/baselayout/mkdirs.sh

	# This could be done in src_install, which would have the benefit of
	# (1) devices.tar.bz2 would show up in CONTENTS
	# (2) binary installations would be faster... just untar the devices tarball
	#     instead of needing to run MAKEDEV
	# However the most common cases are that people are either updating
	# baselayout or installing from scratch.  In the installation case, it's no
	# different to have here instead of src_install.  In the update case, we
	# save a couple minutes time by refraining from building the unnecessary
	# tarball.
	if [[ ! -f "${ROOT}/lib/udev-state/devices.tar.bz2" ]]; then
		# Create a directory in which to work
		x=$(mktemp -d ${ROOT}/tmp/devnodes.XXXXXXXXX) \
			&& cd "${x}" || die 'mktemp failed'

		# Create temp device nodes
		echo
		einfo "Making device node tarball (this could take a couple minutes)"
		PATH="${ROOT}/sbin:${PATH}" create_dev_nodes

		# Now create tarball that can also be used for udev.
		# Need GNU tar for -j so call it by absolute path.
		/bin/tar cjlpf "${ROOT}/lib/udev-state/devices.tar.bz2" *
		rm -r *
		cd ..
		rmdir "${x}"
	fi

	# We don't want to create devices if this is not a bootstrap and devfs
	# is used, as this was the cause for all the devfs problems we had
	if use build || use bootstrap; then
		if [[ ! -e "${ROOT}/dev/.devfsd" && ! -e "${ROOT}/dev/.udev" ]]; then
			einfo "Populating /dev with device nodes..."
			cd ${ROOT}/dev || die
			/bin/tar xjpf "${ROOT}/lib/udev-state/devices.tar.bz2" || die
		fi
	fi

	# Create /boot/boot symlink in pkg_postinst because sometimes
	# /boot is a FAT filesystem.  When that is the case, then the
	# symlink will fail.  Consequently, if we create it in
	# src_install, then merge will fail.  AFAIK there is no point to
	# this symlink except for misconfigured grubs.  See bug 50108
	# (05 May 2004 agriffis)
	ln -sn . ${ROOT}/boot/boot 2>/dev/null

	# Set up default runlevel symlinks
	# This used to be done in src_install but required knowledge of ${ROOT},
	# which meant that it was effectively broken for binary installs.
	if [[ -z $(/bin/ls ${ROOT}/etc/runlevels 2>/dev/null) ]]; then
		for x in boot default nonetwork single; do
			einfo "Creating default runlevel symlinks for ${x}"
			mkdir -p ${ROOT}/etc/runlevels/${foo}
			for y in $(<${ROOT}/usr/share/baselayout/rc-lists/${foo}); do
				if [[ ! -e ${ROOT}/init.d/${y} ]]; then
					ewarn "init.d/${y} not found -- ignoring"
				else
					ln -sfn ${ROOT}/etc/init.d/${y} \
						${ROOT}/etc/runlevels/${x}/${y}
				fi
			done
		done
	fi

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
		rm -f "${ROOT}"/etc/._cfg????_{passwd,shadow,group,fstab}
	fi

	# Reload init to fix unmounting problems of / on next reboot.
	# This is really needed, as without the new version of init cause init
	# not to quit properly on reboot, and causes a fsck of / on next reboot.
	if [[ ${ROOT} == / ]] && ! use build && ! use bootstrap; then
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
