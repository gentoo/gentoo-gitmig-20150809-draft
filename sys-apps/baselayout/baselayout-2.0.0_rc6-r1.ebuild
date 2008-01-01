# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/baselayout/baselayout-2.0.0_rc6-r1.ebuild,v 1.2 2008/01/01 18:30:57 vapier Exp $

inherit flag-o-matic eutils toolchain-funcs multilib

DESCRIPTION="Filesystem baselayout and init scripts"
HOMEPAGE="http://www.gentoo.org/"
SRC_URI="mirror://gentoo/${P}.tar.bz2
	http://dev.gentoo.org/~uberlord/baselayout/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~ppc ~ppc64 ~s390 ~sh ~sparc ~sparc-fbsd ~x86 ~x86-fbsd"
IUSE="bootstrap build pam static unicode kernel_linux kernel_FreeBSD"

RDEPEND="virtual/init
		!build? (
			!bootstrap? (
				kernel_linux? ( >=sys-apps/coreutils-5.2.1 )
				kernel_FreeBSD? ( sys-process/fuser-bsd )
			)
		)
		pam? ( virtual/pam )
		!<net-misc/dhcpcd-2.0.0"
DEPEND="virtual/os-headers"
PDEPEND="virtual/init
	!build? ( !bootstrap? (
		kernel_linux? ( >=sys-apps/module-init-tools-3.2.2-r2 sys-apps/makedev )
	) )"

PROVIDE="virtual/baselayout"

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}"/${P}-ssd-path.patch

	# Setup unicode defaults for silly unicode users
	if use unicode ; then
		sed -i -e '/^UNICODE=/s:no:yes:' etc/rc.conf
	fi
}

make_opts() {
	local libdir="lib"
	[ "${SYMLINK_LIB}" = "yes" ] && libdir=$(get_abi_LIBDIR "${DEFAULT_ABI}")
	local opts="${opts} LIB=${libdir}"

	if use kernel_linux; then
		opts="${opts} OS=Linux"
	else
		opts="${opts} OS=BSD"
	fi
	use pam && opts="${opts} PAM=pam"

	echo "${opts}"
}

src_compile() {
	use static && append-ldflags -static
	emake $(make_opts) ARCH=$(tc-arch) CC=$(tc-getCC) || die
}

pkg_preinst() {
	# Move our makefiles to a temporay location
	mv "${D}"/usr/share/baselayout/{Makefile,default.mk,runlevels}* "${T}"

	# We need to install directories and maybe some dev nodes when building
	# stages, but they cannot be in CONTENTS.
	# Also, we cannot reference $S as binpkg will break so we do this.
	if use build || use bootstrap ; then
		local libdirs="$(get_all_libdirs)" dir=
		# Create our multilib dirs - the Makefile has no knowledge of this
		: ${libdirs:=lib}	# it isn't that we don't trust multilib.eclass...
		for dir in ${libdirs}; do
			mkdir -p "${ROOT}${dir}"
			touch "${ROOT}${dir}"/.keep
			mkdir -p "${ROOT}usr/${dir}"
			touch "${ROOT}usr/${dir}"/.keep
			mkdir -p "${ROOT}usr/local/${dir}"
			touch "${ROOT}usr/local/${dir}"/.keep
		done

		# Ugly compatibility with stupid ebuilds and old profiles symlinks
		if [ "${SYMLINK_LIB}" = "yes" ] ; then
			rm -r "${ROOT}"/{lib,usr/lib,usr/local/lib} 2>/dev/null
			local lib=$(get_abi_LIBDIR ${DEFAULT_ABI})
			ln -s "${lib}" "${ROOT}lib"
			ln -s "${lib}" "${ROOT}usr/lib"
			ln -s "${lib}" "${ROOT}usr/local/lib"
		fi

		emake -C "${T}" $(make_opts) DESTDIR="${ROOT}" layout || die "failed to layout filesystem"
	fi
}

