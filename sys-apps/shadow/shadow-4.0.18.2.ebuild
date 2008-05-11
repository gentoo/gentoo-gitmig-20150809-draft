# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/shadow/shadow-4.0.18.2.ebuild,v 1.11 2008/05/11 13:11:56 ulm Exp $

inherit eutils libtool toolchain-funcs autotools pam multilib

DESCRIPTION="Utilities to deal with user accounts"
HOMEPAGE="http://shadow.pld.org.pl/ http://packages.qa.debian.org/s/shadow.html"
SRC_URI="mirror://debian/pool/main/s/shadow/shadow_${PV}.orig.tar.gz"

LICENSE="BSD GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 m68k ~mips ppc ppc64 s390 sh sparc x86"
IUSE="nls pam selinux skey nousuid cracklib"

RDEPEND="cracklib? ( >=sys-libs/cracklib-2.7-r3 )
	pam? ( >=sys-libs/pam-0.99 )
	!sys-apps/pam-login
	!app-admin/nologin
	skey? ( sys-auth/skey )
	selinux? ( >=sys-libs/libselinux-1.28 )
	nls? ( virtual/libintl )"
DEPEND="${RDEPEND}
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
	epatch "${FILESDIR}"/${PN}-4.0.17-login.defs.patch
	sed -i "s:@LIBDIR@:$(get_libdir):" etc/login.defs || die

	# Make user/group names more flexible #3485 / #22920
	epatch "${FILESDIR}"/${PN}-4.0.13-dots-in-usernames.patch
	epatch "${FILESDIR}"/${PN}-4.0.13-long-groupnames.patch

	# Fix compiling with gcc-2.95.x
	epatch "${FILESDIR}"/${PN}-4.0.12-gcc2.patch

	# lock down setuid perms #47208
	epatch "${FILESDIR}"/${PN}-4.0.11.1-perms.patch

	epatch "${FILESDIR}"/${PN}-4.0.15-uclibc-missing-l64a.patch
	epatch "${FILESDIR}"/${PN}-4.0.16-fix-useradd-usergroups.patch #128715
	epatch "${FILESDIR}"/${PN}-4.0.18.2-useradd.patch

	# Needed by the UCLIBC patches
	eautoconf || die

	elibtoolize
	epunt_cxx
}

src_compile() {
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
	fi
	# Output arch-specific cruft
	case $(tc-arch) in
		ppc*)  echo "hvc0" >> "${D}"/etc/securetty
			   echo "hvsi0" >> "${D}"/etc/securetty
			   echo "ttyPSC0" >> "${D}"/etc/securetty;;
		hppa)  echo "ttyB0" >> "${D}"/etc/securetty;;
		arm)   echo "ttyFB0" >> "${D}"/etc/securetty;;
		sh)    echo "ttySC0" >> "${D}"/etc/securetty
			   echo "ttySC1" >> "${D}"/etc/securetty;;
	esac

	# needed for 'adduser -D'
	insinto /etc/default
	insopts -m0600
	doins "${FILESDIR}"/default/useradd

	# move passwd to / to help recover broke systems #64441
	mv "${D}"/usr/bin/passwd "${D}"/bin/
	dosym /bin/passwd /usr/bin/passwd

	cd "${S}"
	insinto /etc
	insopts -m0644
	newins etc/login.defs login.defs

	if use pam ; then
		dopamd "${FILESDIR}/pam.d-include/"{su,passwd,shadow}

		newpamd "${FILESDIR}/login.pamd.2" login

		for x in chage chsh chfn chpasswd newusers \
				 user{add,del,mod} group{add,del,mod} ; do
			newpamd "${FILESDIR}"/pam.d-include/shadow ${x}
		done

		# comment out login.defs options that pam hates
		gawk -f "${FILESDIR}"/login_defs.awk \
			lib/getdef.c etc/login.defs \
			> "${D}"/etc/login.defs

		# remove manpages that pam will install for us
		# and/or don't apply when using pam
		find "${D}"/usr/share/man \
			'(' -name 'limits.5*' -o -name 'suauth.5*' ')' \
			-exec rm {} \;
	fi

	# Remove manpages that are handled by other packages
	find "${D}"/usr/share/man \
		'(' -name id.1 -o -name passwd.5 -o -name getspnam.3 ')' \
		-exec rm {} \;

	cd "${S}"
	dodoc ChangeLog NEWS TODO
	newdoc README README.download
	cd doc
	dodoc HOWTO README* WISHLIST *.txt
}

pkg_preinst() {
	rm -f "${ROOT}"/etc/pam.d/system-auth.new \
		"${ROOT}/etc/login.defs.new"

	use pam && pam_epam_expand "${D}"/etc/pam.d/login
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
}
