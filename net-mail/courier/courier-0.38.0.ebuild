# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author: Daniel Robbins <drobbins@gentoo.org>
# Adapted for courier MTA by Andreas Erhart <andi@as-computer.de> and
# Alex Hartmann <alex@as-computer.de>
# $Header: /var/cvsroot/gentoo-x86/net-mail/courier/courier-0.38.0.ebuild,v 1.1 2002/05/14 20:15:09 g2boojum Exp $

S=${WORKDIR}/${P}
DESCRIPTION="An MTA designed specifically for maildirs"
SRC_URI="http://ftp1.sourceforge.net/courier/${P}.tar.gz"
HOMEPAGE="http://www.courier-mta.org/"

PROVIDE="virtual/mta
	 virtual/imapd"
RDEPEND="virtual/glibc
	>=dev-libs/openssl-0.9.6
	>=dev-tcltk/expect-5.33.0
	pam? ( >=sys-libs/pam-0.75 )
	berkdb? ( >=sys-libs/db-3.2 )
	gdbm? ( >=sys-libs/gdbm-1.8.0 )
	mysql? ( >=dev-db/mysql-3.23.36 )
	ldap? ( >=net-nds/openldap-1.2.11 )
	postgres? ( >=dev-db/postgresql-7.1.3 )
	tcltk? ( >=dev-tcltk/expect-5.33.0 )"
DEPEND="${RDEPEND} sys-devel/perl sys-apps/procps"

# I'm not sure about .maildir and Maildir issue. This package will probably work just
# with Maildir. Is there a standard ? What's the best way to do it ?

src_compile() {
	local myconf
	use pam || myconf="${myconf} --without-authpam"
	use ldap || myconf="${myconf} --without-authldap"
	use mysql || myconf="${myconf} --without-authmysql"
	use postgres || myconf="${myconf} --without-authpostgresql"
	use berkdb && myconf="${myconf} --with-db=db"
	use berkdb || myconf="${myconf} --with-db=gdbm"

	./configure \
		--prefix=/usr \
		--disable-root-check \
		--mandir=/usr/share/man \
		--sysconfdir=/etc/courier \
		--libexecdir=/usr/lib/courier \
		--datadir=/usr/share/courier \
		--sharedstatedir=/var/lib/courier/com \
		--localstatedir=/var/lib/courier \
		--with-piddir=/var/run/courier \
		--with-mailuser=mail \
		--with-mailgroup=mail \
		--with-paranoid-smtpext \
		--enable-mimetypes=/etc/apache/conf/mime.types \
		--enable-workarounds-for-imap-client-bugs \
		--with-authdaemonvar=/var/lib/courier/authdaemon \
		--host=${CHOST} ${myconf} || die "bad ./configure"

	emake || die "compile problem"
}

src_install () {
	dodir /var/lib/courier
	mkdir -p ${D}/etc/pam.d
	mkdir -p ${D}/var/run/courier
	make install DESTDIR=${D}

	cd ${D}/etc/courier
	local x
	for x in courierd pop3d pop3d-ssl imapd imapd-ssl authdaemonrc
	do
		mv ${x}.dist ${x}
	done

	if [ -d ${D}/etc/pam.d ]
	then
		[ -f esmtp.authpam ] && mv esmtp.authpam ${D}/etc/pam.d/esmtp
		[ -f pop3d.authpam ] && mv pop3d.authpam ${D}/etc/pam.d/pop3
		[ -f imapd.authpam ] && mv imapd.authpam ${D}/etc/pam.d/imap
		[ -f webmail.authpam ] && mv webmail.authpam ${D}/etc/pam.d/webmail
	fi

exeinto /etc/init.d
	newexe ${FILESDIR}/courier courier
	newexe ${FILESDIR}/courier-authdaemond courier-authdaemond
	newexe ${FILESDIR}/courier-mta courier-mta
	newexe ${FILESDIR}/courier-esmtpd courier-esmtpd
	newexe ${FILESDIR}/courier-esmtpd-ssl courier-esmtpd-ssl
	newexe ${FILESDIR}/courier-esmtpd-msa courier-esmtpd-msa
	newexe ${FILESDIR}/courier-imapd courier-imapd
	newexe ${FILESDIR}/courier-imapd-ssl courier-imapd-ssl
	newexe ${FILESDIR}/courier-pop3d-ssl courier-pop3d-ssl
	newexe ${FILESDIR}/courier-pop3d courier-pop3d
exeinto /etc/courier
	newexe ${FILESDIR}/set-mime set-mime
}
pkg_postinst() {
	echo -e "\e[32;01m If you need imap-ssl you should edit /etc/courier/imapd.cnf \033[0m"
	echo -e "\e[32;01m and then create a certificate with the command mkimapdcert. \033[0m"
	echo -e "\e[32;01m You'll find a set-mime script in /etc/courier which you can use to \033[0m"
	echo -e "\e[32;01m set the desired MIME headers behaviour. Have a look at comments for syntax. \033[0m"
}
