# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-mta/sendmail/sendmail-8.13.3.ebuild,v 1.5 2005/04/05 17:24:41 corsair Exp $

inherit eutils

DESCRIPTION="Widely-used Mail Transport Agent (MTA)"
HOMEPAGE="http://www.sendmail.org/"
SRC_URI="ftp://ftp.sendmail.org/pub/${PN}/${PN}.${PV}.tar.gz"

LICENSE="Sendmail"
SLOT="0"
KEYWORDS="x86 ~ppc ~sparc ~hppa ~alpha ~ia64 ~s390 amd64 ppc64"
IUSE="ssl ldap sasl tcpd mbox milter mailwrapper ipv6"

DEPEND="net-mail/mailbase
	sys-devel/m4
	sasl? ( >=dev-libs/cyrus-sasl-2.1.10 )
	tcpd? ( sys-apps/tcp-wrappers )
	ssl? ( dev-libs/openssl )
	ldap? ( net-nds/openldap )
	>=sys-libs/db-3.2
	!net-mail/vacation
	"
RDEPEND="${DEPEND}
		>=net-mail/mailbase-0.00
		!mailwrapper? ( !virtual/mta )
		mailwrapper? ( >=net-mail/mailwrapper-0.2 )"
PDEPEND="!mbox? ( mail-filter/procmail )"
PROVIDE="virtual/mta"

src_unpack() {
	unpack ${A}
	cd ${S}

	epatch ${FILESDIR}/sendmail-delivered_hdr.patch || die

	confCCOPTS="${CFLAGS}"
	confMAPDEF="-DMAP_REGEX"
	conf_sendmail_LIBS=""
	use sasl && confLIBS="${confLIBS} -lsasl2"  \
		&& confENVDEF="${confENVDEF} -DSASL=2" \
		&& confCCOPTS="${confCCOPTS} -I/usr/include/sasl" \
		&& conf_sendmail_LIBS="${conf_sendmail_LIBS} -lsasl2"
	use tcpd && confENVDEF="${confENVDEF} -DTCPWRAPPERS" \
		&& confLIBS="${confLIBS} -lwrap"
	use ssl && confENVDEF="${confENVDEF} -DSTARTTLS -D_FFR_DEAL_WITH_ERROR_SSL" \
		&& confLIBS="${confLIBS} -lssl -lcrypto" \
		&& conf_sendmail_LIBS="${conf_sendmail_LIBS} -lssl -lcrypto"
	use ldap && confMAPDEF="${confMAPDEF} -DLDAPMAP" \
		&& confLIBS="${confLIBS} -lldap -llber"
	use milter && confENVDEF="${confENVDEF} -DMILTER"
	use ipv6 && confENVDEF="${confENVDEF} -DNETINET6"
	sed -e "s:@@confCCOPTS@@:${confCCOPTS}:" \
		-e "s/@@confMAPDEF@@/${confMAPDEF}/" \
		-e "s/@@confENVDEF@@/${confENVDEF}/" \
		-e "s/@@confLIBS@@/${confLIBS}/" \
		-e "s/@@conf_sendmail_LIBS@@/${conf_sendmail_LIBS}/" \
		${FILESDIR}/site.config.m4 > ${S}/devtools/Site/site.config.m4
}

src_compile() {
	sh Build || die "compilation failed in main Build script"

	if use milter
	then
	    pushd libmilter
		sh Build || die "libmilter compilation failed"
		popd
	fi
}

