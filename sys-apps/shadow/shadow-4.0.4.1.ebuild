# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/shadow/shadow-4.0.4.1.ebuild,v 1.4 2004/02/08 20:36:48 vapier Exp $

inherit eutils libtool gnuconfig

FORCE_SYSTEMAUTH_UPDATE="no"

SELINUX_PATCH="shadow-4.0.4.1-selinux.diff"

HOMEPAGE="http://shadow.pld.org.pl/"
DESCRIPTION="Utilities to deal with user accounts"
SRC_URI="ftp://ftp.pld.org.pl/software/shadow/${P}.tar.bz2"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86 ~amd64 ~ppc ~sparc ~alpha ~mips ~hppa ~arm ~ia64 ~ppc64"
IUSE="pam selinux"

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

	use selinux && epatch ${FILESDIR}/${SELINUX_PATCH}

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
}

src_compile() {
	# Allows shadow configure detect mips systems properly
	gnuconfig_update

	elibtoolize

	local myconf=
	use pam \
		&& myconf="${myconf} --with-libpam --with-libcrack" \
		|| myconf="${myconf} --without-libpam"

	./configure --disable-desrpc \
		--with-libcrypt \
		--with-libcrack \
		--enable-shared=no \
		--enable-static=yes \
		--host=${CHOST} \
		`use_enable nls` \
		${myconf} || die "bad configure"

	# Parallel make fails sometimes
	make || die "compile problem"
}

src_install() {
	dodir /etc/default /etc/skel

	make prefix=${D}/usr \
		exec_prefix=${D} \
		mandir=${D}/usr/share/man \
		install || die "install problem"

	# Do not install this login, but rather the one from
	# pam-login, as this one have a serious root exploit
	# with pam_limits in use.
	use pam && rm ${D}/bin/login

	mv ${D}/lib ${D}/usr
	dosed "s:/lib':/usr/lib':g" /usr/lib/libshadow.la
	dosed "s:/lib/:/usr/lib/:g" /usr/lib/libshadow.la
	dosed "s:/lib':/usr/lib':g" /usr/lib/libmisc.la
	dosed "s:/lib/:/usr/lib/:g" /usr/lib/libmisc.la
	dosym /usr/bin/newgrp /usr/bin/sg
	dosym /usr/sbin/useradd /usr/sbin/adduser
	dosym /usr/sbin/vipw /usr/sbin/vigr
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
#	insopts -m0644 ; doins ${FILESDIR}/login.defs

	if [ `use pam` ] ; then
		insinto /etc/pam.d ; insopts -m0644
		for x in ${FILESDIR}/pam.d/*
		do
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

	cd ${S}
	# The manpage install is beyond my comprehension, and
	# also broken. Just do it over.
	rm -rf ${D}/usr/share/man/*

	rm -f man/id.1 man/getspnam.3 man/passwd.5
	for x in man/*.[0-9]
	do
		[ -f ${x} ] && doman ${x}
	done

	if [ ! `use pam` ] ; then
		# Dont install the manpage, since we dont use
		# login with shadow
		rm -f ${D}/usr/share/man/man1/login.*
		# We use pam, so this is not applicable.
		rm -f ${D}/usr/share/man/man5/suauth.*
	fi

	cd ${S}/doc
	dodoc ANNOUNCE INSTALL LICENSE README WISHLIST
	docinto txt
	dodoc HOWTO LSM README.* *.txt

	# Fix sparc serial console
	if [ "${ARCH}" = "sparc" -o "${ARCH}" = "" ]
	then
		# ttyS0 and its devfsd counterpart (Sparc serial port "A")
		dosed 's:\(vc/1\)$:tts/0\n\1:' /etc/securetty
		dosed 's:\(tty1\)$:ttyS0\n\1:' /etc/securetty
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