src_install() {
	emake $(make_opts) DESTDIR="${D}" install || die
	dodoc ChangeLog COPYRIGHT

	# Should this belong in another ebuild? Like say binutils?
	# List all the multilib libdirs in /etc/env/04multilib (only if they're
	# actually different from the normal
	if has_multilib_profile || [ $(get_libdir) != "lib" -o -n "${CONF_MULTILIBDIR}" ]; then
		local libdirs="$(get_all_libdirs)" libdirs_env= dir=
		: ${libdirs:=lib}	# it isn't that we don't trust multilib.eclass...
		for dir in ${libdirs}; do
			libdirs_env=${libdirs_env:+$libdirs_env:}/${dir}:/usr/${dir}:/usr/local/${dir}
		done

		# Special-case uglyness... For people updating from lib32 -> lib amd64
		# profiles, keep lib32 in the search path while it's around
		if has_multilib_profile && [ -d "${ROOT}"lib32 -o -d "${ROOT}"lib32 ] && ! hasq lib32 ${libdirs}; then
			libdirs_env="${libdirs_env}:/lib32:/usr/lib32:/usr/local/lib32"
		fi
		echo "LDPATH=\"${libdirs_env}\"" > "${T}"/04multilib
		doenvd "${T}"/04multilib
	fi

	# rc-scripts version for testing of features that *should* be present
	echo "Gentoo Base System release ${PV}" > "${D}"/etc/gentoo-release

	# Remove the installed runlevels, as we don't know about $ROOT yet
	rm -rf "${D}/etc/runlevels"

	# Copy the make files to /usr/share/baselayout so we can re-use them in
	# postinst, otherwise binpkg will break.
	insinto /usr/share/baselayout
	doins -r Makefile default.mk runlevels*

	gen_usr_ldscript libeinfo.so librc.so
}

