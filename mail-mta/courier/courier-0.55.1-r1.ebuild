# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-mta/courier/courier-0.55.1-r1.ebuild,v 1.6 2008/05/21 16:04:43 dev-zero Exp $

WANT_AUTOCONF="latest"
WANT_AUTOMAKE="latest"

inherit eutils flag-o-matic autotools

DESCRIPTION="An MTA designed specifically for maildirs"
[ -z "${PV/?.??/}" ] && SRC_URI="mirror://sourceforge/courier/${P}.tar.bz2"
[ -z "${PV/?.??.?/}" ] && SRC_URI="mirror://sourceforge/courier/${P}.tar.bz2"
[ -z "${SRC_URI}" ] && SRC_URI="http://www.courier-mta.org/beta/courier/${P%%_pre}.tar.bz2"
HOMEPAGE="http://www.courier-mta.org/"
S="${WORKDIR}/${P%%_pre}"

SLOT="0"
LICENSE="GPL-2"
# not in keywords due to missing dependencies: ~arm ~s390 ~ppc64
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~mips ~ppc ~sparc ~x86"
IUSE="postgres ldap mysql pam nls ipv6 spell fax crypt norewrite mailwrapper fam"

PROVIDE="virtual/mta
	 virtual/mda
	 virtual/imapd"

DEPEND="
	>=net-libs/courier-authlib-0.59
	>=dev-libs/openssl-0.9.6
	>=sys-libs/gdbm-1.8.0
	dev-libs/libpcre
	app-misc/mime-types
	fax? ( >=media-libs/netpbm-9.12 virtual/ghostscript >=net-dialup/mgetty-1.1.28 )
	pam? ( virtual/pam )
	mysql? ( virtual/mysql )
	ldap? ( >=net-nds/openldap-1.2.11 )
	postgres? ( virtual/postgresql-server )
	spell? ( virtual/aspell-dict )
	fam? ( virtual/fam )
	!mailwrapper? ( !virtual/mta )
	!virtual/imapd
	!mail-filter/maildrop"

RDEPEND="${DEPEND}
	dev-lang/perl
	sys-process/procps"

PDEPEND="mailwrapper? ( >=net-mail/mailwrapper-0.2 )
	pam? ( net-mail/mailbase )
	crypt? ( >=app-crypt/gnupg-1.0.4 )"

filter-flags '-fomit-frame-pointer'

src_unpack() {
	use fam || (
		ewarn "File Alteration Monitor (FAM) is disabled"
		ewarn "courier-imap will fall back to 60 second polls."
		ewarn 'add "fam" to your USE flags to build as usual'
		ebeep 4
		epause 4 )
	unpack ${A}
	cd "${S}"
	use norewrite && epatch "${FILESDIR}/norewrite.patch"
	use elibc_uclibc && sed -i -e 's:linux-gnu\*:linux-gnu\*\ \|\ linux-uclibc:' config.sub

	epatch "${FILESDIR}/pam-include.patch"

	# disable link to fam.
	epatch "${FILESDIR}/fam-disable-check.patch"
	cd "${S}/maildir"
	eautoreconf
}

src_compile() {
	local myconf
	myconf="`use_with ipv6` \
		`use_with ldap ldapaliasd` `use_enable ldap maildropldap`"

	use ldap && myconf="${myconf} --with-ldapconfig=/etc/courier/maildropldap.conf"
	use spell || myconf="${myconf} --without-ispell"

	myconf="${myconf} --enable-mimetypes=/etc/mime.types"

	myconf="${myconf} $(use_with fam)"

	einfo "Configuring courier: `echo ${myconf} | xargs echo`"

	econf \
		--prefix=/usr \
		--disable-root-check \
		--mandir=/usr/share/man \
		--sysconfdir=/etc/courier \
		--libexecdir=/usr/$(get_libdir)/courier \
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
		--cache-file="${S}/configuring.cache" \
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
	file="${1}" ; key="${2}" ; value="${3}" ; section="${4}"
	[ -z "${section}" ] && section="${2}"
	grep -q "${key}" "${file}" && elog "Changing ${file}: ${key} to ${value}"
	sed -i -e"/\#\#NAME: ${section}/,+20 s|${key}=.*|${key}=\"${value}\"|g" ${file}
}

