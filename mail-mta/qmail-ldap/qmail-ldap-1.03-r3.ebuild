# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-mta/qmail-ldap/qmail-ldap-1.03-r3.ebuild,v 1.6 2005/08/08 20:20:11 robbat2 Exp $

IUSE="ssl"

inherit eutils toolchain-funcs

S=${WORKDIR}/qmail-${PV}

DESCRIPTION="A modern replacement for sendmail which uses maildirs"
HOMEPAGE="http://www.qmail.org/
	http://www.jedi.claranet.fr/qmail-tuning.html
	http://iain.cx/unix/qmail/mysql.php
	http://www.nrg4u.com/"
SRC_URI="mirror://qmail/qmail-${PV}.tar.gz
	http://www.suspectclass.com/~sgifford/qmail/qmail-0.0.0.0.patch
	http://david.acz.org/software/sendmail-flagf.patch
	http://www.nrg4u.com/qmail/qmail-ldap-1.03-20040101.patch.gz"

DEPEND="virtual/libc
	sys-apps/groff
	>=net-nds/openldap-2.0.25-r2
	>=sys-apps/ucspi-tcp-0.88
	>=net-mail/checkpassword-0.90
	ssl? ( >=dev-libs/openssl-0.9.6e )"

RDEPEND="!virtual/mta
	${DEPEND}
	>=sys-process/daemontools-0.76-r1
	>=net-mail/dot-forward-0.71"

PROVIDE="virtual/mta
	 virtual/mda"

SLOT="0"
LICENSE="as-is"
KEYWORDS="~x86 ~ppc ~sparc"

src_unpack() {
	unpack qmail-1.03.tar.gz
	unpack qmail-ldap-1.03-20040101.patch.gz

	cd ${S}

	#main ldap patch
	#includes : qmail-queue patch | big todo | errno
	#qmail-103.patch | qmail-local-tabs.patch | big-concurrency.patch
	epatch ${WORKDIR}/qmail-ldap-1.03-20040101.patch || die "ldap patch failed"

	#define 0.0.0.0 as local system/network
	epatch ${DISTDIR}/qmail-0.0.0.0.patch || die "0.0.0.0 patch did not apply"

	#FIXNE
	# AUTOHOME DIR MAKE AND FEATURES PATCH
	epatch ${FILESDIR}/gentoo.patch || die "Homedir patch did not apply"

	# Account for Linux filesystems lack of a synchronus link()
	epatch ${FILESDIR}/qmail-link-sync-gentoo.patch

	# make the qmail 'sendmail' binary behave like sendmail's for -f
	epatch ${DISTDIR}/sendmail-flagf.patch

	# This will make the emails headers be written in localtime rather than GMT
	# If you really want, uncomment it yourself, as mail really should be in GMT
	#epatch ${DISTDIR}/qmail-date-localtime.patch.txt

	if use ssl; then
		epatch ${DISTDIR}/${P}-r2-tls.patch.bz2 || die "tls+auth patch failed";
	fi

	echo -n "$(tc-getCC) ${CFLAGS}" >${S}/conf-cc
	echo -n "$(tc-getCC) ${LDFLAGS}" > ${S}/conf-ld
	echo "500" > conf-spawn

}

src_compile() {
	cd ${S}
	emake it man ldap|| die
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

	into /usr
	dodoc ${FILESDIR}/1.03-r2/samples.ldif
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
	maildirwatch qail elq pinq config-fast auth_imap auth_pop \
	auth_smtp dirmaker qmail-ldaplookup qmail-todo

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
	${MAILDIRMAKE} ${D}/var/qmail/alias/.maildir
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
	newins ${FILESDIR}/${PV}-${PR}/dot_qmail .qmail.sample
	fperms 644 /etc/skel/.qmail.sample
	${MAILDIRMAKE} ${D}/etc/skel/.maildir
	# for good measure
	keepdir /etc/skel/.maildir/{cur,new,tmp}

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
		insinto /etc
	done

	for i in smtp qmtp qmqp pop3; do
		if [ -f ${FILESDIR}/tcp.${i}.sample ]; then
			newins ${FILESDIR}/tcp.${i}.sample /etc/tcp.${i}
		fi
		if [ -f ${D}/etc/tcp.${i} ]; then
			tcprules ${D}/etc/tcp.${i}.cdb ${D}/etc/.tcp.${i}.tmp \
			< ${D}/etc/tcp.${i}
		fi
	done

	einfo "Installing the qmail control file ..."
	exeinto /var/qmail/bin
	doexe ${FILESDIR}/qmail-control

	einfo "Installing the qmail startup file ..."
	insinto /var/qmail
	doins ${FILESDIR}/rc \

	einfo "Installing the qmail configuration file ..."
	insinto /var/qmail/control
	insopts -o root -g root -m 644
	doins ${FILESDIR}/control/defaultdomain \
	${FILESDIR}/control/defaulthost \
	${FILESDIR}/control/dirmaker \
	${FILESDIR}/control/ldapbasedn \
	${FILESDIR}/control/ldapgid \
	${FILESDIR}/control/ldaplocaldelivery \
	${FILESDIR}/control/ldaplogin \
	${FILESDIR}/control/ldapmessagestore \
	${FILESDIR}/control/ldapserver \
	${FILESDIR}/control/ldapuid \
	${FILESDIR}/control/qmail-pop3d-loglevel \
	${FILESDIR}/control/qmail-pop3d-softlimit \
	${FILESDIR}/control/qmail-smtpd-softlimit \
	${FILESDIR}/control/qmail-start-loglevel

	insopts -o qmaild -g root -m 600
	insinto /var/qmail/control
	doins ${FILESDIR}/control/ldappassword

	einfo "Installing the qmail.schema ..."
	insinto /etc/openldap/schema
	doins qmail.schema

	einfo "Insalling some stock configuration files"
	insinto /var/qmail/control
	insopts -o root -g root -m 644
	doins ${FILESDIR}/${PV}-${PR}/conf-*
	newins ${FILESDIR}/${PV}-${PR}/dot_qmail defaultdelivery
	use ssl && doins ${FILESDIR}/${PV}-${PR}/servercert.cnf

	einfo "Configuration sanity checker"
	into /var/qmail
	insopts -o root -g root -m 644
	dobin ${FILESDIR}/${PV}-${PR}/config-sanity-check

	if use ssl; then
		einfo "SSL Certificate creation script"
		dobin ${FILESDIR}/${PV}-${PR}/mkservercert
		einfo "RSA key generation cronjob"
		insinto /etc/cron.daily
		doins ${FILESDIR}/${PV}-${PR}/qmail-genrsacert.sh
		chmod +x ${D}/etc/cron.daily/qmail-genrsacert.sh
	fi
}

