# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-mta/courier/courier-0.47.20041129.ebuild,v 1.6 2004/12/07 01:16:58 swtaylor Exp $

inherit eutils

DESCRIPTION="An MTA designed specifically for maildirs"
[ -z "${PV/?.??/}" ] && SRC_URI="mirror://sourceforge/courier/${P}.tar.bz2" || SRC_URI="http://www.courier-mta.org/beta/courier/${P}.tar.bz2"
HOMEPAGE="http://www.courier-mta.org/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~alpha ~ppc ~sparc ~amd64 ~mips"
IUSE="postgres ldap mysql pam nls ipv6 spell fax crypt norewrite uclibc mailwrapper"

PROVIDE="virtual/mta
	 virtual/mda
	 virtual/imapd"

DEPEND="virtual/libc
	net-libs/courier-authlib
	>=dev-libs/openssl-0.9.6
	>=sys-libs/gdbm-1.8.0
	|| ( app-misc/mime-types net-www/apache )
	crypt? ( >=app-crypt/gnupg-1.0.4 )
	fax? ( >=media-libs/netpbm-9.12 virtual/ghostscript >=net-dialup/mgetty-1.1.28 )
	pam? ( >=sys-libs/pam-0.75 )
	mysql? ( >=dev-db/mysql-3.23.36 )
	ldap? ( >=net-nds/openldap-1.2.11 )
	postgres? ( >=dev-db/postgresql-7.1.3 )
	spell? ( virtual/aspell-dict )
	!mailwrapper? ( !virtual/mta )
	!virtual/mda
	!virtual/imapd"

RDEPEND="${DEPEND}
	virtual/fam
	dev-lang/perl
	sys-apps/procps"

PDEPEND="mailwrapper? ( >=net-mail/mailwrapper-0.2 )"

src_unpack() {
	unpack ${A}
	cd ${S}
	use norewrite && epatch ${FILESDIR}/norewrite.patch
	use uclibc && sed -i -e 's:linux-gnu\*:linux-gnu\*\ \|\ linux-uclibc:' config.sub
}

src_compile() {
	local myconf
	myconf="`use_with spell ispell` `use_with ipv6` \
			`use_with ldap ldapaliasd` `use_enable ldap maildropldap` \
			`use_enable nls` `use_enable nls unicode ${ENABLE_UNICODE}`"
	use ldap && myconf="${myconf} --with-ldapconfig=/etc/courier/maildropldap.conf"

	[ -e /etc/apache/conf/mime.types ] && \
		myconf="${myconf} --enable-mimetypes=/etc/apache/conf/mime.types"
	[ -e /etc/apache2/conf/mime.types ] && \
		myconf="${myconf} --enable-mimetypes=/etc/apache2/conf/mime.types"
	[ -e /etc/mime.types ] && \
		myconf="${myconf} --enable-mimetypes=/etc/mime.types"

	einfo "Configuring courier: `echo ${myconf} | xargs echo`"
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
		--with-authdaemonvar=/var/lib/courier/authdaemon \
		--with-mailuser=mail \
		--with-mailgroup=mail \
		--with-paranoid-smtpext \
		--with-db=gdbm \
		--disable-autorenamesent \
		--cache-file=${S}/configuring.cache \
		--host=${CHOST} ${myconf} debug=true || die "./configure"
	sed -e'/^install-perms-local:/a\	sed -e\"s|^|'${D}'|g\" -i permissions.dat' -i Makefile
	emake || die "Compile problem"
}

etc_courier() {
	# Import existing /etc/courier/file if it exists.
	# Add option only if it was not already set or even commented out
	file="${1}" ; word="`echo \"${2}\" | sed -e\"s|=.*$||\" -e\"s|^.*opt ||\"`"
	[ ! -e "${D}/etc/courier/${file}" ] && [ -e "/etc/courier/${file}" ] && \
			cp "/etc/courier/${file}" "${D}/etc/courier/${file}"
	grep -q "${word}" "${D}/etc/courier/${file}" || \
		echo "${2}" >> "${D}/etc/courier/${file}"
}

