# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/baselayout-vserver/baselayout-vserver-1.12.3.ebuild,v 1.2 2011/03/31 11:55:26 ulm Exp $

inherit flag-o-matic eutils toolchain-funcs multilib

DESCRIPTION="Filesystem baselayout and init scripts"
HOMEPAGE="http://www.gentoo.org/"
SRC_URI="http://dev.gentoo.org/~hollow/distfiles/${P}.tar.bz2
	http://dev.gentoo.org/~phreak/distfiles/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ppc ~sparc ~x86"
IUSE="bootstrap build static"

# This version of baselayout needs gawk in /bin, but as we do not have
# a c++ compiler during bootstrap, we cannot depend on it if "bootstrap"
# or "build" are in USE.

# We need to block old dhcpcd versions as they are no longer in system
# but may not be in users world file either. See bug #143885

RDEPEND=">=sys-apps/sysvinit-2.86-r3
	!build? ( !bootstrap? (
		>=sys-libs/readline-5.0-r1
		>=app-shells/bash-3.1_p7
		>=sys-apps/coreutils-5.2.1
	) )
	!<net-misc/dhcpcd-2.0.0"
DEPEND="virtual/os-headers
	>=sys-apps/portage-2.0.51"
PROVIDE="virtual/dev-manager"

src_unpack() {
	unpack ${A}
	cd "${S}"

	# Use correct path to filefuncs.so on multilib systems
	sed -i -e "s:/lib/rcscripts:/$(get_libdir)/rcscripts:" \
		${S}/src/awk/{cachedepends,genenviron}.awk || die
}

src_compile() {
	local libdir="lib"

	use static && append-ldflags -static

	[[ ${SYMLINK_LIB} == "yes" ]] && libdir=$(get_abi_LIBDIR "${DEFAULT_ABI}")

	make -C "${S}"/src \
		CC="$(tc-getCC)" \
		LD="$(tc-getCC) ${LDFLAGS}" \
		CFLAGS="${CFLAGS}" \
		LIBDIR="${libdir}" || die
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
if [ ! -d "\${ROOT}/${d}" ] ; then \\
	install -d ${args[@]} "\${ROOT}/${d}" 2>/dev/null \\
		|| ewarn "  can't create ${d}"
	touch "\${ROOT}/${d}/.keep" 2>/dev/null \\
		|| ewarn "  can't create ${d}/.keep"
fi
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
	find "${D}" -depth -type d -exec rmdir {} \; 2>/dev/null
	if [[ $? == 127 ]]; then
		ewarn "Problem running unkdir: find command not found"
	fi
}

# Same as kdir above, but for symlinks #103618
ksym() {
	echo "[[ ! -e ${ROOT}/$2 ]] && { ln -s '$1' '${ROOT}/$2' &> /dev/null || ewarn '  unable to symlink $2 to $1' ; }" \
		>> "${D}"/usr/share/baselayout/mklinks.sh
}

