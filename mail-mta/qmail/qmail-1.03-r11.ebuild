# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-mta/qmail/qmail-1.03-r11.ebuild,v 1.6 2004/10/26 22:23:11 slarti Exp $

inherit toolchain-funcs eutils

IUSE="ssl"
DESCRIPTION="A modern replacement for sendmail which uses maildirs and includes SSL/TLS, AUTH SMTP, and queue optimization"
HOMEPAGE="http://www.qmail.org/
	http://members.elysium.pl/brush/qmail-smtpd-auth/
	http://www.jedi.claranet.fr/qmail-tuning.html"
SRC_URI="mirror://qmail/qmail-1.03.tar.gz
	http://members.elysium.pl/brush/qmail-smtpd-auth/dist/qmail-smtpd-auth-0.31.tar.gz
	mirror://qmail/qmailqueue-patch
	http://qmail.null.dk/big-todo.103.patch
	http://www.jedi.claranet.fr/qmail-link-sync.patch
	mirror://qmail/big-concurrency.patch
	http://www.suspectclass.com/~sgifford/qmail/qmail-0.0.0.0.patch
	http://david.acz.org/software/sendmail-flagf.patch
	mirror://gentoo/qmail-tls.patch.tbz2
	mirror://qmail/qmail-1.03-qmtpc.patch
	http://qmail.goof.com/qmail-smtpd-relay-reject
	mirror://gentoo/qmail-local-tabs.patch"

SLOT="0"
LICENSE="as-is"
KEYWORDS="~x86 ~ppc ~sparc ~alpha"
DEPEND="virtual/libc
	sys-apps/groff
	ssl? ( >=dev-libs/openssl-0.9.6g )"

RDEPEND="!virtual/mta
	virtual/libc
	>=sys-apps/ucspi-tcp-0.88
	>=sys-apps/daemontools-0.76-r1
	>=net-mail/checkpassword-0.90
	>=net-mail/cmd5checkpw-0.22
	>=net-mail/dot-forward-0.71"

PROVIDE="virtual/mta
	 virtual/mda"

