# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/pam-login/pam-login-3.17.ebuild,v 1.17 2006/04/21 12:05:12 flameeyes Exp $

inherit gnuconfig eutils pam

# Do we want to backup an old login.defs, and forcefully
# install a new version?
FORCE_LOGIN_DEFS="no"

MY_PN="${PN/pam-/pam_}"
S="${WORKDIR}/${MY_PN}-${PV}"
DESCRIPTION="Based on the sources from util-linux, with added pam and shadow features"
HOMEPAGE="http://www.thkukuk.de/pam/pam_login/"
SRC_URI="ftp://ftp.suse.com/pub/people/kukuk/pam/${MY_PN}/${MY_PN}-${PV}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 m68k mips ppc ppc64 s390 sh sparc x86"
IUSE="livecd nls selinux"

DEPEND="virtual/libc
	sys-libs/pam
	>=sys-apps/shadow-4.0.7-r1
	selinux? ( sys-libs/libselinux )
	!>=sys-apps/shadow-4.0.14-r2"
# We need sys-apps/shadow-4.0.7-r1, as that no longer installs login.pamd

src_unpack() {
	unpack ${A}

	cd ${S}

	# Do not warn on inlining for gcc-3.3, bug #21213
	epatch ${FILESDIR}/${PN}-3.11-gcc33.patch
	epatch ${FILESDIR}/${PN}-3.11-lastlog-fix.patch

	# Make sure NLS is actually disable, fix building on non-GLIBC systems
	# see bug #115953, and Gentoo/Alt technotes.
	epatch "${FILESDIR}/${P}-nonls.patch"

	# Disable query_user_context selinux code (only affects selinux)
	# if on the selinux livecd, since it can cause the login to timeout
	# if the user isnt ready
	use livecd && epatch ${FILESDIR}/${PN}-3.17-query_user_context.patch

	use ppc64 && epatch ${FILESDIR}/${PN/-/_}-Werror-off-ppc64.patch

	# Get rid of -Werror flag
	sed -i -e 's:-Werror::' configure{,.in}

	# Fix configure scripts to recognize linux-mips
	# (imports updated config.sub and config.guess)
	gnuconfig_update
}

src_compile() {
	local myconf=

	use selinux && myconf="${myconf} --enable-selinux"

	econf \
		$(use_enable nls) ${myconf} || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	einstall rootexecbindir=${D}/bin || die

	newpamd ${FILESDIR}/login.pamd login

	insinto /etc
	insopts -m0644
	doins "${FILESDIR}/login.defs"

	# Also install another one that we can use to check if
	# we need to update it if FORCE_LOGIN_DEFS = "yes"
	[ "${FORCE_LOGIN_DEFS}" = "yes" ] \
		&& newins "${FILESDIR}/login.defs" login.defs.new

	dodoc AUTHORS ChangeLog NEWS README THANKS
}

pkg_preinst() {
	rm -f "${ROOT}/etc/login.defs.new"
}

pkg_postinst() {
	[ "${FORCE_LOGIN_DEFS}" != "yes" ] && return 0

	ewarn "Due to a compatibility issue, ${ROOT}etc/login.defs "
	ewarn "is being updated automatically. Your old login.defs"
	ewarn "will be backed up as:  ${ROOT}etc/login.defs.bak"
	echo

	local CHECK1="`md5sum ${ROOT}/etc/login.defs | cut -d ' ' -f 1`"
	local CHECK2="`md5sum ${ROOT}/etc/login.defs.new | cut -d ' ' -f 1`"

	if [ "${CHECK1}" != "${CHECK2}" ]
	then
		cp -a ${ROOT}/etc/login.defs ${ROOT}/etc/login.defs.bak
		mv -f ${ROOT}/etc/login.defs.new ${ROOT}/etc/login.defs
	elif [ ! -f ${ROOT}/etc/login.defs ]
	then
		mv -f ${ROOT}/etc/login.defs.new ${ROOT}/etc/login.defs
	else
		rm -f ${ROOT}/etc/login.defs.new
	fi
}
