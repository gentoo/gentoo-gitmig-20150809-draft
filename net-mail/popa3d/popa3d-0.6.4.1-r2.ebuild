# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/popa3d/popa3d-0.6.4.1-r2.ebuild,v 1.4 2005/08/23 13:37:27 ticho Exp $

inherit eutils

#
# Mailbox format is determined by the 'mbox' and 'maildir'
# system USE flags.
#
# Mailbox path configuration denoted by the system USE
# flags.
#
# USE flag 'maildir' denotes ~/.maildir
# USE flag 'mbox' denotes /var/mail/username
#
# You can overwrite this by setting the POPA3D_HOME_MAILBOX
# environmental variable (see below) before emerge.
#
# Environmental variables.
#
# POPA3D_HOME_MAILBOX
#
# Overwrite the local user mailbox path. For example
# if you want qmail-styled ~/Mailbox you can set it
# to "Mailbox". For the traditional (although not in
# gentoo Maildir) set it to "Maildir".
#
# POPA3D_VIRTUAL_ONLY
#
# Set this field to "YES" if you dont want local users
# to have POP access. Setting this makes the POPA3D_HOME_MAILBOX
# variable effectively useless.
#
# POPA3D_VIRTUAL_HOME_PATH
#
# Set this field to the base virtual home path. For more information
# read the virtual guide here: http://forums.gentoo.org/viewtopic.php?t=82386
#

IUSE="pam mbox maildir"

DESCRIPTION="A security oriented POP3 server."
HOMEPAGE="http://www.openwall.com/popa3d/"

SRC_URI="http://www.openwall.com/popa3d/${P}.tar.gz
	mirror://gentoo/popa3d-0.6.3-vname-2.diff.gz
	maildir? ( mirror://gentoo/popa3d-0.5.9-maildir-2.diff.gz )"

LICENSE="as-is"
SLOT="0"
KEYWORDS="x86 ~ppc ~sparc"

DEPEND=">=sys-apps/sed-4
	pam? ( >=sys-libs/pam-0.72
	       >=net-mail/mailbase-0.00-r8 )"

pkg_setup() {

	if use pam && ! built_with_use net-mail/mailbase pam;
	then
		echo
		eerror
		eerror "${PN} needs net-mail/mailbase to be built with the pam USE flag"
		eerror "activated. Please rebuild net-mail/mailbase with pam"
		eerror
		die "mailbase has to be built with pam flag"
	fi

	if use mbox && use maildir ; then
		echo
		eerror
		eerror "You must choose between mbox or maildir,"
		eerror "both cannot be used together."
		eerror
		die "Both mbox and maildir specified."
	fi

	echo
	ewarn
	ewarn "You can customize this ebuild with environmental variables."
	ewarn "If you don't set any I'll assume sensible defaults."
	ewarn
	ewarn "See inside this ebuild for details."
	ewarn
	echo
	epause 5

	enewgroup popa3d
	enewuser popa3d -1 -1 /nonexistent popa3d
}

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${DISTDIR}/popa3d-0.6.3-vname-2.diff.gz

	use maildir && epatch ${DISTDIR}/popa3d-0.5.9-maildir-2.diff.gz
}

src_compile() {
	cd ${S}

	if use maildir ; then
		einfo "Mailbox format is: MAILDIR."
		if [ "${POPA3D_HOME_MAILBOX}" = "" ] ; then
			POPA3D_HOME_MAILBOX=".maildir"
		fi
	else
		einfo "Mailbox format is: MAILBOX."
	fi

	if [ "${POPA3D_HOME_MAILBOX}" != "" ] ; then
		einfo "Mailbox path: ~/$POPA3D_HOME_MAILBOX"
		epause 2
		sed -i -e "s:^\(#define MAIL_SPOOL_PATH.*\)$://\1:" params.h
		sed -i -e "s:^#define HOME_MAILBOX_NAME.*$:#define HOME_MAILBOX_NAME \"${POPA3D_HOME_MAILBOX}\":" params.h
	else
		einfo "Mailbox path: /var/mail/username"
	fi

	if [ "${POPA3D_VIRTUAL_ONLY}" = "YES" ] ; then
		einfo "Virtual only, no local system users"
		sed -i -e "s:^#define VIRTUAL_ONLY.*$:#define VIRTUAL_ONLY 1:" params.h
	fi

	if [ "${POPA3D_VIRTUAL_HOME_PATH}" != "" ] ; then
		einfo "Virtual home path set to: $POPA3D_VIRTUAL_HOME_PATH"
		sed -i -e "s:^#define VIRTUAL_HOME_PATH.*$:#define VIRTUAL_HOME_PATH \"$POPA3D_VIRTUAL_HOME_PATH\":" params.h
	fi

	if [ "$POPA3D_VIRTUAL_ONLY" = "YES" ] ; then
		einfo "Authentication method: Virtual."
	elif use pam ; then
		einfo "Authentication method: PAM."
		LIBS="${LIBS} -lpam"
		sed -i -e "s:^#define AUTH_SHADOW\t\t\t1$:#define AUTH_SHADOW\t\t\t0:" params.h
		sed -i -e "s:^#define AUTH_PAM\t\t\t0$:#define AUTH_PAM\t\t\t1:" params.h
	else
		einfo "Authentication method: Shadow."
	fi

	sed -i -e "s:^#define POP_STANDALONE.*$:#define POP_STANDALONE 1:" params.h
	sed -i -e "s:^#define POP_VIRTUAL.*$:#define POP_VIRTUAL 1:" params.h
	sed -i -e "s:^#define VIRTUAL_VNAME.*$:#define VIRTUAL_VNAME 1:" params.h

	emake LIBS="${LIBS} -lcrypt" || die "emake failed"
}

src_install() {
	into /usr

	dosbin popa3d
	doman popa3d.8
	dodoc DESIGN INSTALL CHANGES VIRTUAL CONTACT

	diropts -m 755
	dodir /var/empty
	keepdir /var/empty

	exeinto /etc/init.d
	newexe ${FILESDIR}/popa3d-initrc popa3d

	if use pam ; then
		dodir /etc/pam.d/
		dosym /etc/pam.d/pop /etc/pam.d/popa3d
	fi
}