pkg_postinst() {
	# Make our runlevels if they don't exist
	if [ ! -e "${ROOT}"etc/runlevels ]; then
		einfo "Making default runlevels"
		make -C "${T}" $(make_opts) DESTDIR="${ROOT}" runlevels_install >/dev/null
	fi

	# We installed some files to /usr/share/baselayout instead of /etc to stop
	# (1) overwriting the user's settings
	# (2) screwing things up when attempting to merge files
	# (3) accidentally packaging up personal files with quickpkg
	# If they don't exist then we install them
	for x in master.passwd passwd shadow group fstab ; do
		[ -e "${ROOT}etc/${x}" ] && continue
		[ -e "${ROOT}usr/share/baselayout/${x}" ] || continue
		cp -p "${ROOT}usr/share/baselayout/${x}" "${ROOT}"etc
	done

	# We need to copy svcdir if upgrading
	if has_version "<sys-apps/${PN}-1.13.0_alpha" ; then
		(
		. "${ROOT}etc/conf.d/rc"
		svcdir="${svcdir:-/var/lib/init.d}"
		einfo "Moving state from ${ROOT}${svcdir} to ${ROOT}lib/rc/init.d"
		cp -RPp "${ROOT}${svcdir}"/* "${ROOT}"lib/rc/init.d
		rm -rf "${ROOT}"lib/rc/init.d/daemons \
			"${ROOT}"lib/rc/init.d/console
		umount "${ROOT}${svcdir}" 2>/dev/null
		rm -rf "${ROOT}${svcdir}"
		)
	elif has_version "<sys-apps/${PN}-2.0.0_rc5" ; then
		if [ -d "${ROOT}"lib/rcscripts/init.d ] ; then
			einfo "Moving state from ${ROOT}lib/rcscripts/init.d to ${ROOT}lib/rc/init.d"
			cp -RPp "${ROOT}"lib/rcscripts/init.d/* "${ROOT}"lib/rc/init.d
			umount "${ROOT}lib/rcscripts/init.d" 2>/dev/null
			rm -rf "${ROOT}"lib/rcscripts/init.d
			[ -d "${ROOT}"lib/rcscripts/console ] && \
				mv  "${ROOT}"lib/rcscripts/console "${ROOT}"lib/rc
		fi
	fi

	if [ "${ROOT}" = / ] && ! use build && ! use bootstrap; then
		/$(get_libdir)/rc/bin/rc-depend --update
	fi

	# This is also written in src_install (so it's in CONTENTS), but
	# write it here so that the new version is immediately in the file
	# (without waiting for the user to do etc-update)
	rm -f "${ROOT}"/etc/._cfg????_gentoo-release
	local release="${PV}"
	[ "${PR}" != r0 ] && release="${release}-${PR}"
	echo "Gentoo Base System release ${release}" > "${ROOT}"/etc/gentoo-release

	echo
	einfo "Please be sure to update all pending '._cfg*' files in /etc,"
	einfo "else things might break at your next reboot!	 You can use 'etc-update'"
	einfo "to accomplish this:"
	einfo
	einfo "	 # etc-update"

	echo
	ewarn "WARNING: The way we contruct posix shell arrays has changed in rc6"
	elog "You are advised to read the new method in /etc/conf.d/net.example"

	local lo="net.lo0"
	use kernel_linux && lo="net.lo"
	for f in "${ROOT}"etc/init.d/net.*; do
		[ -L "${f}" -o "${f}" = "${ROOT}etc/init.d/${lo}" ] && continue
		echo
		einfo "WARNING: You have older net.* files in ${ROOT}etc/init.d/"
		einfo "They need to be converted to symlinks to ${lo}.	If you haven't"
		einfo "made personal changes to those files, you can update with the"
		einfo "following command:"
		einfo
		einfo "	 /bin/ls ${ROOT}etc/init.d/net.* | grep -v '/${lo}$' | xargs -n1 ln -sfvn ${lo}"
		break
	done

	# whine about users that lack passwords #193541
	if [ -e "${ROOT}"/etc/shadow ]; then
		local bad_users=$(sed -n '/^[^:]*::/s|^\([^:]*\)::.*|\1|p' "${ROOT}"/etc/shadow)
		if [ -n "${bad_users}" ] ; then
			echo
			ewarn "The following users lack passwords!"
			ewarn ${bad_users}
		fi
	fi
}

# Handle our downgraders
# We should remove this when <1.13 has been removed from the tree
pkg_postrm() {
	# Remove dir if downgrading
	if has_version "<sys-apps/${PN}-1.13.0_alpha" ; then
		(
		. "${ROOT}etc/conf.d/rc"
		svcdir="${svcdir:-/var/lib/init.d}"
		einfo "Moving state from ${ROOT}lib/rc/init.d to ${ROOT}${svcdir}"
		mkdir -p "${ROOT}${svcdir}"
		cp -RPp "${ROOT}lib/rc/init.d"/* "${ROOT}${svcdir}"
		rm -rf "${ROOT}${svcdir}"/daemons
		umount "${ROOT}lib/rc/init.d" 2>/dev/null
		rm -rf "${ROOT}lib/rc/init.d" "${ROOT}lib/rc/console"
		rmdir "${ROOT}lib/rc" 2>/dev/null
		)
	elif has_version "<sys-apps/${PN}-2.0.0_rc5" ; then
		einfo "Moving state from ${ROOT}lib/rc/init.d to ${ROOT}lib/rcscripts/init.d"
		mkdir -p "${ROOT}"lib/rcscripts/init.d
		cp -RPp "${ROOT}"lib/rc/init.d/* "${ROOT}"lib/rcscripts/init.d
		umount "${ROOT}"lib/rc/init.d 2>/dev/null
		rm -rf "${ROOT}"lib/rc/init.d
		[ -d "${ROOT}"/lib/rc/console ] && \
			mv "${ROOT}"lib/rc/console "${ROOT}"lib/rcscripts
		rmdir "${ROOT}"lib/rc 2>/dev/null
	fi
}
