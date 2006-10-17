# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/shadow/shadow-4.0.16-r2.ebuild,v 1.2 2006/10/17 14:21:36 dsd Exp $

inherit eutils libtool toolchain-funcs flag-o-matic autotools pam

# We should remove this login after pam-0.78 goes stable.
FORCE_SYSTEMAUTH_UPDATE="no"

DESCRIPTION="Utilities to deal with user accounts"
HOMEPAGE="http://shadow.pld.org.pl/"
SRC_URI="ftp://ftp.pld.org.pl/software/${PN}/${P}.tar.bz2"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86"
IUSE="nls pam selinux skey nousuid cracklib"

RDEPEND="cracklib? ( >=sys-libs/cracklib-2.7-r3 )
	pam? ( virtual/pam )
	!sys-apps/pam-login
	skey? ( app-admin/skey )
	selinux? ( >=sys-libs/libselinux-1.28 )
	nls? ( virtual/libintl )"
DEPEND="${RDEPEND}
	>=sys-apps/portage-2.0.51-r2
	nls? ( sys-devel/gettext )"

src_unpack() {
	unpack ${A}
	cd "${S}"

	# uclibc support, corrects NIS usage
	epatch "${FILESDIR}"/${PN}-4.0.13-nonis.patch

	# If su should not simulate a login shell, use '/bin/sh' as shell to enable
	# running of commands as user with /bin/false as shell, closing bug #15015.
	# *** This one could be a security hole; disable for now ***
	#epatch "${FILESDIR}"/${P}-nologin-run-sh.patch

	# tweak the default login.defs
	epatch "${FILESDIR}"/${PN}-4.0.13-login.defs.patch

	# Make user/group names more flexible #3485 / #22920
	epatch "${FILESDIR}"/${PN}-4.0.13-dots-in-usernames.patch
	epatch "${FILESDIR}"/${PN}-4.0.13-long-groupnames.patch

	# Fix compiling with gcc-2.95.x
	epatch "${FILESDIR}"/${PN}-4.0.12-gcc2.patch

	# Patch from upstream enables the new environment too early for PAM
	epatch "${FILESDIR}"/${PN}-4.0.14-su-fix-environment.patch

	# lock down setuid perms #47208
	epatch "${FILESDIR}"/${PN}-4.0.11.1-perms.patch

	epatch "${FILESDIR}"/${PN}-4.0.15-uclibc-missing-l64a.patch

	epatch "${FILESDIR}"/${PN}-4.0.16-check-opendir.patch #139148
	epatch "${FILESDIR}"/${PN}-4.0.16-fix-useradd-usergroups.patch #128715
	epatch "${FILESDIR}"/${PN}-4.0.16-mail-creation.patch #139346

	# Needed by the UCLIBC patches
	eautoconf || die

	elibtoolize
	epunt_cxx
}

src_compile() {
	append-ldflags $(bindnow-flags)
	tc-is-cross-compiler && export ac_cv_func_setpgrp_void=yes
	econf \
		--disable-desrpc \
		--with-libcrypt \
		--enable-shared=no \
		--enable-static=yes \
		$(use_with cracklib libcrack) \
		$(use_with pam libpam) \
		$(use_with skey) \
		$(use_with selinux) \
		$(use_enable nls) \
		|| die "bad configure"
	emake || die "compile problem"
}