set_maildir() {
	local f ; local files=$*
	origmaildir='Maildir'
	newmaildir='.maildir'
	for f in ${files} ; do
		grep -q "${origmaildir}" "${f}" && \
			elog "Changing ${origmaildir} in ${f} to ${newmaildir}"
		sed -i -e"/^[^\#]/ s/${origmaildir}/${newmaildir}/g" ${f}
	done
}

src_install() {
	local f
	einfo "Setting up maildirs in the account skeleton ..."
	diropts -m 755 -o root -g root
	dodir /etc/skel
	"${S}/maildir/maildirmake" "${D}/etc/skel/.maildir"
	keepdir /etc/skel/.maildir

	diropts -o mail -g mail
	keepdir /var/run/courier
	keepdir /var/lib/courier/tmp
	keepdir /var/lib/courier/msgs
	make install DESTDIR="${D}" || die "install"
	make install-configure || die "install-configure"

	for dir2keep in `(cd "${D}" && find ./var/lib/courier -type d)` ; do
		keepdir $dir2keep || die "failed running keepdir: $dir2keep"
	done

	newinitd "${FILESDIR}/courier-init-r1" courier
	use fam || sed -i -e's|^.*use famd$||g' "${D}/etc/init.d/courier"

	cd "${D}/etc/courier"
	insinto /etc/courier
	newins "${FILESDIR}/apache-sqwebmail.inc" apache-sqwebmail.inc

	if use pam ; then
		dodir /etc/pam.d
		rm imapd.authpam pop3d.authpam
		for f in *.authpam ; do mv "${f}" "${D}/etc/pam.d/${f%%.authpam}" ; done
	fi

	for f in *.dist ; do cp ${f} ${f%%.dist} ; done
	[ -e ldapaliasrc ] &&  ( chown root:0 ldapaliasrc ; chmod 400 ldapaliasrc )
	set_maildir courierd imapd imapd-ssl pop3d pop3d-ssl sqwebmaild *.dist

	( [ -e /etc/courier/sizelimit ] && cat /etc/courier/sizelimit || echo 0 ) \
		> "${D}/etc/courier/sizelimit"
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
	etc_courier_chg esmtpd ESMTPAUTH "LOGIN CRAM-MD5 CRAM-SHA1 CRAM-SHA256"
	etc_courier_chg esmtpd ESMTPAUTH_WEBADMIN "LOGIN CRAM-MD5 CRAM-SHA1 CRAM-SHA256"
	etc_courier_chg esmtpd ESMTPAUTH_TLS "PLAIN LOGIN CRAM-MD5 CRAM-SHA1 CRAM-SHA256" ESMTPAUTHINFOTLS
	etc_courier_chg esmtpd ESMTPAUTH_TLS_WEBADMIN "PLAIN LOGIN CRAM-MD5 CRAM-SHA1 CRAM-SHA256" ESMTPAUTHINFOTLS
	etc_courier_chg esmtpd-msa ESMTPDSTART YES
	etc_courier_chg esmtpd-msa AUTH_REQUIRED 1
	etc_courier_chg esmtpd-ssl ESMTPDSSLSTART YES
	etc_courier_chg esmtpd-ssl AUTH_REQUIRED 1
	etc_courier_chg imapd IMAPDSTART YES
	use fam && etc_courier_chg imapd IMAP_CAPABILITY "IMAP4rev1 UIDPLUS CHILDREN NAMESPACE THREAD=ORDEREDSUBJECT THREAD=REFERENCES SORT QUOTA AUTH=CRAM-MD5 AUTH=CRAM-SHA1 AUTH=CRAM-SHA256 IDLE"
	use fam || etc_courier_chg imapd IMAP_CAPABILITY "IMAP4rev1 UIDPLUS CHILDREN NAMESPACE THREAD=ORDEREDSUBJECT THREAD=REFERENCES SORT QUOTA AUTH=CRAM-MD5 AUTH=CRAM-SHA1 AUTH=CRAM-SHA256"
	etc_courier_chg imapd-ssl IMAPDSSLSTART YES
	etc_courier_chg pop3d POP3DSTART YES
	etc_courier_chg pop3d POP3AUTH "LOGIN CRAM-MD5 CRAM-SHA1 CRAM-SHA256"
	etc_courier_chg pop3d POP3AUTH_TLS "LOGIN PLAIN CRAM-MD5 CRAM-SHA1 CRAM-SHA256"
	etc_courier_chg pop3d-ssl POP3DSSLSTART YES

	# Fix for a sandbox violation on subsequential merges
	# - ticho@gentoo.org, 2005-07-10
	rm "${D}"/usr/sbin/{pop3d,imapd}{,-ssl}
	dosym /usr/share/courier/pop3d /usr/sbin/courier-pop3d
	dosym /usr/share/courier/pop3d-ssl /usr/sbin/courier-pop3d-ssl
	dosym /usr/share/courier/imapd /usr/sbin/courier-imapd
	dosym /usr/share/courier/imapd-ssl /usr/sbin/courier-imapd-ssl

	cd "${S}"
	cp imap/README README.imap
	use nls && cp unicode/README README.unicode
	dodoc AUTHORS BENCHMARKS COPYING* ChangeLog* INSTALL NEWS README* TODO courier/doc/*.txt
	dodoc tcpd/README.couriertls
	echo "See /usr/share/courier/htmldoc/index.html for docs in html format" \
		>> "${D}/usr/share/doc/${P}/README.htmldocs"

	insinto /usr/$(get_libdir)/courier/courier
	insopts -m 755 -o mail -g mail
	doins "${S}/courier/webmaild"
	insinto /etc/courier/webadmin
	insopts -m 400 -o mail -g mail
	doins "${FILESDIR}/password.dist"

	# avoid name collisions in /usr/sbin, make webadmin match
	cd "${D}/usr/sbin"
	for f in imapd imapd-ssl pop3d pop3d-ssl ; do mv ${f} courier-${f} ; done
	sed -i -e 's:\$sbindir\/imapd:\$sbindir\/courier-imapd:g' \
		-e 's:\$sbindir\/imapd-ssl:\$sbindir\/courier-imapd-ssl:g' \
		"${D}/usr/share/courier/courierwebadmin/admin-40imap.pl" \
		|| ewarn "failed to fix webadmin"
	sed -i -e 's:\$sbindir\/pop3d:\$sbindir\/courier-pop3d:g' \
		-e 's:\$sbindir\/pop3d-ssl:\$sbindir\/courier-pop3d-ssl:g' \
		"${D}/usr/share/courier/courierwebadmin/admin-45pop3.pl" \
		|| ewarn "failed to fix webadmin"

	if use mailwrapper ; then
		mv "${D}/usr/bin/sendmail" "${D}/usr/bin/sendmail.courier"
		mv "${D}/usr/bin/rmail" "${D}/usr/bin/rmail.courier"
		mv "${D}/usr/bin/mailq" "${D}/usr/bin/mailq.courier"

		mv "${D}/usr/share/man/man1/sendmail.1" \
			"${D}/usr/share/man/man1/sendmail-courier.1"
		mv "${D}/usr/share/man/man1/mailq.1" \
			"${D}/usr/share/man/man1/mailq-courier.1"
		mv "${D}/usr/share/man/man1/rmail.1" \
			"${D}/usr/share/man/man1/rmail-courier.1"

		insinto /etc/mail
		doins "${FILESDIR}/mailer.conf"
	else
		dosym /usr/bin/sendmail /usr/sbin/sendmail
	fi
}

src_test() {
	addpredict /
	vecho ">>> Test phase [check]: ${CATEGORY}/${PF}"
	if hasq userpriv ${FEATURES} ; then
		if ! emake -j1 check; then
			hasq test ${FEATURES} && die "Make check failed. See above for details."
			hasq test ${FEATURES} || eerror "Make check failed. See above for details."
		fi
	else
		hasq test ${FEATURES} && eerror "Make check needs FEATURES="userpriv" to work."
	fi
	SANDBOX_PREDICT="${SANDBOX_PREDICT%:/}"
}

pkg_postinst() {
	use fam && elog "fam daemon is needed for courier-imapd" \
		|| ewarn "courier was built without fam support"

	# fix for bug #99334
	elog "Courier's sendmail is not suid by default, therefore non-root users can't send"
	elog "mail using sendmail. If you need this to work, you should set sendmail suid."
	elog "See also: http://www.courier-mta.org/install.html#suid"
}

pkg_config() {
	mailhost=`hostname`
	export mailhost

	domainname=`domainname`
	if [ "x$domainname" = "x(none)" ] ; then
		domainname=`echo ${mailhost} | sed -e "s/[^\.]*\.\(.*\)/\1/"`
	fi
	export domainname

	if [ "${ROOT}" = "/" ] ; then
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
