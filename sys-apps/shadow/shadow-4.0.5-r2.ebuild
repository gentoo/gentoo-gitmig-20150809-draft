# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/shadow/shadow-4.0.5-r2.ebuild,v 1.10 2005/08/24 00:33:34 vapier Exp $

inherit eutils libtool gnuconfig flag-o-matic

FORCE_SYSTEMAUTH_UPDATE="no"
SELINUX_PATCH="shadow-4.0.4.1-selinux.diff"

DESCRIPTION="Utilities to deal with user accounts"
HOMEPAGE="http://shadow.pld.org.pl/"
SRC_URI="ftp://ftp.pld.org.pl/software/shadow/${P}.tar.bz2"

LICENSE="BSD"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 m68k mips ppc ppc64 s390 sh sparc x86"
IUSE="pam selinux nls skey"

RDEPEND=">=sys-libs/cracklib-2.7-r3
	pam? ( >=sys-libs/pam-0.75-r4 sys-apps/pam-login )
	!pam? ( !sys-apps/pam-login )
	skey? ( app-admin/skey )
	selinux? ( sys-libs/libselinux )"
DEPEND="${RDEPEND}
	>=sys-apps/portage-2.0.51-r2
	nls? ( sys-devel/gettext )"

pkg_preinst() {
	rm -f ${ROOT}/etc/pam.d/system-auth.new
}

src_unpack() {
	unpack ${A}
	cd ${S}

	# uclibc support, corrects NIS usage
	epatch ${FILESDIR}/shadow-4.0.4.1-nonis.patch

	# If su should not simulate a login shell, use '/bin/sh' as shell to enable
	# running of commands as user with /bin/false as shell, closing bug #15015.
	# *** This one could be a security hole; disable for now ***
	#epatch ${FILESDIR}/${P}-nologin-run-sh.patch

	# don't install manpages if USE=-nls
	epatch ${FILESDIR}/shadow-${PV}-nls-manpages.patch

	# tweak the default login.defs
	epatch ${FILESDIR}/shadow-${PV}-login.defs.patch

	# fix small graphical typo in passwd.1 #68150
	epatch ${FILESDIR}/shadow-4.0.4.1-passwd-typo.patch

	# skeychallenge call needs updating #69741
	epatch ${FILESDIR}/shadow-${PV}-skey.patch

	# remove an extra else #69212
	epatch ${FILESDIR}/shadow-${PV}-remove-else.patch

	# restore DISPLAY/XAUTHORITY propogation even with USE=pam
	# so that users have a chance to migrate to new system #69925
	epatch ${FILESDIR}/shadow-${PV}-hack-X-envvars.patch
	[ "${PVR}" != "4.0.5-r2" ] && die "remove the X envvar hack!"

	# Allows shadow configure detect newer systems properly
	gnuconfig_update
	elibtoolize
	epunt_cxx
}

src_compile() {
	append-ldflags -Wl,-z,now
	econf \
		--disable-desrpc \
		--with-libcrypt \
		--with-libcrack \
		--enable-shared=no \
		--enable-static=yes \
		$(use_with pam libpam) \
		$(use_with skey libskey) \
		$(use_with selinux) \
		$(use_enable nls) \
		|| die "bad configure"
	emake || die "compile problem"
}

src_install() {
	make DESTDIR=${D} install || die "install problem"
	dosym useradd /usr/sbin/adduser

	# lock down setuid perms #47208
	fperms go-r /bin/su /usr/bin/ch{fn,sh,age} \
		/usr/bin/{expiry,newgrp,passwd,gpasswd} || die "fperms"

	# Remove libshadow and libmisc; see bug 37725 and the following
	# comment from shadow's README.linux:
	#   Currently, libshadow.a is for internal use only, so if you see
	#   -lshadow in a Makefile of some other package, it is safe to
	#   remove it.
	rm -f ${D}/lib/lib{misc,shadow}.{a,la}

	# Do not install this login, but rather the one from
	# pam-login, as this one have a serious root exploit
	# with pam support enabled.
	use pam && rm ${D}/bin/login

	insinto /etc
	# Using a securetty with devfs device names added
	# (compat names kept for non-devfs compatibility)
	insopts -m0600 ; doins ${FILESDIR}/securetty
	insopts -m0600 ; doins etc/login.access
	insopts -m0644 ; doins etc/limits

	# needed for 'adduser -D'
	insinto /etc/default
	insopts -m0600
	doins ${FILESDIR}/default/useradd

	# move passwd to / to help recover broke systems #64441
	mv ${D}/usr/bin/passwd ${D}/bin/
	dosym /bin/passwd /usr/bin/passwd

	if use pam ; then
		insinto /etc/pam.d ; insopts -m0644
		for x in ${FILESDIR}/pam.d/*; do
			[ -f ${x} ] && doins ${x}
		done
		cd ${FILESDIR}/pam.d
		# Make sure /etc/pam.d/system-auth is the new version ..
		mv ${D}/etc/pam.d/system-auth-1.1 ${D}/etc/pam.d/system-auth
		newins system-auth-1.1 system-auth.new || die
		for x in chage chsh chfn chpasswd newusers \
		         user{add,del,mod} group{add,del,mod} ; do
			newins shadow ${x}
		done

		# remove manpages that pam will install for us
		# and/or don't apply when using pam

		find ${D}/usr/share/man \
			'(' -name 'login.1' -o -name 'suauth.5' ')' \
			-exec rm {} \;
	else
		insinto /etc
		insopts -m0644
		newins etc/login.defs.linux login.defs
	fi

	# Remove manpages that are handled by other packages
	find ${D}/usr/share/man \
		'(' -name id.1 -o -name passwd.5 -o -name getspnam.3 ')' \
		-exec rm {} \;

	cd ${S}/doc
	dodoc INSTALL README WISHLIST
	docinto txt
	dodoc HOWTO LSM README.* *.txt

	# ttyB0 is the PDC software console
	if [ "${ARCH}" = "hppa" ]
	then
		echo "ttyB0" >> ${D}/etc/securetty
	fi
}

pkg_postinst() {
	use pam || return 0;
	local CHECK1="$(md5sum ${ROOT}/etc/pam.d/system-auth | cut -d ' ' -f 1)"
	local CHECK2="$(md5sum ${ROOT}/etc/pam.d/system-auth.new | cut -d ' ' -f 1)"

	if [ "${CHECK1}" != "${CHECK2}" -a "${FORCE_SYSTEMAUTH_UPDATE}" = "yes" ]
	then
		ewarn "Due to a security issue, ${ROOT}etc/pam.d/system-auth "
		ewarn "is being updated automatically. Your old "
		ewarn "system-auth will be backed up as:"
		ewarn
		ewarn "  ${ROOT}etc/pam.d/system-auth.bak"
		echo

		cp -pPR ${ROOT}/etc/pam.d/system-auth \
			${ROOT}/etc/pam.d/system-auth.bak;
		mv -f ${ROOT}/etc/pam.d/system-auth.new \
			${ROOT}/etc/pam.d/system-auth
		rm -f ${ROOT}/etc/pam.d/._cfg????_system-auth
	else
		rm -f ${ROOT}/etc/pam.d/system-auth.new
	fi
}
