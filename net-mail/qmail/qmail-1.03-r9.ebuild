# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/qmail/qmail-1.03-r9.ebuild,v 1.11 2004/01/30 04:19:48 robbat2 Exp $

IUSE="ssl ldap"

S=${WORKDIR}/${P}

DESCRIPTION="A modern replacement for sendmail which uses maildirs"
HOMEPAGE="http://www.qmail.org/
	http://www.jedi.claranet.fr/qmail-tuning.html
	http://iain.cx/unix/qmail/mysql.php
	http://www.nrg4u.com/"
SRC_URI="http://cr.yp.to/software/qmail-1.03.tar.gz
	http://www.qmail.org/big-todo.103.patch
	http://www.qmail.org/big-concurrency.patch
	http://www.ckdhr.com/ckd/qmail-103.patch
	ldap? ( http://www.nrg4u.com/qmail/qmail-ldap-1.03-20020901.patch.gz )"

DEPEND="virtual/glibc
	sys-apps/groff
	>=sys-apps/ucspi-tcp-0.88
	>=net-mail/checkpassword-0.90
	ldap? ( >=net-nds/openldap-2.0.25-r2 )
	ssl? ( >=dev-libs/openssl-0.9.6e )"

RDEPEND="!virtual/mta
	virtual/glibc
	sys-apps/groff
	>=sys-apps/ucspi-tcp-0.88
	>=sys-apps/daemontools-0.76-r1
	>=net-mail/checkpassword-0.90
	>=net-mail/dot-forward-0.71"

PROVIDE="virtual/mta
	 virtual/mda"

SLOT="0"
LICENSE="as-is"
KEYWORDS="-x86 -ppc -sparc "

src_unpack() {

	unpack qmail-1.03.tar.gz

	use ldap && unpack qmail-ldap-1.03-20020901.patch.gz

	cd ${S}

	echo "Applying big-todo patch..."
	patch < ${DISTDIR}/big-todo.103.patch || die "big-todo patch failed"

	echo "Applying Ext2FS/ReiserFS patch..."
	patch < ${FILESDIR}/${PV}-${PR}/qmail-linksync.patch || die "linksync patch failed"

	echo "Applying QMAILQUEUE patch..."
	patch < ${FILESDIR}/${PV}-${PR}/qmail-queue.patch || die "qmail queue patch failed"

	if [ `use ldap` ]; then
		echo "Applying ldap patches..."
		patch -p1 < ${WORKDIR}/qmail-ldap-1.03-20020901.patch || die "ldap patch failed"
		#patch -p1 < ${FILESDIR}/${PV}-${PR}/ldap-config.diff || die "ldap config patch failed"
	else
		echo "Applying dns patch..."
		patch < ${DISTDIR}/qmail-103.patch || die "dns patch failed"

		echo "Applying big-concurrency patch..."
		patch < ${DISTDIR}/big-concurrency.patch || die "big-concurrency patch failed"

		use ssl && patch < ${FILESDIR}/${PV}-${PR}/qmail-1.03-starttls-smtp-auth.patch || die "tls+auth patch failed"
	fi

	if [ `use ssl` ]; then
		echo "gcc ${CFLAGS} -DTLS" > conf-cc
	else
		echo "gcc ${CFLAGS}" > conf-cc
	fi
	echo "gcc" > conf-ld
	echo "500" > conf-spawn

}

src_compile() {

	cd ${S}

	emake it man || die

}



src_install() {

	cd ${S}

	einfo "Setting up directory hierarchy ..."

	diropts -m 755 -o root -g qmail
	dodir /var/qmail

	for i in bin boot control
	do
		dodir /var/qmail/${i}
	done

	dodir /var/qmail/users
	keepdir /var/qmail/users

	diropts -m 755 -o alias -g qmail
	dodir /var/qmail/alias

	einfo "Installing the qmail software ..."

	insopts -o root -g qmail -m 755
	insinto /var/qmail/boot
	doins home home+df proc proc+df binm1 binm1+df binm2 binm2+df binm3 binm3+df

	into /usr
	dodoc FAQ UPGRADE SENDMAIL INSTALL* TEST* REMOVE* PIC* SECURITY
	dodoc SYSDEPS TARGETS THANKS THOUGHTS TODO VERSION

	insopts -o qmailq -g qmail -m 4711
	insinto /var/qmail/bin
	doins qmail-queue qmail-queue

	insopts -o root -g qmail -m 700
	insinto /var/qmail/bin
	doins qmail-lspawn qmail-start qmail-newu qmail-newmrh

	insopts -o root -g qmail -m 711
	insinto /var/qmail/bin
	doins qmail-getpw qmail-local qmail-remote qmail-rspawn \
	qmail-clean qmail-send splogger qmail-pw2u

	insopts -o root -g qmail -m 755
	insinto /var/qmail/bin
	doins qmail-inject predate datemail mailsubj qmail-showctl \
	qmail-qread qmail-qstat qmail-tcpto qmail-tcpok qmail-pop3d \
	qmail-popup qmail-qmqpc qmail-qmqpd qmail-qmtpd qmail-smtpd \
	sendmail tcp-env qreceipt qsmhook qbiff forward preline \
	condredirect bouncesaying except maildirmake maildir2mbox \
	maildirwatch qail elq pinq config-fast

	into /usr
	for i in *.1 *.5 *.8
	do
		doman $i
	done

	einfo "Creating sendmail replacement ..."
	diropts -m 755
	dodir /usr/sbin /usr/lib
	dosym /var/qmail/bin/sendmail /usr/sbin/sendmail
	dosym /var/qmail/bin/sendmail /usr/lib/sendmail

	einfo "Setting up the default aliases ..."
	diropts -m 700 -o alias -g qmail
	if [ ! -d ${ROOT}/var/qmail/alias/.maildir ] ; then
		dodir /var/qmail/alias/.maildir
		for i in cur new tmp
		do
			dodir /var/qmail/alias/.maildir/$i
		done
	fi

	for i in mailer-daemon postmaster root
	do
		touch ${D}/var/qmail/alias/.qmail-${i}
		fowners alias:qmail /var/qmail/alias/.qmail-${i}
	done

	einfo "Setting up maildirs by default in the account skeleton ..."
	diropts -m 755 -o root -g root
	insinto /etc/skel
	${D}/var/qmail/bin/maildirmake ${D}/etc/skel/.maildir
	newins ${FILESDIR}/${PV}-${PR}/dot_qmail .qmail
	fperms 644 /etc/skel/.qmail
	insinto /root
	${D}/var/qmail/bin/maildirmake ${D}/root/.maildir
	newins ${FILESDIR}/${PV}-${PR}/dot_qmail .qmail
	fperms 644 /root/.qmail

	einfo "Setting up daemontools ..."
	insopts -o root -g root -m 755
	diropts -m 755 -o root -g root
	dodir /var/qmail/supervise
	dodir /var/qmail/supervise/qmail-send
	dodir /var/qmail/supervise/qmail-send/log
	dodir /var/qmail/supervise/qmail-smtpd
	dodir /var/qmail/supervise/qmail-smtpd/log
	chmod +t ${D}/var/qmail/supervise/qmail-send
	chmod +t ${D}/var/qmail/supervise/qmail-smtpd
	diropts -m 755 -o qmaill
	dodir /var/log/qmail
	keepdir /var/log/qmail
	dodir /var/log/qmail/qmail-send
	keepdir /var/log/qmail/qmail-send
	dodir /var/log/qmail/qmail-smtpd
	keepdir /var/log/qmail/qmail-smtpd

	insinto /var/qmail/supervise/qmail-send
	newins ${FILESDIR}/${PV}-${PR}/run-qmailsend run
	insinto /var/qmail/supervise/qmail-send/log
	newins ${FILESDIR}/${PV}-${PR}/run-qmailsendlog run
	insinto /var/qmail/supervise/qmail-smtpd
	newins ${FILESDIR}/${PV}-${PR}/run-qmailsmtpd run
	insinto /var/qmail/supervise/qmail-smtpd/log
	newins ${FILESDIR}/${PV}-${PR}/run-qmailsmtpdlog run

	einfo "Installing the qmail control file ..."
	exeinto /var/qmail/bin
	doexe ${FILESDIR}/${PV}-${PR}/qmail-control

	einfo "Installing the qmail startup file ..."
	insinto /var/qmail
	doins ${FILESDIR}/${PV}-${PR}/rc
	insinto /var/qmail/control
	doins ${FILESDIR}/${PV}-${PR}/defaultdelivery

}

pkg_postinst() {

	einfo "Setting up the message queue hierarchy ..."

	install -d -m 750 -o qmailq -g qmail ${ROOT}/var/qmail/queue
	install -d -m 750 -o qmailq -g qmail ${ROOT}/var/qmail/queue/todo
	install -d -m 700 -o qmailq -g qmail ${ROOT}/var/qmail/queue/pid
	install -d -m 700 -o qmails -g qmail ${ROOT}/var/qmail/queue/bounce
	install -d -m 750 -o qmailq -g qmail ${ROOT}/var/qmail/queue/mess

	for i in 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22
	do
		install -d -m 750 -o qmailq -g qmail ${ROOT}/var/qmail/queue/mess/${i}
		install -d -m 750 -o qmailq -g qmail ${ROOT}/var/qmail/queue/todo/${i}
		install -d -m 750 -o qmailq -g qmail ${ROOT}/var/qmail/queue/intd/${i}
	done

	for i in info local remote
	do
		install -d -m 700 -o qmails -g qmail ${ROOT}/var/qmail/queue/${i}
	done

	for i in 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22
	do
		install -d -m 700 -o qmails -g qmail ${ROOT}/var/qmail/queue/info/${i}
		install -d -m 700 -o qmails -g qmail ${ROOT}/var/qmail/queue/local/${i}
		install -d -m 700 -o qmails -g qmail ${ROOT}/var/qmail/queue/remote/${i}
	done

	install -d -m 750 -o qmailq -g qmail ${ROOT}/var/qmail/queue/lock

	dd if=/dev/zero of=${ROOT}/var/qmail/queue/lock/tcpto bs=1024 count=1
	chmod 644 ${ROOT}/var/qmail/queue/lock/tcpto
	chown qmailr:qmail ${ROOT}/var/qmail/queue/lock/tcpto

	touch ${ROOT}/var/qmail/queue/lock/sendmutex
	chmod 600 ${ROOT}/var/qmail/queue/lock/sendmutex
	chown qmails:qmail ${ROOT}/var/qmail/queue/lock/sendmutex

	mkfifo ${ROOT}/var/qmail/queue/lock/trigger
	chmod 622 ${ROOT}/var/qmail/queue/lock/trigger
	chown qmails:qmail ${ROOT}/var/qmail/queue/lock/trigger

	echo -e "\e[32;01m Please do not forget to run, the following syntax :\033[0m"
	echo -e "\e[32;01m ebuild /var/db/pkg/${CATEGORY}/${PN}-${PV}-${PR}/${PN}-${PV}-${PR}.ebuild config \033[0m"
	echo -e "\e[32;01m This will setup qmail to run out-of-the-box on your system. \033[0m"
	echo -e ""
	echo -e "\e[32;01m To start qmail at boot you have to enable the /etc/init.d/svscan rc file \033[0m"
	echo -e "\e[32;01m and create the following links : \033[0m"
	echo -e "\e[32;01m ln -s /var/qmail/supervise/qmail-send /service/qmail-send \033[0m"
	echo -e "\e[32;01m ln -s /var/qmail/supervise/qmail-smtpd /service/qmail-smtpd \033[0m"


	if use ssl; then
		echo "Creating a self-signed ssl-cert:"
		/usr/bin/openssl req -new -x509 -nodes -out /var/qmail/control/servercert.pem -days 366 -keyout /var/qmail/control/servercert.pem
		chmod 640 /var/qmail/control/servercert.pem
		chown qmaild:qmail /var/qmail/control/servercert.pem
		ln -s /var/qmail/control/servercert.pem /var/qmail/control/clientcert.pem

		echo -e "\e[32;01m If You want to have a signed cert, do the following: \033[0m"
		echo -e "\e[32;01m openssl req -new -nodes -out req.pem \ \033[0m"
		echo -e "\e[32;01m -keyout /var/qmail/control/servercert.pem \033[0m"
		echo -e "\e[32;01m chmod 640 /var/qmail/control/servercert.pem \033[0m"
		echo -e "\e[32;01m chown qmaild:qmail /var/qmail/control/servercert.pem \033[0m"
		echo -e "\e[32;01m ln -s /var/qmail/control/servercert.pem /var/qmail/control/clientcert.pem \033[0m"
		echo -e "\e[32;01m Send req.pem to your CA to obtain signed_req.pem, and do: \033[0m"
		echo -e "\e[32;01m cat signed_req.pem >> /var/qmail/control/servercert.pem \033[0m"
	fi

}

pkg_config() {

export qhost=`hostname`
	if [ ${ROOT} = "/" ] ; then
		if [ ! -f ${ROOT}/var/qmail/control/me ] ; then
			${ROOT}/var/qmail/bin/config-fast $qhost
		fi
	fi

	echo "Accepting relaying by default from all ips configured on this machine."
	LOCALIPS=`/sbin/ifconfig  | grep inet | cut -d " " -f 12 -s | cut -b 6-20`
	for ip in $LOCALIPS; do
		echo "$ip:allow,RELAYCLIENT=\"\"" >> /etc/tcp.smtp
	done
	echo ":allow" >> /etc/tcp.smtp

	tcprules /etc/tcp.smtp.cdb /etc/tcp.smtp.tmp < /etc/tcp.smtp

}
