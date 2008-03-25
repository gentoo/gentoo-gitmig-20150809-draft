inherit eutils flag-o-matic multilib toolchain-funcs

DESCRIPTION="OpenRC manages the services, startup and shutdown of a host"
HOMEPAGE="http://roy.marples.name/openrc"
#SRC_URI="http://roy.marples.name/${PN}/${P}.tar.bz2"
SRC_URI="mirror://gentoo/${P}.tar.bz2
	http://dev.gentoo.org/~cardoe/files/${P}.tar.bz2"
LICENSE="BSD-2"
SLOT="0"
#KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~sh ~sparc ~sparc-fbsd ~x86 ~x86-fbsd"
KEYWORDS=""
IUSE="debug ncurses pam static unicode kernel_linux kernel_FreeBSD"

RDEPEND="virtual/init
 		kernel_linux? ( >=sys-apps/module-init-tools-3.2.2-r2 )
		kernel_FreeBSD? ( sys-process/fuser-bsd )
		ncurses? ( sys-libs/ncurses )
		pam? ( virtual/pam )
		>=sys-apps/baselayout-2.0.0
		!<sys-fs/udev-118-r2"
DEPEND="virtual/os-headers
		>=sys-apps/baselayout-2.0.0"

S="${WORKDIR}/${PN}-0.2"

pkg_setup() {
	LIBDIR="lib"
	[ "${SYMLINK_LIB}" = "yes" ] && LIBDIR=$(get_abi_LIBDIR "${DEFAULT_ABI}")

	MAKE_ARGS="${MAKE_ARGS} LIBNAME=${LIBDIR}"

	local brand="Unknown"
	if use kernel_linux ; then
		MAKE_ARGS="${MAKE_ARGS} OS=Linux"
		brand="Linux"
	elif use kernel_FreeBSD; then
		MAKE_ARGS="${MAKE_ARGS} OS=FreeBSD SUBOS=BSD"
		brand="FreeBSD"
	fi

	export BRANDING="Gentoo ${brand}"
	export DEBUG=$(usev debug)
	export MKTERMCAP=$(usev ncurses)
	export MKPAM=$(use static || usev pam)

	if use static; then
		if use elibc_glibc; then
			export PROGLDFLAGS="-Wl,-Bstatic"
		else
			export PROGLDFLAGS="-static"
		fi
	fi

	if use pam && use static; then
		ewarn "OpenRC cannot be built statically with PAM"
		elog "not building PAM support"
	fi

	MAKE_ARGS="${MAKE_ARGS} CC=$(tc-getCC)"
}

src_compile() {
	emake ${MAKE_ARGS} || die "emake ${MAKE_ARGS} failed"
}

src_install() {
	emake ${MAKE_ARGS} DESTDIR="${D}" install || die "make install failed"

	# Portage likes to remove our mount points for the state dir
	keepdir /"${LIBDIR}"/rc/init.d
	keepdir /"${LIBDIR}"/rc/tmp

	# Backup our default runlevels
	dodir /usr/share/"${PN}"
	mv "${D}/etc/runlevels" "${D}/usr/share/${PN}"

	# Setup unicode defaults for silly unicode users
	use unicode && sed -i -e '/^unicode=/s:NO:YES:' "${D}"/etc/rc.conf

	# Fix portage bitching
	gen_usr_ldscript libeinfo.so
	gen_usr_ldscript librc.so
}

pkg_preinst() {
	# skip migration if we already have openrc installed
	has_version sys-apps/openrc && return 0

	# baselayout bootmisc init script has been split out in OpenRC
	# so handle upgraders
	local x= xtra=
	use kernel_linux && xtra="${xtra} mtab procfs sysctl"
	use kernel_FreeBSD && xtra="${xtra} dumpon savecore"
	for x in fsck root swap ${xtra}; do
		[ -e "${ROOT}"etc/runlevels/boot/"${x}" ] && continue
		ln -snf /etc/init.d/"${x}" "${ROOT}"etc/runlevels/boot/"${x}"
		elog "Auto-adding ${x} service to boot runlevel"
	done

	# Upgrade out state for baselayout-1 users
	if [ ! -e "${ROOT}${LIBDIR}"/rc/init.d/started ]; then
		(
		[ -e "${ROOT}"etc/conf.d/rc ] && . "${ROOT}etc/conf.d/rc"
		svcdir=${svcdir:-/var/lib/init.d}
		if [ ! -d "${ROOT}${svcdir}/started" ]; then
			ewarn "No state found, and no state exists"
			elog "You should reboot this host"
		else
			mkdir -p "${ROOT}${LIBDIR}/rc/init.d"
			einfo "Moving state from ${ROOT}${svcdir} to ${ROOT}${LIBDIR}/rc/init.d"
			mv "${ROOT}${svcdir}"/* "${ROOT}${LIBDIR}"/rc/init.d
			rm -rf "${ROOT}${LIBDIR}"/rc/init.d/daemons \
				"${ROOT}${LIBDIR}"/rc/init.d/console
			umount "${ROOT}${svcdir}" 2>/dev/null
			rm -rf "${ROOT}${svcdir}"
		fi
		)
	fi

	# Handle the /etc/modules.autoload.d -> /etc/conf.d/modules transition
	if [[ -d ${ROOT}/etc/modules.autoload.d ]] ; then
		elog "Converting your /etc/modules.autoload.d/ files to /etc/conf.d/modules"
		rm -f "${ROOT}"/etc/modules.autoload.d/.keep*
		rmdir "${ROOT}"/etc/modules.autoload.d 2>/dev/null
		if [[ -d ${ROOT}/etc/modules.autoload.d ]] ; then
			local f v
			for f in "${ROOT}"/etc/modules.autoload.d/* ; do
				v=${f##*/}
				v=${v#kernel-}
				v=${v//[^[:alnum:]]/_}
				gawk -v v="${v}" -v f="${f##*/}" '
				BEGIN { print "\n### START: Auto-converted from " f "\n" }
				{
					if ($0 ~ /^[^#]/) {
						print "modules_" v "=\"${modules_" v "} " $1 "\""
						gsub(/[^[:alnum:]]/, "_", $1)
						printf "module_" $1 "_args_" v "=\""
						for (i = 2; i <= NF; ++i) {
							if (i > 2)
								printf " "
							printf $i
						}
						print "\"\n"
					} else
						print
				}
				END { print "\n### END: Auto-converted from " f "\n" }
				' "${f}" >> "${D}"/etc/conf.d/modules
			done
				rm -f "${f}"
			rmdir "${ROOT}"/etc/modules.autoload.d 2>/dev/null
		fi
	fi
}

pkg_postinst() {
	# Remove old baselayout links
	rm -f "${ROOT}"etc/runlevels/boot/{check{fs,root},rmnologin}

	# Make our runlevels if they don't exist
	if [ ! -e "${ROOT}"etc/runlevels ]; then
		einfo "Copying across default runlevels"
		cp -RPp "${ROOT}"usr/share/${PN}/runlevels "${ROOT}"/etc
	fi

	if [ -d "${ROOT}"etc/modules.autoload.d ]; then
		ewarn "${ROOT}etc/modules.autoload.d exists"
		ewarn "This has been deprecated in favour of /etc/conf.d/modules"
	fi

	elog "You should now update all files in /etc, using etc-update"
	elog "or equivalent before restarting any services or this host."
}
