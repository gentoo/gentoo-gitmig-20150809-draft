# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/mailbase/mailbase-0.00-r8.ebuild,v 1.11 2005/04/06 19:01:01 corsair Exp $

DESCRIPTION="MTA layout package"
SRC_URI=""
HOMEPAGE="http://www.gentoo.org/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 ~ppc-macos s390 sparc x86"
IUSE="pam"

DEPEND=""

S=${WORKDIR}

pkg_setup() {
	if use pam;
	then
		local filestoremove=0;
		local lineorig=`head -n 1 ${FILESDIR}/common-pamd`
		local lineold=""

		einfo "Checking for possible file collisions..."

		for i in pop pop3 pop3s pops imap imap4 imap4s imaps;
		do
			if [[ -e ${ROOT}/etc/pam.d/${i} ]]
			then
				lineold="`head -n 1 ${ROOT}/etc/pam.d/${i}`"

				if [[ "${lineorig}" != "${lineold}" ]]
				then
					ewarn "${ROOT}/etc/pam.d/${i} exists and wasn't provided by mailbase"
					(( filestoremove++ ))
				fi
			fi
		done

		if [[ filestoremove -gt 0 ]]
		then
			echo
			einfo "Those files listed above have to be removed in order to"
			einfo " install this version of mailbase."
			echo
			ewarn "If you edited them, remember to backup and when restoring make"
			ewarn " sure the first line in each file is:"
			einfo ${lineorig}
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
		newins ${FILESDIR}/common-pamd pop
		dosym /etc/pam.d/pop /etc/pam.d/pop3
		dosym /etc/pam.d/pop /etc/pam.d/pop3s
		dosym /etc/pam.d/pop /etc/pam.d/pops

		# imap file and its symlinks
		newins ${FILESDIR}/common-pamd imap
		dosym /etc/pam.d/imap /etc/pam.d/imap4
		dosym /etc/pam.d/imap /etc/pam.d/imap4s
		dosym /etc/pam.d/imap /etc/pam.d/imaps
	fi
}

pkg_postinst() {
	if [ ! -d ${ROOT}/var/spool/mail ]
	then
		mkdir -p ${ROOT}/var/spool/mail
	fi

	# Always set these to close bug #8029.
	chown root:mail ${ROOT}/var/spool/mail
	chmod 0775 ${ROOT}/var/spool/mail
}
