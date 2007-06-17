# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-mta/qmail-ldap/qmail-ldap-1.03-r6.ebuild,v 1.1 2007/06/17 10:24:00 hollow Exp $

inherit eutils toolchain-funcs fixheadtails flag-o-matic

QMAIL_LDAP_PATCH=20060201
QMAIL_SPP_PATCH=0.42
CONTROLS_PATCH=20060401b

DESCRIPTION="qmail -- a secure, reliable, efficient, simple message transfer agent"
HOMEPAGE="
	http://www.qmail-ldap.org
	http://cr.yp.to/qmail.html
	http://qmail.org/
"
SRC_URI="
	mirror://qmail/qmail-${PV}.tar.gz
	http://www.nrg4u.com/qmail/${P}-${QMAIL_LDAP_PATCH}.patch.gz
	mirror://gentoo/${P}-${QMAIL_LDAP_PATCH}-controls${CONTROLS_PATCH}.patch
	mirror://gentoo/${P}-queue-custom-error.patch
	qmail-spp? ( mirror://gentoo/${P}-spp-${QMAIL_SPP_PATCH}.patch )
"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE="cluster controldb gencertdaily highvolume mailwrapper qmail-spp rfc2307 rfc822 ssl zlib"
RESTRICT="test"

DEPEND="
	!mail-mta/qmail
	sys-apps/groff
	net-mail/queue-repair
	ssl? ( dev-libs/openssl )
	net-nds/openldap
"
RDEPEND="
	mailwrapper? ( net-mail/mailwrapper )
	!mailwrapper? ( !virtual/mta )
	sys-apps/ucspi-tcp
	sys-process/daemontools
	net-mail/dot-forward
	${DEPEND}
"
PROVIDE="
	virtual/mta
	virtual/mda
"

# Important: QMAIL_CONF_SPLIT should always be a prime number!
MY_CONF_SPLIT="${QMAIL_CONF_SPLIT:-23}"

MY_S="${WORKDIR}"/qmail-${PV}
TCPRULES_DIR=/etc/tcprules.d

if use gencertdaily; then
	CRON_FOLDER=cron.daily
else
	CRON_FOLDER=cron.hourly
fi


src_unpack() {
	unpack qmail-${PV}.tar.gz
	cd "${MY_S}"

	# main ldap patch
	# includes: netqmail-1.05, EXTTODO, BIGTODO, TLS/SMTPAUTH, 0.0.0.0 fix
	epatch ${DISTDIR}/${P}-${QMAIL_LDAP_PATCH}.patch.gz

	# QmailLDAP/Controls patch
	# includes: RFC2307/822 fixes
	epatch ${DISTDIR}/${P}-${QMAIL_LDAP_PATCH}-controls${CONTROLS_PATCH}.patch

	# fix libraries for controls patch
	sed -i -e 's|NEWLDAPPROGLIBS=.*|& str.a|' Makefile

	# Add custom bounce messages to qmail-queue
	epatch ${DISTDIR}/${P}-queue-custom-error.patch

	# qmail-spp patch
	use qmail-spp && epatch ${DISTDIR}/${P}-spp-${QMAIL_SPP_PATCH}.patch

	if [[ -n "${QMAIL_PATCH_DIR}" && -d "${QMAIL_PATCH_DIR}" ]]
	then
		echo
		ewarn "You enabled custom patches from ${QMAIL_PATCH_DIR}."
		ewarn "Be warned that you won't get any support when using "
		ewarn "this feature. You're on your own from now!"
		ebeep
		epatch "${QMAIL_PATCH_DIR}/"*
		echo
	fi

	# makefile options
	local INCLUDES="-I/usr/include"
	local LDAPLIBS="-L/usr/lib -lldap -llber"
	local LDAPFLAGS="-DALTQUEUE -DEXTERNAL_TODO -DDASH_EXT -DSMTPEXECCHECK"
	local SECUREBIND= CONTROLDB= RFCFLAGS=

	use cluster    && LDAPFLAGS="${LDAPFLAGS} -DQLDAP_CLUSTER"
	use highvolume && LDAPFLAGS="${LDAPFLAGS} -DBIGTODO"
	use zlib       && LDAPFLAGS="${LDAPFLAGS} -DDATA_COMPRESS -D QMQP_COMPRESS"

	use controldb  && CONTROLDB="-DUSE_CONTROLDB -DQLDAP_BAILOUT"

	use rfc2307    && RFCFLAGS="${RFCFLAGS} -DRFC2307"
	use rfc822     && RFCFLAGS="${RFCFLAGS} -DRFC822"

	use ssl        && SECUREBIND="-DSECUREBIND_TLS -DSECUREBIND_SSL"

	# a lot of sed magic to get Makefile right
	local EXP=

	EXP="${EXP} s|^#LDAPINCLUDES=.*|LDAPINCLUDES=${INCLUDES}|;"
	EXP="${EXP} s|^#LDAPLIBS=.*|LDAPLIBS=${LDAPLIBS}|;"
	EXP="${EXP} s|^#LDAPFLAGS=.*|LDAPFLAGS=${LDAPFLAGS}|;"

	EXP="${EXP} s|^#CONTROLDB=.*|CONTROLDB=${CONTROLDB}|;"
	EXP="${EXP} s|^#RFCFLAGS=.*|RFCFLAGS=${RFCFLAGS}|;"
	EXP="${EXP} s|^#SECUREBIND=.*|SECUREBIND=${SECUREBIND}|;"

	# TODO: do we even need this with LDAP?
	EXP="${EXP} s|^#SHADOWLIBS=.*|SHADOWLIBS=-lcrypt|;"

	# automagic maildir creation
	EXP="${EXP} s|^#\(MDIRMAKE=.*\)|\1|;"
	EXP="${EXP} s|^#\(HDIRMAKE=.*\)|\1|;"

	use zlib && EXP="${EXP} s|^#ZLIB=.*|ZLIB=-lz|;"

	if use ssl; then
		EXP="${EXP} s|^#\(TLS=.*\)|\1|;"
		EXP="${EXP} s|^#TLSINCLUDES=.*|TLSINCLUDES=${INCLUDES}|;"
		EXP="${EXP} s|^#TLSLIBS=.*|TLSLIBS=-L/usr/lib -lssl -lcrypto|;"
		EXP="${EXP} s|^#OPENSSLBIN=.*|OPENSSLBIN=/usr/bin/openssl|;"
	fi

	sed -i -e "${EXP}" Makefile || die "could not patch Makefile"

	is_prime ${MY_CONF_SPLIT} || die 'QMAIL_CONF_SPLIT is not a prime number.'
	einfo "Using conf-split value of ${MY_CONF_SPLIT}."

	ht_fix_file Makefile*
	append-ldflags $(bindnow-flags)

	# The following commands patch the conf-{cc,ld} files to use the user's
	# specified CFLAGS and LDFLAGS. These rather complex commands are needed
	# because a user supplied patch might apply changes to these files, too.
	# Fixes Bug #165981.
	echo "$(head -n 1 "${MY_S}/conf-cc" | sed -e "s#^g\?cc\s\+\(-O2\)\?#$(tc-getCC) #")" \
		"${CFLAGS}" > "${MY_S}/conf-cc.tmp" &&
	mv "${MY_S}/conf-cc.tmp" "${MY_S}/conf-cc" || die 'Patching conf-cc failed.'

	echo "$(head -n 1 "${MY_S}/conf-ld" | sed -e "s#^g\?cc\s\+\(-s\)\?#$(tc-getCC) #")" \
		"${LDLAGS}" > "${MY_S}/conf-ld.tmp" &&
	mv "${MY_S}/conf-ld.tmp" "${MY_S}/conf-ld" || die 'Patching conf-ld failed.'

	echo -n "${MY_CONF_SPLIT}" > "${MY_S}/conf-split"
}

src_compile() {
	cd "${MY_S}"
	emake it man ldap || die "make failed"
}

src_install() {
	cd "${MY_S}"

	einfo "Setting up directory hierarchy ..."

	diropts -m 755 -o root -g qmail
	dodir /var/qmail/{,bin,boot,control}

	keepdir /var/qmail/users

	diropts -m 755 -o alias -g qmail
	dodir /var/qmail/alias

	einfo "Installing the qmail software ..."

	insopts -o root -g qmail -m 755
	insinto /var/qmail/boot
	doins home home+df proc proc+df binm1 binm1+df binm2 \
		binm2+df binm3 binm3+df

	insinto /var/qmail/bin

	insopts -o qmailq -g qmail -m 4711
	doins qmail-queue

	insopts -o root -g qmail -m 700
	doins qmail-{lspawn,start,newu,newmrh}

	insopts -o root -g qmail -m 711
	doins qmail-{getpw,local,remote,rspawn,clean,send,pw2u} splogger

	insopts -o root -g qmail -m 755
	doins bouncesaying condredirect config-fast datemail elq \
		except forward maildir2mbox maildirmake maildirwatch \
		mailsubj pinq predate preline qail qbiff \
		qmail-{inject,pop3d,popup,qmqpc,qmqpd,qmtpd,qread} \
		qmail-{qstat,showctl,smtpd,tcpok,tcpto} \
		qreceipt qsmhook sendmail tcp-env
	doins auth_{imap,pop,smtp} condwrite digest dirmaker \
		pbs{add,check,dbd} qmail-{cdb,forward,group} \
		qmail-{ldaplookup,quotawarn,reply,secretary,todo,verify}

	einfo "Installing manpages"
	into /usr
	doman *.[1-8]

	dodoc BLURB* CHANGES FAQ INSTALL* PIC* README* REMOVE* SECURITY \
		SENDMAIL SYSDEPS TARGETS TEST* THANKS* THOUGHTS TODO* \
		UPGRADE VERSION* \
		QLDAP* ${FILESDIR}/samples.ldif

	# use the correct maildirmake
	# the courier-imap one has some extensions that are nicer
	[[ -e /usr/bin/maildirmake ]] && \
		MAILDIRMAKE="/usr/bin/maildirmake" || \
		MAILDIRMAKE="${D}/var/qmail/bin/maildirmake"

	einfo "Adding env.d entry for qmail"
	insopts -m 644
	doenvd ${FILESDIR}/99qmail

	einfo "Creating sendmail replacement ..."
	diropts -m 755
	dodir /usr/sbin /usr/lib

	if use mailwrapper
	then
		insinto /etc/mail
		doins ${FILESDIR}/mailer.conf
	else
		dosym /var/qmail/bin/sendmail /usr/sbin/sendmail
		dosym /var/qmail/bin/sendmail /usr/lib/sendmail
	fi

	einfo "Setting up the default aliases ..."
	diropts -m 700 -o alias -g qmail
	${MAILDIRMAKE} ${D}/var/qmail/alias/.maildir
	keepdir /var/qmail/alias/.maildir/{cur,new,tmp}

	for i in /var/qmail/alias/.qmail-{mailer-daemon,postmaster,root}
	do
		if [[ ! -f ${i} ]]; then
			touch ${D}${i}
			fowners alias:qmail ${i}
		fi
	done

	einfo "Setting up maildirs by default in the account skeleton ..."
	diropts -m 755 -o root -g root
	insinto /etc/skel
	newins ${FILESDIR}/dot-qmail .qmail.sample
	fperms 644 /etc/skel/.qmail.sample
	${MAILDIRMAKE} ${D}/etc/skel/.maildir
	keepdir /etc/skel/.maildir/{cur,new,tmp}

	einfo "Setting up all services (send, smtp, qmtp, qmqp, pop3) ..."
	insopts -o root -g root -m 755
	diropts -m 755 -o root -g root
	dodir /var/qmail/supervise

	for i in send smtpd qmtpd qmqpd pop3d; do
		insopts -o root -g root -m 755
		diropts -m 755 -o root -g root
		dodir /var/qmail/supervise/qmail-${i}{,/log}
		fperms +t /var/qmail/supervise/qmail-${i}{,/log}
		insinto /var/qmail/supervise/qmail-${i}
		newins ${FILESDIR}/run-qmail-${i} run
		insinto /var/qmail/supervise/qmail-${i}/log
		newins ${FILESDIR}/run-qmail-${i}-log run
		diropts -m 755 -o qmaill
		keepdir /var/log/qmail/qmail-${i}
	done

	dodir ${TCPRULES_DIR}
	insinto ${TCPRULES_DIR}
	newins ${FILESDIR}/tcprules.d-Makefile.qmail Makefile.qmail
	for i in smtp qmtp qmqp pop3; do
		newins ${FILESDIR}/tcp.${i}.sample tcp.qmail-${i}
	done

	einfo "Installing OpenLDAP schema ..."
	insinto /etc/openldap/schema
	doins qmail.schema

	einfo "Installing some stock configuration files"
	insinto /var/qmail/control
	insopts -o root -g root -m 644
	doins ${FILESDIR}/conf-{common,send,qmtpd,qmqpd,pop3d}
	newins ${FILESDIR}/conf-smtpd conf-smtpd
	newins ${FILESDIR}/dot-qmail defaultdelivery
	use ssl && \
		doins ${FILESDIR}/servercert.cnf

	einfo "Configuration sanity checker and launcher"
	into /var/qmail
	insopts -o root -g root -m 644
	dobin ${FILESDIR}/qmail-config-system

	if use qmail-spp; then
		einfo "Installing files for qmail-spp"
		insinto /var/qmail/control/
		doins ${FILESDIR}/smtpplugins
		keepdir /var/qmail/plugins/
	fi

	if use ssl; then
		einfo "SSL Certificate creation script"
		dobin ${FILESDIR}/mkservercert
		einfo "RSA key generation cronjob"
		insinto /etc/${CRON_FOLDER}
		doins ${FILESDIR}/qmail-genrsacert.sh
		chmod +x ${D}/etc/${CRON_FOLDER}/qmail-genrsacert.sh

		# for some files
		keepdir /var/qmail/control/tlshosts/
	fi
}

rootmailfixup() {
	# so you can check mail as root easily
	local TMPCMD="ln -sf /var/qmail/alias/.maildir/ ${ROOT}/root/.maildir"
	if [[ -d "${ROOT}/root/.maildir" && ! -L "${ROOT}/root/.maildir" ]] ; then
		elog "Previously the qmail ebuilds created /root/.maildir/ but not"
		elog "every mail was delivered there. If the directory does not"
		elog "contain any mail, please delete it and run:"
		elog "${TMPCMD}"
	else
		${TMPCMD}
	fi
	chown -R alias:qmail ${ROOT}/var/qmail/alias/.maildir 2>/dev/null
}

buildtcprules() {
	for i in smtp qmtp qmqp pop3; do
		# please note that we don't check if it exists
		# as we want it to make the cdb files anyway!
		f=tcp.qmail-${i}
		src=${ROOT}${TCPRULES_DIR}/${f}
		cdb=${ROOT}${TCPRULES_DIR}/${f}.cdb
		tmp=${ROOT}${TCPRULES_DIR}/.${f}.tmp
		[[ -e ${src} ]] && tcprules ${cdb} ${tmp} < ${src}
	done
}

pkg_postinst() {
	einfo "Setting up the message queue hierarchy ..."
	/usr/bin/queue-repair.py \
		--create --split "${MY_CONF_SPLIT}" \
		$(use highvolume && echo '--bigtodo' || echo '--no-bigtodo') \
		${ROOT}/var/qmail >/dev/null || \
		die 'queue-repair failed'

	rootmailfixup
	buildtcprules

	# for good measure
	env-update

	elog "To setup qmail to run out-of-the-box on your system, run:"
	elog "emerge --config =${CATEGORY}/${PF}"
	elog
	elog "To start qmail at boot you have to add svscan to your startup"
	elog "and create the following links:"
	elog "ln -s /var/qmail/supervise/qmail-send /service/qmail-send"
	elog "ln -s /var/qmail/supervise/qmail-smtpd /service/qmail-smtpd"
	elog
	elog "To start the pop3 server as well, create the following link:"
	elog "ln -s /var/qmail/supervise/qmail-pop3d /service/qmail-pop3d"
	elog
	elog "Additionally, the QMTP and QMQP protocols are supported, "
	elog "and can be started as:"
	elog "ln -s /var/qmail/supervise/qmail-qmtpd /service/qmail-qmtpd"
	elog "ln -s /var/qmail/supervise/qmail-qmqpd /service/qmail-qmqpd"
	elog
	elog "Additionally, if you wish to run qmail right now, you should "
	elog "run this before anything else:"
	elog "source /etc/profile"
	elog
	elog "If you are looking for documentation, check those links:"
	elog "http://www.lifewithqmail.com/ldap/"
	elog "  -- Life with qmail-ldap"
	elog
	elog "For sample ldifs, please check"
	elog "/usr/share/doc/${PF}/samples.ldif.gz"
}

pkg_preinst() {
	mkdir -p ${TCPRULES_DIR}
	for proto in smtp qmtp qmqp pop3; do
		for ext in '' .cdb; do
			old="/etc/tcp.${proto}${ext}"
			new="${TCPRULES_DIR}/tcp.qmail-${proto}${ext}"
			fail=0
			if [[ -f "$old" && ! -f "$new" ]]; then
				einfo "Moving $old to $new"
				cp $old $new || fail=1
			else
				fail=1
			fi
			if [[ "${fail}" = 1 && -f ${old} ]]; then
				eerror "Error moving $old to $new, be sure to check the"
				eerror "configuration! You may have already moved the files,"
				eerror "in which case you can delete $old"
			fi
		done
	done
}

# Candidate for eclass
pkg_setup() {
	# keep in sync with mini-qmail pkg
	einfo "Creating groups and users"
	enewgroup nofiles 200
	enewgroup qmail 201
	enewuser alias 200 -1 /var/qmail/alias 200
	enewuser qmaild 201 -1 /var/qmail 200
	enewuser qmaill 202 -1 /var/qmail 200
	enewuser qmailp 203 -1 /var/qmail 200
	enewuser qmailq 204 -1 /var/qmail 201
	enewuser qmailr 205 -1 /var/qmail 201
	enewuser qmails 206 -1 /var/qmail 201
}

pkg_config() {
	# avoid some weird locale problems
	export LC_ALL=C

	if [[ ${ROOT} = / ]] ; then
		if [[ ! -f ${ROOT}var/qmail/control/me ]] ; then
			export qhost=$(hostname --fqdn)
			${ROOT}var/qmail/bin/config-fast $qhost
		fi
	else
		ewarn "Skipping some configuration as it MUST be run on the final host"
	fi

	einfo "Accepting relaying by default from all ips configured on this machine."
	LOCALIPS=$(/sbin/ifconfig | grep inet | cut -d' ' -f 12 -s | cut -b 6-20)
	TCPSTRING=":allow,RELAYCLIENT=\"\",RBLSMTPD=\"\""
	for ip in $LOCALIPS; do
		myline="${ip}${TCPSTRING}"
		for proto in smtp qmtp qmqp; do
			f="${ROOT}${TCPRULES_DIR}/tcp.qmail-${proto}"
			egrep -q "${myline}" ${f} || echo "${myline}" >>${f}
		done
	done

	buildtcprules

	if use ssl; then
		ebegin "Generating RSA keys for SSL/TLS, this can take some time"
		${ROOT}/etc/${CRON_FOLDER}/qmail-genrsacert.sh
		eend $?
		einfo "Creating a self-signed ssl-certificate:"
		${ROOT}/var/qmail/bin/mkservercert
		einfo "If you want to have a properly signed certificate "
		einfo "instead, do the following:"
		# space at the end of the string because of the current implementation
		# of einfo
		einfo "openssl req -new -nodes -out req.pem \\ "
		einfo "  -config /var/qmail/control/servercert.cnf \\ "
		einfo "  -keyout /var/qmail/control/servercert.pem"
		einfo "Send req.pem to your CA to obtain signed_req.pem, and do:"
		einfo "cat signed_req.pem >> /var/qmail/control/servercert.pem"
	fi
}

# --- TODO: The following code can be moved to prime.eclass --
# Original Author: Michael Hanselmann <hansmi@gentoo.org>
# Purpose: Functions for prime numbers

# Prints a list of primes between min and max inclusive
#
# Note: this functions gets very slow when used with large numbers.
#
# Syntax: primes <min> <max>
primes() {
	local min=${1} max=${2}
	local result= primelist=2 i p

	[[ ${min} -le 2 ]] && result="${result} 2"

	for ((i = 3; i <= max; i += 2))
	do
		for p in ${primelist}
		do
			[[ $[i % p] == 0 || $[p * p] -gt ${i} ]] && \
				break
		done
		if [[ $[i % p] != 0 ]]
		then
			primelist="${primelist} ${i}"
			[[ ${i} -ge ${min} ]] && \
				result="${result} ${i}"
		fi
	done

	echo ${result}
}

# Checks wether a number is a prime number
#
# Syntax: is_prime <number>
is_prime() {
	local number=${1} i
	for i in $(primes ${number} ${number})
	do
		[[ ${i} == ${number} ]] && return 0
	done
	return 1
}
# --- end of prime.eclass ---
