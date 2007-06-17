# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/mailbase/mailbase-1.ebuild,v 1.18 2007/06/17 19:41:28 ferdy Exp $

DESCRIPTION="MTA layout package"
SRC_URI=""
HOMEPAGE="http://www.gentoo.org/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 m68k mips ppc ppc64 s390 sh sparc ~sparc-fbsd x86 ~x86-fbsd"
IUSE="pam"

RDEPEND="pam? ( virtual/pam )"

S=${WORKDIR}

get_permissions_oct() {
	if [[ ${USERLAND} = GNU ]] ; then
		stat -c%a "${ROOT}$1"
	elif [[ ${USERLAND} = BSD ]] ; then
		stat -f%p "${ROOT}$1" | cut -c 3-
	fi
}

src_install() {
	dodir /etc/mail
	insinto /etc/mail
	doins ${FILESDIR}/aliases
	insinto /etc/
	doins ${FILESDIR}/mailcap

	keepdir /var/spool/mail
	fowners root:mail /var/spool/mail
	fperms 0775 /var/spool/mail
	dosym /var/spool/mail /var/mail

	if use pam;
	then
		insinto /etc/pam.d/

		# pop file and its symlinks
		newins ${FILESDIR}/common-pamd-include pop
		dosym /etc/pam.d/pop /etc/pam.d/pop3
		dosym /etc/pam.d/pop /etc/pam.d/pop3s
		dosym /etc/pam.d/pop /etc/pam.d/pops

		# imap file and its symlinks
		newins ${FILESDIR}/common-pamd-include imap
		dosym /etc/pam.d/imap /etc/pam.d/imap4
		dosym /etc/pam.d/imap /etc/pam.d/imap4s
		dosym /etc/pam.d/imap /etc/pam.d/imaps
	fi
}

pkg_postinst() {
	if [[ "$(get_permissions_oct /var/spool/mail)" != "775" ]] ; then
		echo
		ewarn "Your ${ROOT}/var/spool/mail/ directory permissions differ from"
		ewarn "  those which mailbase set when you first installed it (0775)."
		ewarn "  If you did not change them on purpose, consider running:"
		ewarn
		ewarn "    chmod 0775 ${ROOT}/var/spool/mail/"
		echo
	fi
}
