# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/pam-login/pam-login-3.14.ebuild,v 1.19 2004/11/12 21:00:10 vapier Exp $

inherit gnuconfig eutils

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
KEYWORDS="alpha amd64 arm hppa ia64 mips ppc ppc64 s390 sh sparc x86"
IUSE="livecd nls selinux"

DEPEND="virtual/libc
	sys-libs/pam
	>=sys-apps/shadow-4.0.2-r5
	selinux? ( sys-libs/libselinux )"

src_unpack() {
	unpack ${A}

	cd ${S}

	# Do not warn on inlining for gcc-3.3, bug #21213
	epatch ${FILESDIR}/${PN}-3.11-gcc33.patch
	epatch ${FILESDIR}/pam-login-3.11-lastlog-fix.patch

	# enable query_user_context selinux code (only affects selinux)
	# but we dont want it on the selinux livecd, since it can
	# cause the login to timeout if the user isnt ready
	use livecd || epatch ${FILESDIR}/pam-login-3.14-query_user_context.diff

	use ppc64 && epatch ${FILESDIR}/pam_login-Werror-off-ppc64.patch
	# Fix configure scripts to recognize linux-mips
	# (imports updated config.sub and config.guess)
	gnuconfig_update
}

src_compile() {
	local myconf=

	use nls || myconf="${myconf} --disable-nls"
	use selinux && myconf="${myconf} --enable-selinux"

	econf ${myconf} || die
	emake || die "emake failed"
}

src_install() {
	einstall rootexecbindir=${D}/bin || die

	# We use the one from shadow
	rm -rf ${D}/etc/pam.d

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