etc_courier_chg() {
	file="${1}" ; key="${2}" ; value="${3}"
	grep -q "${key}" "${file}" && einfo "Changing ${file}: ${key} to ${value}"
	sed -i -e"/\#\#NAME: ${key}/,+20 s|${key}=.*|${key}=\"${value}\"|g" ${file}
}

set_maildir() {
	local f ; local files=$*
	origmaildir='Maildir'
	newmaildir='.maildir'
	for f in ${files} ; do
		grep -q "${origmaildir}" "${f}" && \
			einfo "Changing ${origmaildir} in ${f} to ${newmaildir}"
		sed -i -e"/^[^\#]/ s/${origmaildir}/${newmaildir}/g" ${f}
	done
}

src_install() {
	local f
	dodir /etc/pam.d
	dodir /var/lib/courier
	dodir /var/run/courier
	make install DESTDIR=${D} || die "install"
	make install-configure || die "install-configure"
	diropts -o mail -g mail
	for dir2keep in `(cd ${D} && find . -type d)` ; do
		keepdir $dir2keep || die "failed running keepdir: $dir2keep"
	done

	einfo "Setting up maildirs in the account skeleton ..."
	diropts -m 755 -o root -g root
	keepdir /etc/skel
	${D}/usr/bin/maildirmake ${D}/etc/skel/.maildir
	keepdir /etc/skel/.maildir
	keepdir /var/spool/mail
	${D}/usr/bin/maildirmake ${D}/var/spool/mail/.maildir
	keepdir /var/spool/mail/.maildir

	exeinto /etc/init.d
	newexe ${FILESDIR}/courier-init courier
	`grep DAEMONLIST /etc/init.d/courier >&/dev/null` && \
		newexe ${FILESDIR}/courier courier-old

	cd ${D}/etc/courier
	insinto /etc/courier
	newins ${FILESDIR}/apache-sqwebmail.inc apache-sqwebmail.inc
	mv imapd.authpam imap.authpam ; mv pop3d.authpam pop3.authpam
	for f in *.authpam ; do mv "${f}" "${D}/etc/pam.d/${f%%.authpam}" ; done
	for f in *.dist ; do cp ${f} ${f%%.dist} ; done
	[ -e ldapaliasrc ] && chown mail:root ldapaliasrc
	set_maildir courierd imapd imapd-ssl pop3d pop3d-ssl sqwebmaild *.dist

	( [ -e /etc/courier/sizelimit ] && cat /etc/courier/sizelimit || echo 0 ) \
		> ${D}/etc/courier/sizelimit
	etc_courier maildroprc ""
	etc_courier esmtproutes ""
	etc_courier backuprelay ""
	etc_courier locallowercase ""
	etc_courier bofh "opt BOFHBADMIME=accept"
	etc_courier bofh "opt BOFHSPFTRUSTME=1"
	etc_courier bofh "opt BOFHSPFHELO=pass,neutral,unknown,none,error,softfail,fail"
	etc_courier bofh "opt BOFHSPFHELO=pass,neutral,unknown,none"
	etc_courier bofh "opt BOFHSPFFROM=all"
	etc_courier bofh "opt BOFHSPFMAILFROM=all"
	etc_courier bofh "#opt BOFHSPFHARDERROR=fail"
	etc_courier esmtpd "BOFHBADMIME=accept"
	etc_courier esmtpd-ssl "BOFHBADMIME=accept"
	etc_courier esmtpd-msa "BOFHBADMIME=accept"
	etc_courier_chg esmtpd ESMTPDSTART YES
	etc_courier_chg esmtpd-msa ESMTPDSTART YES
	etc_courier_chg esmtpd-ssl ESMTPDSSLSTART YES
	etc_courier_chg imapd IMAPDSTART YES
	etc_courier_chg imapd-ssl IMAPDSSLSTART YES
	etc_courier_chg pop3d POP3DSTART YES
	etc_courier_chg pop3d-ssl POP3DSSLSTART YES

	cd ${S}
	cp imap/README README.imap
	use nls && cp unicode/README README.unicode
	dodoc AUTHORS BENCHMARKS COPYING* ChangeLog* INSTALL NEWS README* TODO courier/doc/*.txt
	dodoc tcpd/README.couriertls
	echo "See /usr/share/courier/htmldoc/index.html for docs in html format" \
		>> ${D}/usr/share/doc/${P}/README.htmldocs

	insinto /usr/lib/courier/courier
	insopts -m  755 -o mail -g mail
	doins ${S}/courier/webmaild
	insinto /etc/courier/webadmin
	insopts -m 400 -o mail -g mail
	doins ${FILESDIR}/password.dist

	# avoid name collisions in /usr/sbin, make webadmin match
	cd ${D}/usr/sbin
	for f in imapd imapd-ssl pop3d pop3d-ssl ; do mv ${f} courier-${f} ; done
	sed -i -e 's:\$sbindir\/imapd:\$sbindir\/courier-imapd:g' \
		-e 's:\$sbindir\/imapd-ssl:\$sbindir\/courier-imapd-ssl:g' \
		${D}/usr/share/courier/courierwebadmin/admin-40imap.pl \
		|| ewarn "failed to fix webadmin"
	sed -i -e 's:\$sbindir\/pop3d:\$sbindir\/courier-pop3d:g' \
		-e 's:\$sbindir\/pop3d-ssl:\$sbindir\/courier-pop3d-ssl:g' \
		${D}/usr/share/courier/courierwebadmin/admin-45pop3.pl \
		|| ewarn "failed to fix webadmin"

	if use mailwrapper ; then
		mv ${D}/usr/bin/sendmail ${D}/usr/bin/sendmail.courier
		rm ${D}/usr/bin/rmail
		insinto /etc/mail
		doins ${FILESDIR}/mailer.conf
	else
		dosym /usr/bin/sendmail /usr/sbin/sendmail
	fi
}

pkg_config() {
	mailhost=`hostname`
	export mailhost

	domainname=`domainname`
	if [ "x$domainname" = "x(none)" ] ; then
		domainname=`echo ${mailhost} | sed -e "s/[^\.]*\.\(.*\)/\1/"`
	fi
	export domainname


	if [ ${ROOT} = "/" ] ; then
		file=${ROOT}/etc/courier/locals
		if [ ! -f ${file} ] ; then
			echo "localhost" > ${file};
			echo ${domainname} >> ${file};
		fi
		file=${ROOT}/etc/courier/esmtpacceptmailfor.dir/${domainname}
		if [ ! -f ${file} ] ; then
			echo ${domainname} > ${file}
			/usr/sbin/makeacceptmailfor
		fi

		file=${ROOT}/etc/courier/smtpaccess/${domainname}
		if [ ! -f ${file} ]
		then
			netstat -nr | grep "^[1-9]" | while read network gateway netmask rest
			do
				i=1
				net=""
				TIFS=${IFS}
				IFS="."
				for o in ${netmask}
				do
					if [ ${o} == "255" ]
					then
						[ "_${net}" == "_" ] || net="${net}."
						t=`echo ${network} | cut -d " " -f ${i}`
						net="${net}${t}"
					fi
					i=$((${i} + 1))
				done
				IFS=${TIFS}
				echo "doing configuration - relay control for the network ${net} !"
				echo "${net}	allow,RELAYCLIENT" >> ${file}
			done
			/usr/sbin/makesmtpaccess
		fi
	fi

	echo "creating cert for esmtpd-ssl:"
	/usr/sbin/mkesmtpdcert
	echo "creating cert for imapd-ssl:"
	/usr/sbin/mkpop3dcert
	echo "creating cert for pop3d-ssl:"
	/usr/sbin/mkimapdcert
}