src_install () {
	OBJDIR="obj.`uname -s`.`uname -r`.`arch`"
	dodir /etc/pam.d /usr/bin /usr/lib
	dodir /usr/share/man/man{1,5,8} /usr/sbin /var/log /usr/share/sendmail-cf
	dodir /var/spool/{mqueue,clientmqueue} /etc/conf.d
	keepdir /var/spool/{clientmqueue,mqueue}
	for dir in libsmutil sendmail mailstats praliases smrsh makemap vacation editmap
	do
		make DESTDIR=${D} MANROOT=/usr/share/man/man \
			SBINOWN=root SBINGRP=root UBINOWN=root UBINGRP=root \
			MANOWN=root MANGRP=root INCOWN=root INCGRP=root \
			LIBOWN=root LIBGRP=root GBINOWN=root GBINGRP=root \
			MSPQOWN=root CFOWN=root CFGRP=root \
			install -C ${OBJDIR}/${dir} \
			|| die "install failed"
	done
	for dir in rmail mail.local
	do
		make DESTDIR=${D} MANROOT=/usr/share/man/man \
			SBINOWN=root SBINGRP=root UBINOWN=root UBINGRP=root \
			MANOWN=root MANGRP=root INCOWN=root INCGRP=root \
			LIBOWN=root LIBGRP=root GBINOWN=root GBINGRP=root \
			MSPQOWN=root CFOWN=root CFGRP=root \
			force-install -C ${OBJDIR}/${dir} \
			|| die "install failed"
	done

	if use milter
	then
	    dodir /usr/include/libmilter
		make DESTDIR=${D} MANROOT=/usr/share/man/man \
			SBINOWN=root SBINGRP=root UBINOWN=root UBINGRP=root \
			MANOWN=root MANGRP=root INCOWN=root INCGRP=root \
			LIBOWN=root LIBGRP=root GBINOWN=root GBINGRP=root \
			MSPQOWN=root CFOWN=root CFGRP=root \
			install -C ${OBJDIR}/libmilter \
			|| die "install failed"
	fi

	fowners root:smmsp /usr/sbin/sendmail
	fperms 2555 /usr/sbin/sendmail
	fowners smmsp:smmsp /var/spool/clientmqueue
	fperms 770 /var/spool/clientmqueue
	fperms 700 /var/spool/mqueue
	dosym /usr/sbin/sendmail /usr/lib/sendmail
	dosym /usr/sbin/makemap /usr/bin/makemap
	dodoc FAQ LICENSE KNOWNBUGS README RELEASE_NOTES doc/op/op.ps
	newdoc sendmail/README README.sendmail
	newdoc sendmail/SECURITY SECURITY
	newdoc sendmail/TUNING TUNING
	newdoc smrsh/README README.smrsh

	if use milter
	then
		newdoc libmilter/README README.libmilter
	fi

	newdoc cf/README README.cf
	newdoc cf/cf/README README.install-cf
	cp -a cf/* ${D}/usr/share/sendmail-cf
	insinto /etc/mail
	if use mbox
	then
		doins ${FILESDIR}/sendmail.mc
	else
		newins ${FILESDIR}/sendmail-procmail.mc sendmail.mc
	fi
	m4 ${D}/etc/mail/sendmail.mc > ${D}/etc/mail/sendmail.cf
	echo "# local-host-names - include all aliases for your machine here" \
		> ${D}/etc/mail/local-host-names
	cat <<- EOF > ${D}/etc/mail/trusted-users
		# trusted-users - users that can send mail as others without a warning
		# apache, mailman, majordomo, uucp are good candidates
	EOF
	cat <<- EOF > ${D}/etc/mail/access
		# Check the /usr/share/doc/sendmail/README.cf file for a description
		# of the format of this file. (search for access_db in that file)
		# The /usr/share/doc/sendmail/README.cf is part of the sendmail-doc
		# package.
		#

	EOF
	cat <<- EOF > ${D}/etc/conf.d/sendmail
		# Config file for /etc/init.d/sendmail
		# add start-up options here
		SENDMAIL_OPTS="-bd -q30m -L sm-mta" # default daemon mode
		CLIENTMQUEUE_OPTS="-Ac -q30m -L sm-cm" # clientmqueue
		KILL_OPTS="" # add -9/-15/your favorite evil SIG level here

	EOF
	exeinto /etc/init.d
	doexe ${FILESDIR}/sendmail
	keepdir /usr/adm/sm.bin

	if use mailwrapper
	then
		mv ${D}/usr/sbin/sendmail ${D}/usr/sbin/sendmail.sendmail
		insinto /etc/mail
		doins ${FILESDIR}/mailer.conf
		dosed 's/} sendmail/} sendmail.sendmail/' /etc/init.d/sendmail
	fi

}

pkg_preinst() {
	if ! groupmod smmsp; then
		groupadd smmsp || die "problem adding group smmsp"
	fi
}

pkg_postinst() {
	if ! use mailwrapper && [[ -e /etc/mailer.conf ]]
	then
		einfo
		einfo "Since you emerged sendmail without mailwrapper in USE,"
		einfo "you probably want to 'emerge -C mailwrapper' now."
		einfo
	fi
}
