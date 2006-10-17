# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/baselayout/baselayout-1.13.0_alpha2.ebuild,v 1.2 2006/10/17 11:58:18 uberlord Exp $

inherit flag-o-matic eutils toolchain-funcs multilib

DESCRIPTION="Filesystem baselayout and init scripts"
HOMEPAGE="http://www.gentoo.org/"
SRC_URI="mirror://gentoo/${P}.tar.bz2
	http://dev.gentoo.org/~uberlord/baselayout/${P}.tar.bz2
	http://dev.gentoo.org/~azarah/baselayout/${P}.tar.bz2
	http://dev.gentoo.org/~vapier/dist/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~sparc-fbsd ~x86 ~x86-fbsd"
IUSE="bootstrap build pam static unicode kernel_linux kernel_FreeBSD"

# This version of baselayout needs awk in /bin, but as we do not have
# a c++ compiler during bootstrap, we cannot depend on it if "bootstrap"
# or "build" are in USE.
RDEPEND="kernel_linux? ( >=sys-apps/sysvinit-2.86-r3 )
		!build? (
			!bootstrap? (
				>=sys-libs/readline-5.0-r1
				>=app-shells/bash-3.1_p7
				kernel_linux? (
					>=sys-apps/coreutils-5.2.1
				)
				kernel_FreeBSD? (
					sys-process/fuser-bsd
					sys-process/pidof-bsd
				)
			)
		)
		pam? ( virtual/pam )
		!<net-misc/dhcpcd-2.0.0"
DEPEND="virtual/os-headers"
PROVIDE="virtual/baselayout"

src_unpack() {
	unpack ${A}
	cd "${S}"

	# Setup unicode defaults for silly unicode users
	if use unicode ; then
		sed -i -e '/^UNICODE=/s:no:yes:' etc/rc.conf
	fi

	# SPARC does not like stty, so we disable RC_INTERACTIVE which requires it
	# see Gentoo bug #104067.
	if use sparc ; then \
		sed -i -e  '/^KEYMAP=/s:us:sunkeymap:' etc/conf.d/keymaps || die
		sed -i -e '/^RC_INTERACTIVE=/s:yes:no:' etc/conf.d/rc || die
	fi
}

make_opts() {
	# Standard options
	local opts="ROOT=\"${ROOT}\" DESTDIR=\"${D}\" ARCH=\"$(tc-arch)\""
	local libdir="lib"

	[[ ${SYMLINK_LIB} == "yes" ]] && libdir=$(get_abi_LIBDIR "${DEFAULT_ABI}")

	opts="${opts} LIB=${libdir}"

	if use kernel_linux ; then
		opts="${opts} OS=Linux"
	else
		opts="${opts} OS=BSD"
	fi

	use pam && opts="${opts} HAVE_PAM=1"

	echo "${opts}"
}

src_compile() {
	use static && append-ldflags -static
	emake $(make_opts) || die
}

# Support function for remapping old wireless dns vars
remap_dns_vars() {
	if [[ -f "${ROOT}/etc/conf.d/$1" ]]; then
		sed -e 's/\<domain_/dns_domain_/g' \
			-e 's/\<mac_domain_/mac_dns_domain_/g' \
			-e 's/\<nameservers_/dns_servers_/g' \
			-e 's/\<mac_nameservers_/mac_dns_servers_/g' \
			-e 's/\<searchdomains_/dns_search_domains_/g' \
			-e 's/\<mac_searchdomains_/mac_dns_search_domains_/g' \
			"${ROOT}/etc/conf.d/$1" > "${IMAGE}/etc/conf.d/$1"
	fi
}

pkg_preinst() {
	cd "${S}"

	if use build || use bootstrap ; then
		make $(make_opts) layout || die "failed to layout filesystem"
	fi

	if use kernel_linux ; then
		if use build || use bootstrap ; then
			# Create base directories
			if [[ ! -e ${ROOT}/dev/.udev && ! -e ${ROOT}/dev/.devfsd ]] ; then
				einfo "Creating dev nodes"
				make $(make_opts) dev || die "failed to create /dev nodes"
			fi
		elif [[ -w ${ROOT} ]] ; then
			# Ensure that we have /dev/null and /dev/console at least
			einfo "Ensuring that /dev/null and /dev/console exist on ${ROOT}dev"
			mount -o bind / "${T}"
			make DESTDIR="${T}" ARCH="$(tc-arch)" basedev &>/dev/null
			umount "${T}"
		fi
	fi

	# Change some vars introduced in baselayout-1.11.0 before we go stable
	# The new names make more sense and allow nis_domain
	# for use in baselayout-1.12.0
	remap_dns_vars net
	remap_dns_vars wireless
}

src_install() {
	make $(make_opts) install
	dodoc ChangeLog COPYRIGHT
	use kernel_linux && dodoc sbin.Linux/MAKEDEV.copyright

	# Should this belong in another ebuild? Like say binutils?
	# List all the multilib libdirs in /etc/env/04multilib (only if they're
	# actually different from the normal
	if has_multilib_profile || [[ $(get_libdir) != "lib" || -n ${CONF_MULTILIBDIR} ]]; then
		local libdirs="$(get_all_libdirs)" libdirs_env=
		: ${libdirs:=lib}	# it isn't that we don't trust multilib.eclass...
		for dir in ${libdirs}; do
			libdirs_env=${libdirs_env:+$libdirs_env:}/${dir}:/usr/${dir}:/usr/local/${dir}
		done

		# Special-case uglyness... For people updating from lib32 -> lib amd64
		# profiles, keep lib32 in the search path while it's around
		if has_multilib_profile && [ -d /lib32 -o -d /usr/lib32 ] && ! hasq lib32 ${libdirs}; then
			libdirs_env="${libdirs_env}:/lib32:/usr/lib32:/usr/local/lib32"
		fi
		echo "LDPATH=\"${libdirs_env}\"" > "${D}"/etc/env.d/04multilib
	fi

	# rc-scripts version for testing of features that *should* be present
	echo "Gentoo Base System version ${PV}" > "${D}"/etc/gentoo-release

	# Remove the installed runlevels, as we don't know about $ROOT yet
	rm -rf "${D}/etc/runlevels"
}