src_unpack() {

	# This makes life easy
	EPATCH_OPTS="-d ${S}"

	# unpack the initial stuff
	unpack ${P}.tar.gz qmail-tls.patch.tbz2 qmail-smtpd-auth-0.31.tar.gz

	# SMTP AUTH
	cp ${WORKDIR}/qmail-smtpd-auth-0.31/{README.auth,base64.c,base64.h} ${S}

	EPATCH_SINGLE_MSG="Adding SMTP AUTH support" \
	epatch qmail-smtpd-auth-0.31/auth.patch

	# Fixes a problem when utilizing "morercpthosts"
	epatch ${FILESDIR}/${PV}-${PR}/smtp-auth-close3.patch

	# TLS support and an EHLO patch
	if use ssl
	then
		#bzcat ${WORKDIR}/tls.patch.bz2 | patch -p1 &>/dev/null || die
		ebegin "Adding TLS support"
		bzcat ${WORKDIR}/tls.patch.bz2 | patch -p1 -d ${S} &>/dev/null || die
		eend $?
	fi

	# patch so an alternate queue processor can be used
	# i.e. - qmail-scanner
	EPATCH_SINGLE_MSG="Adding QMAILQUEUE support" \
	epatch ${DISTDIR}/qmailqueue-patch

	# a patch for faster queue processing
	EPATCH_SINGLE_MSG="Patching for large queues" \
	epatch ${DISTDIR}/big-todo.103.patch

	# Support for remote hosts that have QMTP
	EPATCH_SINGLE_MSG="Adding support for remote QMTP hosts" \
	epatch ${DISTDIR}/qmail-1.03-qmtpc.patch

	# Fix for tabs in .qmail bug noted at
	# http://www.ornl.gov/its/archives/mailing-lists/qmail/2000/10/msg00696.html
	# gentoo bug #24293
	epatch ${DISTDIR}/qmail-local-tabs.patch

	# Account for Linux filesystems lack of a synchronus link()
	epatch ${DISTDIR}/qmail-link-sync.patch

	# Increase limits for large mail systems
	epatch ${DISTDIR}/big-concurrency.patch

	# Treat 0.0.0.0 as a local address
	epatch ${DISTDIR}/qmail-0.0.0.0.patch

	# Let the system decide how to define errno
	epatch ${FILESDIR}/${PV}-${PR}/errno.patch

	# make the qmail 'sendmail' binary behave like sendmail's for -f
	epatch ${DISTDIR}/sendmail-flagf.patch

	# Reject some bad relaying attempts
	# gentoo bug #18064
	epatch ${DISTDIR}/qmail-smtpd-relay-reject

	cd ${S}

	if use ssl; then
		echo "$(tc-getCC) ${CFLAGS} -DTLS" > conf-cc
	else
		echo "$(tc-getCC) ${CFLAGS}" > conf-cc
	fi

	echo "$(tc-getCC) ${LDFLAGS}" > conf-ld
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

	keepdir /var/qmail/users

	diropts -m 755 -o alias -g qmail
	dodir /var/qmail/alias

	einfo "Installing the qmail software ..."

	insopts -o root -g qmail -m 755
	insinto /var/qmail/boot
	doins home home+df proc proc+df binm1 binm1+df binm2 binm2+df binm3 binm3+df

	dodoc FAQ UPGRADE SENDMAIL INSTALL* TEST* REMOVE* PIC* SECURITY
	dodoc SYSDEPS TARGETS THANKS THOUGHTS TODO VERSION
	dodoc ${WORKDIR}/tls-patch.txt

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

	einfo "Adding env.d entry for qmail"
	dodir /etc/env.d
	insinto /etc/env.d
	doins ${FILESDIR}/${PV}-${PR}/99qmail

	einfo "Creating sendmail replacement ..."
	diropts -m 755
	dodir /usr/sbin /usr/lib
	dosym /var/qmail/bin/sendmail /usr/sbin/sendmail
	dosym /var/qmail/bin/sendmail /usr/lib/sendmail

	einfo "Setting up the default aliases ..."
	diropts -m 700 -o alias -g qmail
	${D}/var/qmail/bin/maildirmake ${D}/var/qmail/alias/.maildir
	# for good measure
	keepdir /var/qmail/alias/.maildir/{cur,new,tmp}

	for i in mailer-daemon postmaster root
	do
		if [ ! -f ${ROOT}/var/qmail/alias/.qmail-${i} ]; then
			touch ${D}/var/qmail/alias/.qmail-${i}
			fowners alias:qmail /var/qmail/alias/.qmail-${i}
		fi
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
	# for good measure
	keepdir /etc/skel/.maildir/{cur,new,tmp} /root/.maildir/{cur,new,tmp}

	einfo "Setting up all services (send, smtp, qmtp, qmqp, pop3) ..."
	insopts -o root -g root -m 755
	diropts -m 755 -o root -g root
	dodir /var/qmail/supervise

	for i in send smtpd qmtpd qmqpd pop3d; do
		insopts -o root -g root -m 755
		diropts -m 755 -o root -g root
		dodir /var/qmail/supervise/qmail-${i}{,/log}
		diropts -m 755 -o qmaill
		keepdir /var/log/qmail/qmail-${i}
		fperms +t /var/qmail/supervise/qmail-${i}{,/log}
		insinto /var/qmail/supervise/qmail-${i}
		newins ${FILESDIR}/${PV}-${PR}/run-qmail${i} run
		insinto /var/qmail/supervise/qmail-${i}/log
		newins ${FILESDIR}/${PV}-${PR}/run-qmail${i}log run
	done

	einfo "Installing the qmail control file ..."
	exeinto /var/qmail/bin
	doexe ${FILESDIR}/${PV}-${PR}/qmail-control

	einfo "Installing the qmail startup file ..."
	insinto /var/qmail
	doins ${FILESDIR}/${PV}-${PR}/rc

	einfo "Insalling some stock configuration files"
	insinto /var/qmail/control
	doins ${FILESDIR}/${PV}-${PR}/{defaultdelivery,conf-*}
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
		install -d -m 750 -o qmailq -g qmail ${ROOT}/var/qmail/queue/{mess,todo,intd}/${i}
	done

	for i in info local remote
	do
		install -d -m 700 -o qmails -g qmail ${ROOT}/var/qmail/queue/${i}
	done

	for i in 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22
	do
		install -d -m 700 -o qmails -g qmail ${ROOT}/var/qmail/queue/{info,local,remote}/${i}
	done

	install -d -m 750 -o qmailq -g qmail ${ROOT}/var/qmail/queue/lock

	[ -e ${ROOT}/var/qmail/queue/lock/tcpto ] || dd if=/dev/zero of=${ROOT}/var/qmail/queue/lock/tcpto bs=1024 count=1
	chmod 644 ${ROOT}/var/qmail/queue/lock/tcpto
	chown qmailr:qmail ${ROOT}/var/qmail/queue/lock/tcpto


	[ -e ${ROOT}/var/qmail/queue/lock/sendmutex ] || touch ${ROOT}/var/qmail/queue/lock/sendmutex
	chmod 600 ${ROOT}/var/qmail/queue/lock/sendmutex
	chown qmails:qmail ${ROOT}/var/qmail/queue/lock/sendmutex

	[ -e ${ROOT}/var/qmail/queue/lock/trigger ] || mkfifo ${ROOT}/var/qmail/queue/lock/trigger
	chmod 622 ${ROOT}/var/qmail/queue/lock/trigger
	chown qmails:qmail ${ROOT}/var/qmail/queue/lock/trigger

	# for good measure
	env-update

	einfo "Please do not forget to run, the following syntax :"
	einfo "ebuild /var/db/pkg/${CATEGORY}/${PN}-${PV}-${PR}/${PN}-${PV}-${PR}.ebuild config"
	einfo "This will setup qmail to run out-of-the-box on your system."
	echo
	einfo "To start qmail at boot you have to enable the /etc/init.d/svscan rc file"
	einfo "and create the following links :"
	einfo "ln -s /var/qmail/supervise/qmail-send /service/qmail-send"
	einfo "ln -s /var/qmail/supervise/qmail-smtpd /service/qmail-smtpd"
	echo
	einfo "To start the pop3 server as well, create the following link :"
	einfo "ln -s /var/qmail/supervise/qmail-pop3d /service/qmail-pop3d"
	echo
	einfo "Additionally, the QMTP and QMQP protocols are supported, and can be started as:"
	einfo "ln -s /var/qmail/supervise/qmail-qmtpd /service/qmail-qmtpd"
	einfo "ln -s /var/qmail/supervise/qmail-qmqpd /service/qmail-qmqpd"
	echo
	einfo "Additionally, if you wish to run qmail right now, you should run:"
	einfo "source /etc/profile"
}