src_install() {
	local dir libdirs libdirs_env rcscripts_dir

	# This directory is to stash away things that will be used in
	# pkg_postinst; it's needed first for kdir to function
	dodir /usr/share/baselayout

	# Benedikt Boehm <hollow@gentoo.org>
	# vserver-devs don't support old stuff
	rcscripts_dir="/lib/rcscripts"

	einfo "Creating directories..."
	kdir /usr
	kdir /usr/local
	kdir /dev
	kdir /dev/pts
	kdir /dev/shm
	kdir /etc/conf.d
	kdir /etc/cron.daily
	kdir /etc/cron.hourly
	kdir /etc/cron.monthly
	kdir /etc/cron.weekly
	kdir /etc/env.d
	dodir /etc/init.d			# .keep file might mess up init.d stuff
	kdir /etc/opt
	kdir /home
	kdir ${rcscripts_dir}
	kdir ${rcscripts_dir}/awk
	kdir ${rcscripts_dir}/sh
	kdir ${rcscripts_dir}/net
	kdir /opt
	kdir -o root -g uucp -m0775 /var/lock
	kdir /proc
	kdir -m 0700 /root
	kdir /sbin
	kdir /usr/bin
	kdir /usr/include
	kdir /usr/include/asm
	kdir /usr/include/linux
	kdir /usr/local/bin
	kdir /usr/local/games
	kdir /usr/local/sbin
	kdir /usr/local/share
	kdir /usr/local/share/doc
	kdir /usr/local/share/man
	kdir /usr/local/src
	kdir ${PORTDIR}
	kdir /usr/sbin
	kdir /usr/share/doc
	kdir /usr/share/info
	kdir /usr/share/man
	kdir /usr/share/misc
	kdir /usr/src
	kdir -m 1777 /tmp
	kdir /var
	dodir /var/db/pkg			# .keep file messes up Portage
	kdir /var/lib/misc
	kdir /var/lock/subsys
	kdir /var/log/news
	kdir /var/run
	kdir /var/spool
	kdir /var/state
	kdir -m 1777 /var/tmp

	for dir in ${libdirs}; do
		libdirs_env=${libdirs_env:+$libdirs_env:}/${dir}:/usr/${dir}:/usr/local/${dir}
		[[ ${dir} == "lib" && ${SYMLINK_LIB} == "yes" ]] && continue
		kdir /${dir}
		kdir /usr/${dir}
		kdir /usr/local/${dir}
	done

	# FHS compatibility symlinks stuff
	ksym /var/tmp /usr/tmp
	ksym share/man /usr/local/man

	#
	# Setup files in /etc
	#
	insopts -m0644
	insinto /etc
	doins -r "${S}"/etc/*

	# Install some files to /usr/share/baselayout instead of /etc to keep from
	# (1) overwriting the user's settings, (2) screwing things up when
	# attempting to merge files, (3) accidentally packaging up personal files
	# with quickpkg
	fperms 0600 /etc/shadow
	mv "${D}"/etc/{passwd,shadow,group,hosts} "${D}"/usr/share/baselayout

	# doinitd doesnt respect symlinks
	dodir /etc/init.d
	cp -P "${S}"/init.d/* "${D}"/etc/init.d/ || die "doinitd"
	#doinitd "${S}"/init.d/* || die "doinitd"
	doconfd "${S}"/etc/conf.d/* || die "doconfd"
	doenvd "${S}"/etc/env.d/* || die "doenvd"

	# Special-case uglyness... For people updating from lib32 -> lib amd64
	# profiles, keep lib32 in the search path while it's around
	if has_multilib_profile && [ -d /lib32 -o -d /usr/lib32 ] && ! hasq lib32 ${libdirs}; then
		libdirs_env="${libdirs_env}:/lib32:/usr/lib32:/usr/local/lib32"
	fi

	# List all the multilib libdirs in /etc/env/04multilib (only if they're
	# actually different from the normal
	if has_multilib_profile || [[ $(get_libdir) != "lib" || -n ${CONF_MULTILIBDIR} ]]; then
		echo "LDPATH=\"${libdirs_env}\"" > ${D}/etc/env.d/04multilib
	fi

	# As of baselayout-1.10-1-r1, sysvinit is its own package again, and
	# provides the inittab itself

	# Benedikt Boehm <hollow@gentoo.org>
	# baselayout-vserver provides it's own!
	#rm -f "${D}"/etc/inittab

	# Stash the rc-lists for use during pkg_postinst
	cp -r "${S}"/rc-lists "${D}"/usr/share/baselayout

	# rc-scripts version for testing of features that *should* be present
	echo "Gentoo Base System version ${PV}" > ${D}/etc/gentoo-release

	#
	# Setup files related to /dev
	#
	into /
	dosbin "${S}"/sbin/MAKEDEV
	dosym ../../sbin/MAKEDEV /usr/sbin/MAKEDEV
	dosym ../sbin/MAKEDEV /dev/MAKEDEV

	#
	# Setup files in /bin
	#
	cd "${S}"/bin
	dobin rc-status

	#
	# Setup files in /sbin
	#
	cd "${S}"/sbin
	into /
	dosbin rc rc-update
	# These moved from /etc/init.d/ to /sbin to help newb systems
	# from breaking
	dosbin runscript.sh functions.sh

	# Compat symlinks between /etc/init.d and /sbin
	# (some stuff have hardcoded paths)
	dosym ../../sbin/depscan.sh /etc/init.d/depscan.sh
	dosym ../../sbin/runscript.sh /etc/init.d/runscript.sh
	dosym ../../sbin/functions.sh /etc/init.d/functions.sh

	#
	# Setup files in /lib/rcscripts
	# These are support files for other things in baselayout that needn't be
	# under CONFIG_PROTECTed /etc
	#
	cd "${S}"/sbin
	exeinto ${rcscripts_dir}/sh
	doexe rc-services.sh rc-daemon.sh rc-help.sh

	# We can only install new, fast awk versions of scripts
	# if 'build' or 'bootstrap' is not in USE.  This will
	# change if we have sys-apps/gawk-3.1.1-r1 or later in
	# the build image ...
	if ! use build; then
		# This is for new depscan.sh and env-update.sh
		# written in awk
		cd "${S}"/sbin
		into /
		dosbin depscan.sh
		dosbin env-update.sh
		insinto ${rcscripts_dir}/awk
		doins "${S}"/src/awk/*.awk
	fi

	# Original design had these in /etc/net.modules.d but that is too
	# problematic with CONFIG_PROTECT
	dodir ${rcscripts_dir}
	cp -pPR "${S}"/lib/rcscripts/net ${D}${rcscripts_dir}
	chown -R root:0 ${D}${rcscripts_dir}

	#
	# Install baselayout documentation
	#
	if ! use build ; then
		doman "${S}"/man/*.*
		docinto /
		dodoc ${FILESDIR}/copyright
		dodoc "${S}"/ChangeLog
		dodoc "${S}"/ChangeLog.vserver
	fi

	#
	# Install baselayout utilities
	#
	cd "${S}"/src
	make DESTDIR="${D}" LIBDIR="$(get_libdir)" install || die

	# Normal baselayout does this in pkg_postinst, but we keep it here because
	# (1) devices will show up in CONTENTS
	# (2) we just create devices if either build or bootstrap is ins USE
	# (3) it is not likely that anyone uses devfsd or udev inside a vps
	#
	# However the most common cases are that people are either updating
	# baselayout or installing from scratch.  In both cases there is no difference
	# to pkg_postinst as we only create devices when build or bootstrap is in USE.

	# Christian Heim <phreak@gentoo.org>
	# use the MAKEDEV in ${D}/sbin, otherwise we'll rely on the hosts MAKEDEV
	# which is baad
	cd ${D}/dev || die
	ebegin "Populating /dev with safe device nodes..."
	"${D}"/sbin/MAKEDEV generic-vserver &> /dev/null
	eend $? || die

	# Hack to fix bug 9849, continued in pkg_postinst
	unkdir
}

pkg_postinst() {
	local x y

	# Reincarnate dirs from kdir/unkdir (hack for bug 9849)
	einfo "Creating directories and .keep files."
	einfo "Some of these might fail if they're read-only mounted"
	einfo "filesystems, for example /dev or /proc.  That's okay!"
	source "${ROOT}"/usr/share/baselayout/mkdirs.sh
	source "${ROOT}"/usr/share/baselayout/mklinks.sh
	echo

	# Set up default runlevel symlinks
	# This used to be done in src_install but required knowledge of ${ROOT},
	# which meant that it was effectively broken for binary installs.
	if [[ -z $(/bin/ls "${ROOT}"/etc/runlevels 2>/dev/null) ]]; then
		for x in boot default nonetwork single; do
			einfo "Creating default runlevel symlinks for ${x}"
			mkdir -p "${ROOT}"/etc/runlevels/${x}
			for y in $(<"${ROOT}"/usr/share/baselayout/rc-lists/${x}); do
				if [[ ! -e ${ROOT}/etc/init.d/${y} ]]; then
					ewarn "init.d/${y} not found -- ignoring"
				else
					ln -sfn /etc/init.d/${y} \
						"${ROOT}"/etc/runlevels/${x}/${y}
				fi
			done
		done
	fi

	# Create /etc/hosts in pkg_postinst so we don't overwrite an
	# existing file during bootstrap
	if [[ ! -e ${ROOT}/etc/hosts ]]; then
		cp ${ROOT}/usr/share/baselayout/hosts ${ROOT}/etc
	fi

	# Touching /etc/passwd and /etc/shadow after install can be fatal, as many
	# new users do not update them properly...  see src_install() for why they
	# are in /usr/share/baselayout/
	for x in passwd shadow group ; do
		if [[ -e ${ROOT}/etc/${x} ]] ; then
			touch "${ROOT}/etc/${x}"
		else
			cp "${ROOT}/usr/share/baselayout/${x}" "${ROOT}/etc/${x}"
		fi
	done

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

	# Reload init to fix unmounting problems of / on next reboot.
	# This is really needed, as without the new version of init cause init
	# not to quit properly on reboot, and causes a fsck of / on next reboot.
	if [[ ${ROOT} == / ]] && ! use build && ! use bootstrap; then
		# Regenerate init.d dependency tree
		/sbin/depscan.sh --update &>/dev/null
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
	echo "Gentoo Base System version ${PV}" > ${ROOT}/etc/gentoo-release

	echo
	einfo "Please be sure to update all pending '._cfg*' files in /etc,"
	einfo "else things might break at your next reboot!  You can use 'etc-update'"
	einfo "to accomplish this:"
	einfo
	einfo "  # etc-update"
	echo

	if sed -e 's/#.*//' ${ROOT}/etc/conf.d/net 2>/dev/null \
		| egrep -q '\<(ifconfig|aliases|broadcasts|netmasks|inet6|ipaddr|iproute)_'; then
			echo
			ewarn "You are using deprecated variables in ${ROOT}/etc/conf.d/net"
			ewarn
			ewarn "You are advised to review the new configuration variables as"
			ewarn "found in ${ROOT}/etc/conf.d/net.example as there is no"
			ewarn "guarantee that they will work in future versions."
			echo
	fi

	# Remove old stuff that may cause problems.
	if [[ -e "${ROOT}"/etc/env.d/01hostname ]] ; then
		rm -f "${ROOT}"/etc/env.d/01hostname
	fi
	if [[ -e "${ROOT}"/etc/init.d/domainname ]] ; then
		rm -f "${ROOT}"/etc/init.d/domainname
		rm -f "${ROOT}"/etc/runlevels/*/domainname
		ewarn "The domainname init script has been removed in this version."
		ewarn "Consult ${ROOT}/etc/conf.d/net.example for details about how"
		ewarn "to apply dns/nis information to the loopback interface."
	fi
}
