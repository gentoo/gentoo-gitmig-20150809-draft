# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/sendmail/sendmail-8.12.9-r1.ebuild,v 1.1 2003/04/24 21:18:58 avenj Exp $

IUSE="ssl ldap sasl berkdb tcpd gdbm mbox"

DESCRIPTION="Widely-used Mail Transport Agent (MTA)."
HOMEPAGE="http://www.sendmail.org"

LICENSE="Sendmail"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc"

PROVIDE="virtual/mta"
DEPEND="net-dns/hesiod
	net-mail/mailbase
	sys-libs/gdbm
	sys-devel/m4
	sasl? ( >=dev-libs/cyrus-sasl-2.1.10 )
	tcpd? ( sys-apps/tcp-wrappers )
	ssl? ( dev-libs/openssl )
	ldap? ( net-nds/openldap )"


PDEPEND="!mbox? ( net-mail/procmail )"


# We need some db; pick gdbm if none in USE
if [ -n "`use gdbm`" ]
then
	DEPEND="${DEPEND}
			sys-libs/gdbm"
elif [ -n "`use berkdb`" ]
then
	DEPEND="${DEPEND}
			sys-libs/db-3.2"
else
	DEPEND="${DEPEND}
			sys-libs/gdbm"
fi

RDEPEND="${DEPEND}
		>=net-mail/mailbase-0.00
		!virtual/mta"

SRC_URI="ftp://ftp.sendmail.org/pub/${PN}/${PN}.${PV}.tar.gz"

S=${WORKDIR}/${P}

src_unpack() {
	unpack ${A}
	cd ${S}

	confCCOPTS="${CFLAGS}"
	confMAPDEF="-DNEWDB -DMAP_REGEX"
	confENVDEF="-DXDEBUG=0"
	confLIBS="-lnsl -lcrypt"
	conf_sendmail_ENVDEF="-DFALSE=0 -DTRUE=1"
	conf_sendmail_LIBS=""
	use sasl && confLIBS="${confLIBS} -lsasl2"  \
		&& confENVDEF="${confENVDEF} -DSASL=2" \
		&& confCCOPTS="${confCCOPTS} -I/usr/include/sasl" \
		&& conf_sendmail_ENVDEF="${conf_sendmail_ENVDEF} -DSASL=2"  \
		&& conf_sendmail_LIBS="${conf_sendmail_LIBS} -lsasl2"
	use tcpd && confENVDEF="${confENVDEF} -DTCPWRAPPERS" \
		&& confLIBS="${confLIBS} -lwrap"
	use ssl && confENVDEF="${confENVDEF} -DSTARTTLS" \
		&& confLIBS="${confLIBS} -lssl -lcrypto" \
		&& conf_sendmail_ENVDEF="${conf_sendmail_ENVDEF} -DSTARTTLS" \
		&& conf_sendmail_LIBS="${conf_sendmail_LIBS} -lssl -lcrypto"
	use ldap && confMAPDEF="${confMAPDEF} -DLDAPMAP" \
		&& confLIBS="${confLIBS} -lldap -llber"
	use gdbm && confLIBS="${confLIBS} -lgdbm"
	sed -e "s:@@confCCOPTS@@:${confCCOPTS}:" \
		-e "s/@@confMAPDEF@@/${confMAPDEF}/" \
		-e "s/@@confENVDEF@@/${confENVDEF}/" \
		-e "s/@@confLIBS@@/${confLIBS}/" \
		-e "s/@@conf_sendmail_ENVDEF@@/${conf_sendmail_ENVDEF}/" \
		-e "s/@@conf_sendmail_LIBS@@/${conf_sendmail_LIBS}/" \
		${FILESDIR}/site.config.m4 > ${S}/devtools/Site/site.config.m4
}

src_compile() {
	for x in libmilter libsmutil sendmail mailstats rmail praliases smrsh makemap vacation mail.local
	do
		pushd ${x}
		sh Build 
		popd
	done
}

src_install () {
	OBJDIR="obj.`uname -s`.`uname -r`.`arch`"
	dodir /etc/pam.d /usr/bin /usr/include/libmilter /usr/lib 
	dodir /usr/share/man/man{1,5,8} /usr/sbin /var/log /usr/share/sendmail-cf
	dodir /var/spool/{mqueue,clientmqueue} /etc/conf.d
	keepdir /var/spool/{clientmqueue,mqueue}
	for dir in libmilter libsmutil sendmail mailstats praliases smrsh makemap vacation
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
	fowners root.smmsp /usr/sbin/sendmail
	fowners smmsp.smmsp /var/spool/clientmqueue
	fperms 770 /var/spool/clientmqueue
	fperms 700 /var/spool/mqueue
	dosym /usr/sbin/sendmail /usr/lib/sendmail
	dosym /usr/sbin/makemap /usr/bin/makemap
	dodoc FAQ LICENSE KNOWNBUGS README RELEASE_NOTES doc/op/op.ps
	newdoc sendmail/README README.sendmail
	newdoc sendmail/SECURITY SECURITY
	newdoc sendmail/TUNING TUNING
	newdoc smrsh/README README.smrsh
	newdoc libmilter/README README.libmilter
	newdoc cf/README README.cf
	newdoc cf/cf/README README.install-cf
	cp -a cf/* ${D}/usr/share/sendmail-cf
	insinto /etc/mail
	if [ -n "` use mbox `" ] 
	then  
		doins ${FILESDIR}/{sendmail.cf,sendmail.mc}
	else
		newins ${FILESDIR}/sendmail-procmail.cf sendmail.cf
		newins ${FILESDIR}/sendmail-procmail.mc sendmail.mc
	fi
	echo "# local-host-names - include all aliases for your machine here" \
		> ${D}/etc/mail/local-host-names
	cat << EOF > ${D}/etc/mail/trusted-users
# trusted-users - users that can send mail as others without a warning
# apache, mailman, majordomo, uucp are good candidates
EOF
	cat << EOF > ${D}/etc/mail/access
# Check the /usr/share/doc/sendmail/README.cf file for a description
# of the format of this file. (search for access_db in that file)
# The /usr/share/doc/sendmail/README.cf is part of the sendmail-doc
# package.
#
# by default we allow relaying from localhost...
localhost.localdomain		RELAY
localhost			RELAY
127.0.0.1			RELAY

EOF
cat << EOF > ${D}/etc/conf.d/sendmail
# Config file for /etc/init.d/sendmail
# add start-up options here
SENDMAIL_OPTS="-bd -q30m -L sm-mta" # default daemon mode
CLIENTMQUEUE_OPTS="-Ac -q30m -L sm-cm" # clientmqueue
KILL_OPTS="" # add -9/-15/your favorite evil SIG level here

EOF
	exeinto /etc/init.d
	newexe ${FILESDIR}/sendmail-r5 sendmail
}
