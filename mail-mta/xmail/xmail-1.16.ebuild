# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-mta/xmail/xmail-1.16.ebuild,v 1.5 2004/07/14 16:55:27 agriffis Exp $

inherit eutils

DESCRIPTION="The world's fastest email server"
HOMEPAGE="http://www.xmailserver.org/"
SRC_URI="http://www.xmailserver.org/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~sparc ~ppc"
IUSE=""

DEPEND="virtual/libc"
PROVIDE="virtual/mta"

pkg_setup() {
	enewgroup xmail
	enewuser xmail -1 /bin/false /dev/null xmail
}

src_compile() {
	if use x86 ; then
		emake -f Makefile.lnx || die
	elif use sparc ; then
		emake -f Makefile.slx || die
	fi
	sed -e "s:/var/MailRoot:/etc/xmail:g" sendmail.sh > sendmail.sh.new
}

src_install() {
	einfo "Setting up directory hierarchy"
	diropts -m 700 -o xmail -g xmail
	dodir /etc/xmail
	dodir /chroot/xmail/var/MailRoot/bin
	dodir /etc/xmail/tabindex
	dodir /etc/xmail/dnscache/mx
	dodir /etc/xmail/dnscache/ns
	dodir /etc/xmail/spool/local
	dodir /etc/xmail/spool/temp
	dodir /etc/xmail/logs
	dodir /etc/init.d
	dodir /etc/conf.d

	touch ${D}/chroot/xmail/var/MailRoot/bin/.keep

	for i in cmdaliases custdomains domains filters pop3linklocks\
		pop3links pop3locks userauth
	do
		dodir /etc/xmail/${i}
		touch ${D}/etc/xmail/${i}/.keep
	done

	for i in pop3 smtp
	do
		dodir /etc/xmail/userauth/${i}
		touch ${D}/etc/xmail/userauth/${i}/.keep
	done
	rm -f ${D}/etc/xmail/userauth/.keep

	einfo "Installing the XMail initial configuration"
	insopts -o xmail -g xmail -m 600
	cd ${S}/MailRoot
	insinto /etc/xmail
	doins server.tab ctrl.ipmap.tab dnsroots finger.ipmap.tab\
		message.id pop3.ipmap.tab smtp.ipmap.tab\
		userdef.tab

	umask 077
	for i in mailusers extaliases domains mailusers aliases \
		aliasdomain extaliases pop3links smtpauth smtpextauth \
		smtpfwd smtprelay smtpgw spam-address spammers ctrlaccounts \
		filters.in filters.out
	do
		touch ${D}/etc/xmail/${i}.tab
	done

	einfo "Installing the XMail documentation"
	umask 022
	dodoc ${S}/docs/*
	dodoc ${S}/gpl.txt
	dodoc ${S}/ToDo.txt


	einfo "Installing the XMail software"
	insinto /etc/env.d
	doins ${FILESDIR}/15xmail
	exeinto /etc/init.d
	newexe ${FILESDIR}/xmail.initd xmail
	insinto /etc/conf.d
	newins ${FILESDIR}/xmail.confd xmail
	cd ${S}
	insopts -o xmail -g xmail -m 4700
	newsbin sendmail sendmail.xmail
	insopts -o xmail -g xmail -m 700
	exeinto /chroot/xmail/var/MailRoot/bin
	doexe CtrlClnt XMail XMCrypt MkUsers
	newsbin sendmail.sh.new sendmail
}

pkg_postinst() {
	rm -f /etc/xmail/cmdaliases/.keep
	rm -f /etc/xmail/custdomains/.keep
	rm -f /etc/xmail/domains/.keep
	rm -f /etc/xmail/filters/.keep
	rm -f /etc/xmail/pop3linklocks/.keep
	rm -f /etc/xmail/pop3links/.keep
	rm -f /etc/xmail/pop3locks/.keep
	rm -f /etc/xmail/userauth/pop3/.keep
	rm -f /etc/xmail/userauth/smtp/.keep

	#read -n 1 -p "Do you want to configure XMail now (y/n)? " YESNO
	#echo ""
	#if [ $YESNO == 'Y' -o $YESNO == 'y' ] ; then
	#	sh ${FILESDIR}/xmailwizard
	#else
	#	einfo "You can quickly configure XMail by running ${FILESDIR}/xmailwizard."
	#fi

	einfo "You can quickly configure XMail by running ${FILESDIR}/xmailwizard."

	ewarn ""
	ewarn "Make sure you have iptables enabled in your kernel!"
	ewarn ""
}