src_install() {
	local perms=4711
	use nousuid && perms=711
	make DESTDIR="${D}" suiduperms=${perms} install || die "install problem"
	dosym useradd /usr/sbin/adduser

	# Remove libshadow and libmisc; see bug 37725 and the following
	# comment from shadow's README.linux:
	#   Currently, libshadow.a is for internal use only, so if you see
	#   -lshadow in a Makefile of some other package, it is safe to
	#   remove it.
	rm -f "${D}"/{,usr/}$(get_libdir)/lib{misc,shadow}.{a,la}

	insinto /etc
	# Using a securetty with devfs device names added
	# (compat names kept for non-devfs compatibility)
	insopts -m0600 ; doins "${FILESDIR}"/securetty
	if ! use pam ; then
		insopts -m0600
		doins etc/login.access etc/limits
	else
		newpamd "${FILESDIR}/login.pamd" login
		use selinux || sed -i -e '/@selinux@/d' "${D}"/etc/pam.d/login
		use selinux && sed -i -e 's:@selinux@::g' "${D}"/etc/pam.d/login

		insinto /etc
		insopts -m0644
		newins "${FILESDIR}/login.defs" login.defs

		# Also install another one that we can use to check if
		# we need to update it if FORCE_LOGIN_DEFS = "yes"
		[ "${FORCE_LOGIN_DEFS}" = "yes" ] \
			&& newins "${FILESDIR}/login.defs" login.defs.new
	fi
	# Output arch-specific cruft
	case $(tc-arch) in
		ppc*)  echo "hvc0" >> "${D}"/etc/securetty
		       echo "hvsi0" >> "${D}"/etc/securetty;;
		hppa)  echo "ttyB0" >> "${D}"/etc/securetty;;
		arm)   echo "ttyFB0" >> "${D}"/etc/securetty;;
	esac

	# needed for 'adduser -D'
	insinto /etc/default
	insopts -m0600
	doins "${FILESDIR}"/default/useradd

	# move passwd to / to help recover broke systems #64441
	mv "${D}"/usr/bin/passwd "${D}"/bin/
	dosym /bin/passwd /usr/bin/passwd

	if use pam ; then
		local INSTALL_SYSTEM_PAMD="yes"

		# Do not install below pam.d files if we have pam-0.78 or later
		has_version '>=sys-libs/pam-0.78' && \
			INSTALL_SYSTEM_PAMD="no"

		for x in "${FILESDIR}"/pam.d-include/*; do
			case "${x##*/}" in
				"login")
					# We do no longer install this one, as its from
					# pam-login now.
					;;
				"system-auth"|"system-auth-1.1"|"other")
					# These we only install if we do not have pam-0.78
					# or later.
					[ "${INSTALL_SYSTEM_PAMD}" = "yes" ] && [ -f ${x} ] && \
						dopamd ${x}
					;;
				"su")
					# Disable support for pam_env and pam_wheel on openpam
					has_version sys-libs/pam && dopamd ${x}
					;;
				"su-openpam")
					has_version sys-libs/openpam && newpamd ${x} su
					;;
				*)
					[ -f ${x} ] && dopamd ${x}
					;;
			esac
		done
		for x in chage chsh chfn chpasswd newusers \
		         user{add,del,mod} group{add,del,mod} ; do
			newpamd "${FILESDIR}"/pam.d-include/shadow ${x}
		done

		# Only add this one if needed.
		if [ "${FORCE_SYSTEMAUTH_UPDATE}" = "yes" ]; then
			newpamd "${FILESDIR}"/pam.d-include/system-auth-1.1 system-auth.new || \
				die "Failed to install system-auth.new!"
		fi

		# remove manpages that pam will install for us
		# and/or don't apply when using pam

		find "${D}"/usr/share/man \
			'(' -name 'limits.5*' -o -name 'suauth.5*' ')' \
			-exec rm {} \;
	else
		insinto /etc
		insopts -m0644
		newins etc/login.defs login.defs
	fi

	# libshadow_getpass() is only used sometimes now which means
	# GETPASS_ASTERISKS may not always be applicable
	use skey || sed -i -e '/^GETPASS_ASTERISKS/s:^:#:' "${D}"/etc/login.defs

	# Remove manpages that are handled by other packages
	find "${D}"/usr/share/man \
		'(' -name id.1 -o -name passwd.5 -o -name getspnam.3 ')' \
		-exec rm {} \;

	cd "${S}"
	dodoc ChangeLog NEWS TODO
	newdoc README README.download
	cd doc
	dodoc HOWTO LSM README* WISHLIST *.txt
}

pkg_preinst() {
	rm -f "${ROOT}"/etc/pam.d/system-auth.new \
		"${ROOT}/etc/login.defs.new"
}

pkg_postinst() {
	# Enable shadow groups (we need ROOT=/ here, as grpconv only
	# operate on / ...).
	if [[ ${ROOT} == / && ! -f /etc/gshadow ]] ; then
		if grpck -r &>/dev/null; then
			grpconv
		else
			ewarn "Running 'grpck' returned errors.  Please run it by hand, and then"
			ewarn "run 'grpconv' afterwards!"
		fi
	fi

	use pam || return 0

	if [ "${FORCE_SYSTEMAUTH_UPDATE}" = "yes" ]; then
		local CHECK1=$(md5sum "${ROOT}"/etc/pam.d/system-auth | cut -d ' ' -f 1)
		local CHECK2=$(md5sum "${ROOT}"/etc/pam.d/system-auth.new | cut -d ' ' -f 1)

		if [ "${CHECK1}" != "${CHECK2}" ]; then
			ewarn "Due to a security issue, ${ROOT}etc/pam.d/system-auth "
			ewarn "is being updated automatically. Your old "
			ewarn "system-auth will be backed up as:"
			ewarn
			ewarn "  ${ROOT}etc/pam.d/system-auth.bak"
			echo

			cp -pPR "${ROOT}"/etc/pam.d/system-auth \
				"${ROOT}"/etc/pam.d/system-auth.bak;
			mv -f "${ROOT}"/etc/pam.d/system-auth.new \
				"${ROOT}"/etc/pam.d/system-auth
			rm -f "${ROOT}"/etc/pam.d/._cfg????_system-auth
		else
			rm -f "${ROOT}"/etc/pam.d/system-auth.new
		fi
	fi

	[ "${FORCE_LOGIN_DEFS}" != "yes" ] && return 0

	ewarn "Due to a compatibility issue, ${ROOT}etc/login.defs "
	ewarn "is being updated automatically. Your old login.defs"
	ewarn "will be backed up as:  ${ROOT}etc/login.defs.bak"
	echo

	local CHECK1="`md5sum ${ROOT}/etc/login.defs | cut -d ' ' -f 1`"
	local CHECK2="`md5sum ${ROOT}/etc/login.defs.new | cut -d ' ' -f 1`"

	if [ "${CHECK1}" != "${CHECK2}" ]
	then
		cp -pPR ${ROOT}/etc/login.defs ${ROOT}/etc/login.defs.bak
		mv -f ${ROOT}/etc/login.defs.new ${ROOT}/etc/login.defs
	elif [ ! -f ${ROOT}/etc/login.defs ]
	then
		mv -f ${ROOT}/etc/login.defs.new ${ROOT}/etc/login.defs
	else
		rm -f ${ROOT}/etc/login.defs.new
	fi
}