rootmailfixup() {
	# so you can check mail as root easily
	local TMPCMD="ln -sf /var/qmail/alias/.maildir/ ${ROOT}/root/.maildir"
	if [ -d "${ROOT}/root/.maildir" ] && [ ! -L "${ROOT}/root/.maildir" ] ; then
		einfo "Previously the qmail ebuilds created /root/.maildir/ but not"
		einfo "mail was every delivered there. If the directory does not"
		einfo "contain any mail, please delete it and run:"
		einfo "${TMPCMD}"
	else
		${TMPCMD}
	fi
	chown -R alias:qmail ${ROOT}/var/qmail/alias/.maildir 2>/dev/null
}

buildtcprules() {
	for i in smtp qmtp qmqp pop3; do
		# please note that we don't check if it exists
		# as we want it to make the cdb files anyway!
		cat ${ROOT}etc/tcp.${i} 2>/dev/null | tcprules ${ROOT}etc/tcp.${i}.cdb ${ROOT}etc/.tcp.${i}.tmp
	done
}


pkg_postinst() {
	einfo "Setting up the message queue hierarchy ..."
	# queue-fix makes life easy!
	/var/qmail/bin/queue-fix ${ROOT}/var/qmail/queue >/dev/null

	rootmailfixup
	buildtcprules

	# for good measure
	env-update

	if [ `getent passwd ldapauth | cut -d: -f1` != ldapauth ]; then
	useradd -g ldapauth -d /var/qmail/maildirs -s /bin/true -u 11184 ldapauth
	fi

	if [ `getent group ldapauth | cut -d: -f1` != ldapauth ]; then
		groupadd ldapauth &>/dev/null
	fi

	einfo "Please do not forget to run, the following syntax :"
	einfo "ebuild /var/db/pkg/${CATEGORY}/${PF}/${PF}.ebuild config "
	einfo "This will setup qmail to run out-of-the-box on your system including SSL. "
	echo
	einfo "To start qmail at boot you have to enable the /etc/init.d/svscan rc file "
	einfo "and create the following links : "
	einfo "ln -s /var/qmail/supervise/qmail-send /service/qmail-send "
	einfo "ln -s /var/qmail/supervise/qmail-smtpd /service/qmail-smtpd "
	einfo "ln -s /var/qmail/supervise/qmail-pop3d /service/qmail-pop3d "
	echo
	einfo "NOTE: Please check your /var/qmail/control/ldap* files to match your local "
	einfo "ldap settings and add the qmail.schema along with \"allow bind_v2\" to your "
	einfo "slapd.conf. For sample ldifs, please check "
	einfo "/usr/share/doc/${PF}/samples.ldif.gz "


}

pkg_config() {

	# avoid some weird locale problems
	export LC_ALL="C"

	if [ ${ROOT} = "/" ] ; then
		if [ ! -f ${ROOT}var/qmail/control/me ] ; then
			export qhost=`hostname --fqdn`
			${ROOT}var/qmail/bin/config-fast $qhost
		fi
	else
		ewarn "Skipping some configuration as it MUST be run on the final host"
	fi

	einfo "Accepting relaying by default from all ips configured on this machine."
	LOCALIPS=`/sbin/ifconfig  | grep inet | cut -d' ' -f 12 -s | cut -b 6-20`
	TCPSTRING=":allow,RELAYCLIENT=\"\",RBLSMTPD=\"\""
	for ip in $LOCALIPS; do
		myline="${ip}${TCPSTRING}"
		for proto in smtp qmtp qmqp; do
			f="${ROOT}etc/tcp.${proto}"
			egrep -q "${myline}" ${f} || echo "${myline}" >>${f}
		done
	done

	buildtcprules

	if use ssl; then
		${ROOT}etc/cron.daily/qmail-genrsacert.sh
		einfo "Creating a self-signed ssl-certificate:"
		/var/qmail/bin/mkservercert
		einfo "If you want to have a properly signed certificate "
		einfo "instead, do the following:"
		einfo "openssl req -new -nodes -out req.pem \\"
		einfo "-config /var/qmail/control/servercert.cnf \\"
		einfo "-keyout /var/qmail/control/servercert.pem"
		einfo "Send req.pem to your CA to obtain signed_req.pem, and do:"
		einfo "cat signed_req.pem >> /var/qmail/control/servercert.pem"
	fi
}