pkg_postinst() {
	# We installed some files to /usr/share/baselayout instead of /etc to stop
	# (1) overwriting the user's settings
	# (2) screwing things up when attempting to merge files
	# (3) accidentally packaging up personal files with quickpkg
	# If they don't exist then we install them
	for x in master.passwd passwd shadow group fstab ; do
		[[ -e "${ROOT}etc/${x}" ]] && continue
		[[ -e "${ROOT}usr/share/baselayout/${x}" ]] || continue
		cp -p "${ROOT}usr/share/baselayout/${x}" ${ROOT}etc
	done

	# Make our runlevels if they don't exist
	if [[ ! -e ${ROOT}etc/runlevels ]] ; then
		einfo "Making default runlevels"
		cd "${S}"
		make $(make_opts) DESTDIR="${ROOT}" runlevels_install >/dev/null
	fi

	# Reload init to fix unmounting problems of / on next reboot.
	# This is really needed, as without the new version of init cause init
	# not to quit properly on reboot, and causes a fsck of / on next reboot.
	if [[ ${ROOT} == / ]] && ! use build && ! use bootstrap; then
		# We need to copy svcdir if it's empty
		if [[ ! -e ${ROOT}lib/rcscripts/init.d/deptree ]] ; then
			(
			source "${ROOT}etc/conf.d/rc"
			svcdir="${svcdir:-/var/lib/init.d}"
			if [[ -e ${ROOT}${svcdir}/deptree ]] ; then
				cp -RPp "${ROOT}${svcdir}"/* ${ROOT}lib/rcscripts/init.d
			fi
			)
		fi

		# Regenerate init.d dependency tree
		/sbin/depscan.sh --update >/dev/null

		# Regenerate /etc/modules.conf, else it will fail at next boot
		if [[ -x /sbin/modules-update ]] ; then
			einfo "Updating module dependencies..."
			/sbin/modules-update force >/dev/null
		fi
	else
		rm -f "${ROOT}"/etc/modules.conf
	fi

	# This is also written in src_install (so it's in CONTENTS), but
	# write it here so that the new version is immediately in the file
	# (without waiting for the user to do etc-update)
	rm -f "${ROOT}"/etc/._cfg????_gentoo-release
	echo "Gentoo Base System version ${PV}" > "${ROOT}"/etc/gentoo-release

	echo
	einfo "Please be sure to update all pending '._cfg*' files in /etc,"
	einfo "else things might break at your next reboot!	 You can use 'etc-update'"
	einfo "to accomplish this:"
	einfo
	einfo "	 # etc-update"
	echo

	local lo="net.lo0"
	use kernel_linux && lo="net.lo"
	for f in ${ROOT}etc/init.d/net.*; do
		[[ -L ${f} ]] && continue
		echo
		einfo "WARNING: You have older net.* files in ${ROOT}etc/init.d/"
		einfo "They need to be converted to symlinks to ${lo}.	If you haven't"
		einfo "made personal changes to those files, you can update with the"
		einfo "following command:"
		einfo
		einfo "	 /bin/ls ${ROOT}etc/init.d/net.* | grep -v '/${lo}$' | xargs -n1 ln -sfvn ${lo}"
		echo
		break
	done

	if sed -e 's/#.*//' "${ROOT}"etc/conf.d/{net,wireless} 2>/dev/null \
		| egrep -q '\<(domain|nameservers|searchdomains)_' ; then
			echo
			ewarn "You have depreciated variables in ${ROOT}etc/conf.d/net"
			ewarn "or ${ROOT}etc/conf.d/wireless"
			ewarn
			ewarn "domain_* -> dns_domain_*"
			ewarn "nameservers_* -> dns_servers_*"
			ewarn "searchdomains_* -> dns_search_domains_*"
			ewarn
			ewarn "They have been converted for you - ensure that you"
			ewarn "update them via 'etc-update'"
			echo
	fi

	if sed -e 's/#.*//' "${ROOT}"etc/conf.d/net 2>/dev/null \
		| egrep -q '\<(ifconfig|aliases|broadcasts|netmasks|inet6|ipaddr|iproute)_'; then
			echo
			ewarn "You are using deprecated variables in ${ROOT}etc/conf.d/net"
			ewarn
			ewarn "You are advised to review the new configuration variables as"
			ewarn "found in ${ROOT}etc/conf.d/net.example as there is no"
			ewarn "guarantee that they will work in future versions."
			echo
	fi

	# Remove old stuff that may cause problems.
	if [[ -e "${ROOT}"/etc/env.d/01hostname ]] ; then
		rm -f "${ROOT}"/etc/env.d/01hostname
	fi
	if [[ -e "${ROOT}"/etc/init.d/domainname ]] ; then
		rm -f "${ROOT}"/etc/{conf.d,init.d}/domainname \
			"${ROOT}"/etc/runlevels/*/domainname
		ewarn "The domainname init script has been removed in this version."
		ewarn "Consult ${ROOT}etc/conf.d/net.example for details about how"
		ewarn "to apply dns/nis information to the loopback interface."
	fi
}
