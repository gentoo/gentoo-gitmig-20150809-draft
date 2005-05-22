# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/mailbase/mailbase-1.ebuild,v 1.3 2005/05/22 19:32:38 ferdy Exp $

DESCRIPTION="MTA layout package"
SRC_URI=""
HOMEPAGE="http://www.gentoo.org/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~ppc-macos ~s390 ~sparc ~x86"
IUSE="pam"

RDEPEND="pam? ( virtual/pam )"

S=${WORKDIR}

pkg_setup() {
	if use pam ; then
		local filestoremove=0 lineold=""
		local lineorig=$(head -n 1 ${FILESDIR}/common-pamd)

		einfo "Checking for possible file collisions..."

		for i in pop{,3}{,s} imap{,4}{,s} ; do
			if [[ -e ${ROOT}/etc/pam.d/${i} ]] ; then
				lineold=$(head -n 1 ${ROOT}/etc/pam.d/${i})

				if [[ ${lineorig} != ${lineold} ]] ; then
					ewarn "${ROOT}/etc/pam.d/${i} exists and wasn't provided by mailbase"
					(( filestoremove++ ))
				fi
			fi
		done

		if [[ filestoremove -gt 0 ]] ; then
			echo
			einfo "Those files listed above have to be removed in order to"
			einfo " install this version of mailbase."
			echo
			ewarn "If you edited them, remember to backup and when restoring make"
			ewarn " sure the first line in each file is:"
			echo
			echo ${lineorig}
			die "Can't be installed, files will collide"
		else
			einfo "... everything looks ok"
		fi
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
	if [ "$(stat -c%a ${ROOT}/var/spool/mail/)" != "775" ] ; then
		echo
		ewarn
		ewarn "Your ${ROOT}/var/spool/mail/ directory permissions differ from"
		ewarn "  those which mailbase set when you first installed it (0775)."
		ewarn "  If you did not change them on purpose, consider running:"
		ewarn
		echo -e "\tchmod 0775 ${ROOT}/var/spool/mail/"
		echo
	fi
}
