# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/shadow/shadow-4.0.4.1-r4.ebuild,v 1.11 2004/10/29 02:59:31 vapier Exp $

inherit eutils libtool gnuconfig flag-o-matic

FORCE_SYSTEMAUTH_UPDATE="no"
SELINUX_PATCH="shadow-4.0.4.1-selinux.diff"

DESCRIPTION="Utilities to deal with user accounts"
HOMEPAGE="http://shadow.pld.org.pl/"
SRC_URI="ftp://ftp.pld.org.pl/software/shadow/${P}.tar.bz2"

LICENSE="BSD"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 mips ppc ppc64 s390 sparc x86"
IUSE="pam selinux nls uclibc"

DEPEND=">=sys-libs/cracklib-2.7-r3
	pam? ( >=sys-libs/pam-0.75-r4 )
	nls? ( sys-devel/gettext )
	selinux? ( sys-libs/libselinux )"
RDEPEND=">=sys-libs/cracklib-2.7-r3
	pam? ( >=sys-libs/pam-0.75-r4 )
	selinux? ( sys-libs/libselinux )"

pkg_preinst() {
	rm -f ${ROOT}/etc/pam.d/system-auth.new
}

src_unpack() {
	unpack ${A}
	cd ${S}

	# selinux loving
	use selinux && epatch ${FILESDIR}/${SELINUX_PATCH}

	# uclibc support, corrects NIS usage
	use uclibc && epatch ${FILESDIR}/shadow-4.0.4.1-nonis.patch

	# Get su to call pam_open_session(), and also set DISPLAY and XAUTHORITY,
	# else the session entries in /etc/pam.d/su never get executed, and
	# pam_xauth for one, is then never used.  This should close bug #8831.
	#
	# <azarah@gentoo.org> (19 Oct 2002)
	use pam && epatch ${FILESDIR}/${P}-su-pam_open_session.patch

	# If su should not simulate a login shell, use '/bin/sh' as shell to enable
	# running of commands as user with /bin/false as shell, closing bug #15015.
	#
	# <azarah@gentoo.org> (23 Feb 2003)
# This one could be a security hole ...
#	cd ${S}; epatch ${FILESDIR}/${P}-nologin-run-sh.patch

	# Patch the useradd manpage to be a bit more clear, closing bug #13203.
	# Thanks to Guy <guycad@mindspring.com>.
	epatch ${FILESDIR}/${P}-useradd-manpage-update.patch

	# Patch to correct the definition if malloc, so that shadow can compile
	# using gcc 3.4. see bug #47455 for more information
	epatch ${FILESDIR}/${P}-gcc34-xmalloc.patch

	# userdel has a bug when PAM is enabled that causes it to always exit 
	# with an exit status of 1 #66687
	epatch ${FILESDIR}/${P}-userdel-missing-brackets.patch

	# don't install manpages if USE=-nls
	epatch ${FILESDIR}/${P}-nls-manpages.patch

	# fix small graphical typo in passwd.1 #68150
	epatch ${FILESDIR}/${P}-passwd-typo.patch

	# Allows shadow configure detect newer systems properly
	gnuconfig_update
	elibtoolize
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
		$(use_enable nls) \
		|| die "bad configure"

	# Parallel make fails sometimes
	emake -j1 || die "compile problem"
}

src_install() {
	make DESTDIR=${D} install || die "install problem"

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
	# with pam_limits in use.
	use pam && rm ${D}/bin/login

	dosym newgrp /usr/bin/sg
	dosym useradd /usr/sbin/adduser
	dosym vipw /usr/sbin/vigr
	# Remove dead links
	rm -f ${D}/bin/{sg,vipw,vigr}

	insinto /etc
	# Using a securetty with devfs device names added
	# (compat names kept for non-devfs compatibility)
	insopts -m0600 ; doins ${FILESDIR}/securetty
	insopts -m0600 ; doins ${S}/etc/login.access
	insopts -m0644 ; doins ${S}/etc/limits

	# needed for 'adduser -D'
	insinto /etc/default
	insopts -m0600
	doins ${FILESDIR}/default/useradd
	# From sys-apps/pam-login now
	#insopts -m0644 ; doins ${FILESDIR}/login.defs

	# move passwd to / to help recover broke systems #64441
	mv ${D}/usr/bin/passwd ${D}/bin/
	dosym ../../bin/passwd /usr/bin/passwd

	if use pam; then
		insinto /etc/pam.d ; insopts -m0644
		for x in ${FILESDIR}/pam.d/*; do
			[ -f ${x} ] && doins ${x}
		done
		cd ${FILESDIR}/pam.d
		# Make sure /etc/pam.d/system-auth is the new version ..
		mv ${D}/etc/pam.d/system-auth-1.1 ${D}/etc/pam.d/system-auth
		newins system-auth-1.1 system-auth.new || die
		newins shadow chage
		newins shadow chsh
		newins shadow chfn
		newins shadow useradd
		newins shadow groupadd
	fi

	# Remove manpages that are handled by other packages
	cd ${D}/usr/share/man
	find \
		-name 'id.1' \
		-o -name 'passwd.5' \
		-exec rm {} \;
	cd ${S}

	if ! use pam; then
		# Dont install the manpage, since we dont use
		# login with shadow
		rm -f ${D}/usr/share/man/man1/login.*
		# We use pam, so this is not applicable.
		rm -f ${D}/usr/share/man/man5/suauth.*
	fi

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

		cp -a ${ROOT}/etc/pam.d/system-auth \
			${ROOT}/etc/pam.d/system-auth.bak;
		mv -f ${ROOT}/etc/pam.d/system-auth.new \
			${ROOT}/etc/pam.d/system-auth
		rm -f ${ROOT}/etc/pam.d/._cfg????_system-auth
	else
		rm -f ${ROOT}/etc/pam.d/system-auth.new
	fi
}