pkg_config() {

	export qhost=`hostname --fqdn`
	if [ ${ROOT} = "/" ] ; then
		if [ ! -f ${ROOT}/var/qmail/control/me ] ; then
			${ROOT}/var/qmail/bin/config-fast $qhost
		fi
	fi

	einfo "Accepting relaying by default from all ips configured on this machine."
	LOCALIPS=`/sbin/ifconfig  | grep inet | cut -d' ' -f 12 -s | cut -b 6-20`
	for ip in $LOCALIPS; do
		echo "$ip:allow,RELAYCLIENT=\"\",RBLSMTPD=\"\"" >> /etc/tcp.smtp
		echo "$ip:allow,RELAYCLIENT=\"\"" >> /etc/tcp.qmtp
		echo "$ip:allow,RELAYCLIENT=\"\"" >> /etc/tcp.qmqp
	done
	echo ":allow" >> /etc/tcp.smtp
	echo ":allow" >> /etc/tcp.qmtp
	echo ":deny" >> /etc/tcp.qmqp

	for i in smtp qmtp qmqp; do
		tcprules /etc/tcp.${i}.cdb /etc/tcp.${i}.tmp < /etc/tcp.${i}
	done

	if use ssl; then
	if [ ! -f /var/qmail/control/servercert.pem ]; then
		echo "Creating a self-signed ssl-cert:"
		/usr/bin/openssl req -new -x509 -nodes -out /var/qmail/control/servercert.pem -days 366 -keyout /var/qmail/control/servercert.pem
		chmod 640 /var/qmail/control/servercert.pem
		chown qmaild:qmail /var/qmail/control/servercert.pem
		ln -s /var/qmail/control/servercert.pem /var/qmail/control/clientcert.pem

		einfo "If You want to have a signed cert, do the following:"
		einfo "openssl req -new -nodes -out req.pem \\"
		einfo "-keyout /var/qmail/control/servercert.pem"
		einfo "chmod 640 /var/qmail/control/servercert.pem"
		einfo "chown qmaild:qmail /var/qmail/control/servercert.pem"
		einfo "ln -s /var/qmail/control/servercert.pem /var/qmail/control/clientcert.pem"
		einfo "Send req.pem to your CA to obtain signed_req.pem, and do:"
		einfo "cat signed_req.pem >> /var/qmail/control/servercert.pem"
	fi
	fi
}
