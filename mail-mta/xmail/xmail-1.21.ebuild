# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-mta/xmail/xmail-1.21.ebuild,v 1.5 2005/08/23 13:21:44 ticho Exp $

inherit eutils linux-info

DESCRIPTION="The world's fastest email server"
HOMEPAGE="http://www.xmailserver.org/"
SRC_URI="http://www.xmailserver.org/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc ~sparc"
IUSE=""

DEPEND="virtual/libc
	>=sys-apps/sed-4"
RDEPEND="net-firewall/iptables"
PROVIDE="virtual/mta"

pkg_setup() {

	linux-info_pkg_setup

	if ! (linux_chkconfig_present NETFILTER); then
		eerror "${P} requires netfilter/iptables support enabled in kernel!"
		eerror
		eerror "Recompile your kernel with CONFIG_NETFILTER and CONFIG_IP_NF_TARGET_REDIRECT"
		eerror "support enabled and reboot. Then try to emerge ${P} again."
		die "Kernel without CONFIG_NETFILTER detected!"
	fi

	if ! (linux_chkconfig_present IP_NF_TARGET_REDIRECT); then
		eerror "${P} requires CONFIG_IP_NF_TARGET_REDIRECT support to be enabled in kernel!"
		eerror "Recompile your kernel with netfilter REDIRECT target support enabled."
		eerror
		eerror "Reboot will be required if compiled directly into kernel."
		eerror "If reboot is not desired you should choose a module instead and run"
		eerror "make modules && make modules_install"
		die "Kernel without CONFIG_IP_NF_TARGET_REDIRECT detected!"
	fi

	enewgroup xmail
	enewuser xmail -1 -1 /dev/null xmail
}

src_compile() {
	sed -i -e "s:^CFLAGS = -O2:CFLAGS=$CFLAGS:g" Makefile.lnx

	# Makefile does not setup dependencies properly to handle parallel build
	emake -j1 -f Makefile.lnx || die

	sed -e "s:/var/MailRoot:/chroot/xmail/var/MailRoot:g" sendmail.sh > sendmail.sh.new
}

src_install() {
	# create some image directories with default diropts
	dodir /etc/conf.d
	dodir /etc/init.d
	dodir /etc/env.d

	einfo "Setting up directory hierarchy"
	diropts -m 700 -o xmail -g xmail
	dodir /etc/xmail
	keepdir /chroot/xmail/var/MailRoot/bin
	dodir /etc/xmail/tabindex
	dodir /etc/xmail/dnscache/mx
	dodir /etc/xmail/dnscache/ns
	dodir /etc/xmail/spool/local
	dodir /etc/xmail/spool/temp
	dodir /etc/xmail/logs
	dodir /etc/init.d
	dodir /etc/conf.d

	for i in cmdaliases custdomains domains filters pop3linklocks\
		pop3links pop3locks userauth
	do
		keepdir /etc/xmail/${i}
	done

	for i in pop3 smtp
	do
		keepdir /etc/xmail/userauth/${i}
	done
	rm -f ${D}/etc/xmail/userauth/.keep

	einfo "Installing the XMail initial configuration"
	insopts -o xmail -g xmail -m 600
	cd ${S}/MailRoot
	insinto /etc/xmail
	doins server.tab ctrl.ipmap.tab dnsroots finger.ipmap.tab\
		message.id pop3.ipmap.tab smtp.ipmap.tab\
		userdef.tab

	for i in mailusers extaliases domains mailusers aliases \
		aliasdomain extaliases pop3links smtpauth smtpextauth \
		smtpfwd smtprelay smtpgw spam-address spammers ctrlaccounts \
		filters.in filters.out
	do
		touch ${D}/etc/xmail/${i}.tab
		fowners xmail:xmail /etc/xmail/${i}.tab
		fperms 600 /etc/xmail/${i}.tab
	done

	einfo "Installing the XMail documentation"
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
	cd ${S}/bin
	exeopts -o xmail -g xmail -m 4700
	exeinto /usr/sbin
	newexe sendmail sendmail.xmail
	exeopts -o root -g root -m 755
	newexe ../sendmail.sh.new sendmail
	exeopts -o xmail -g xmail -m 700
	exeinto /chroot/xmail/var/MailRoot/bin
	doexe CtrlClnt XMail XMCrypt MkUsers
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

	ewarn
	ewarn "Make sure you have iptables/netfilter with connection tracking"
	ewarn "and the REDIRECT target enabled in your kernel!"
	ewarn
}
