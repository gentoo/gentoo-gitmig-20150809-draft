# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /home/cvsroot/gentoo-x86/net-mail/courier/courier-0.41.0.ebuild

inherit flag-o-matic eutils

filter-flags -fomit-frame-pointer
filter-flags -funroll-loops

DESCRIPTION="An MTA designed specifically for maildirs"
SRC_URI="mirror://sourceforge/courier/${P}.tar.bz2"
HOMEPAGE="http://www.courier-mta.org/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 -ppc -sparc"
IUSE="gdbm tcltk postgres ldap berkdb mysql pam nls tcltk ipv6 spell fax crypt"

PROVIDE="virtual/mta
	 virtual/imapd"

RDEPEND="virtual/glibc
	>=dev-tcltk/expect-5.33.0
	>=dev-libs/openssl-0.9.6
	crypt? ( >=app-crypt/gnupg-1.0.4 )
	fax? (	>=media-libs/netpbm-9.12
		>=app-text/ghostscript-7.05.5
		>=net-dialup/mgetty-1.1.28 )
	pam? ( >=sys-libs/pam-0.75 )
	berkdb? ( >=sys-libs/db-3.2 )
	gdbm? ( >=sys-libs/gdbm-1.8.0 )
	mysql? ( >=dev-db/mysql-3.23.36 )
	ldap? ( >=net-nds/openldap-1.2.11 )
	postgres? ( >=dev-db/postgresql-7.1.3 )
	tcltk? ( >=dev-tcltk/expect-5.33.0 )
	spell? ( virtual/aspell-dict )"
DEPEND="${RDEPEND}
	app-admin/fam-oss
	dev-lang/perl
	sys-apps/procps"

src_compile() {
	local myconf
	use pam || myconf="${myconf} --without-authpam"
	use ldap || myconf="${myconf} --without-authldap"
	use mysql || myconf="${myconf} --without-authmysql"
	use postgres || myconf="${myconf} --without-authpostgresql"
	use berkdb \
                && myconf="${myconf} --with-db=db" \
                || myconf="${myconf} --with-db=gdbm"
	use ipv6 || myconf="${myconf} --without-ipv6"
	use spell \
		&& myconf="${myconf} --with-ispell" \
		|| myconf="${myconf} --without-ispell"

	if [ -f /var/vpopmail/etc/lib_deps ]; then
                myconf="${myconf} --with-authvchkpw"
        else
                myconf="${myconf} --without-authvchkpw"
        fi
	
	#
	# 1. If nls is enabled and ENABLE_UNICODE is not empty...
	#    enable the specified unicode sets
	# 2. If nls is enabled and no unicode sets are specified, 
	#    enable them all
	# 3. If nls is disabled, disable unicode sets
	#
	if use nls && [ ! -z "$ENABLE_UNICODE" ]; then
                myconf="${myconf} --enable-unicode=$ENABLE_UNICODE"
        elif use nls; then
                myconf="${myconf} --enable-unicode"
        else
                myconf="${myconf} --disable-unicode"
        fi

	myconf="${myconf} debug=true"	

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
		--disable-autorenamesent \
		--enable-mimetypes=/etc/apache/conf/mime.types \
		--enable-workarounds-for-imap-client-bugs \
		--host=${CHOST} ${myconf} || die "bad ./configure"

	emake || die "Compile problem"
}

chg_cfg() {
	file=${1}
	key=${2}
	value=${3}

	echo "changing ${file}: ${key} to ${value}"
	sed -e "/\#\#NAME: ${key}/,+20 s|${key}=.*|${key}=\"${value}\"|g" ${file} > ${file}.tmp && chmod --reference ${file} ${file}.tmp && mv ${file}.tmp ${file}
	rm -f ${f}.tmp 1>/dev/null 2>&1
}
	
set_mime() {
	local files=$*

	chk_badmime='##NAME: BOFHBADMIME:0'
	pos_badmime='##NAME: NOADDMSGID:0'
	ins_badmime='\
##NAME: BOFHBADMIME:0\
#\
# set BOFHBADMIME\
#   to \"reject\" to return mail with invalid MIME header\
#   to \"wrap\" to wrap mail with invalid MIME header in an attachmant\
#   to \"accept\" to pass mail with invalid MIME header untouched\
\
BOFHBADMIME=accept\
'

	local f
	for f in ${files}
	do
		if ! grep -q "${chk_badmime}" ${f}
		then
			echo "adding parameter ${chk_badmime} to ${f}"
			sed -e"/${pos_badmime}/ i ${ins_badmime}" ${f} > ${f}.tmp && chmod --reference ${f} ${f}.tmp && mv -f ${f}.tmp ${f}
			rm -f ${f}.tmp 1>/dev/null 2>&1
		fi
	done
}

set_maildir() {
	local files=$*

	origmaildir='Maildir'
	newmaildir='.maildir'

	local f
	for f in ${files}
	do	
		echo "changing ${origmaildir} in ${f} to ${newmaildir}"
		sed -e"/^[^\#]/ s/${origmaildir}/${newmaildir}/g" ${f} > ${f}.tmp && chmod --reference ${f} ${f}.tmp && mv -f ${f}.tmp ${f}
		rm -f ${f}.tmp 1> /dev/null 2>&1
	done
}						

src_install() {
	dodir /var/lib/courier
	dodir /etc/pam.d
	make install DESTDIR=${D} || die
	# fix bug #15873 bad owner on /var/run/courier
	diropts -o mail -g mail
	keepdir /var/run/courier

	local f
	cd ${D}/etc/courier
	mv imapd.authpam imap.authpam
	mv pop3d.authpam pop3.authpam
	for f in *.authpam
	do
		cp "${f}" "${D}/etc/pam.d/${f%%.authpam}"
	done

	exeinto /etc/init.d
	# we install the new single init script as courier
	newexe ${FILESDIR}/courier-init courier
	# and install the old main init script as courier-old
	newexe ${FILESDIR}/courier courier-old
	newexe ${FILESDIR}/courier-authdaemond courier-authdaemond
	newexe ${FILESDIR}/courier-ldapaliasd courier-ldapaliasd
	newexe ${FILESDIR}/courier-mta courier-mta
	newexe ${FILESDIR}/courier-esmtpd courier-esmtpd
	newexe ${FILESDIR}/courier-esmtpd-ssl courier-esmtpd-ssl
	newexe ${FILESDIR}/courier-esmtpd-msa courier-esmtpd-msa
	newexe ${FILESDIR}/courier-imapd courier-imapd
	newexe ${FILESDIR}/courier-imapd-ssl courier-imapd-ssl
	newexe ${FILESDIR}/courier-pop3d-ssl courier-pop3d-ssl
	newexe ${FILESDIR}/courier-pop3d courier-pop3d
	newexe ${FILESDIR}/courier-filterd courier-filterd

	einfo "Setting up maildirs by default in the account skeleton ..."
	diropts -m 755 -o root -g root
	insinto /etc/skel
	${D}/usr/bin/maildirmake ${D}/etc/skel/.maildir
	newins ${FILESDIR}/dot_courier .courier
	fperms 644 /etc/skel/.courier
	${D}/usr/bin/maildirmake ${D}/var/spool/mail/.maildir
	insinto /etc/courier
	newins ${FILESDIR}/bofh bofh
	newins ${FILESDIR}/locallowercase locallowercase
	newins ${FILESDIR}/sizelimit sizelimit
	newins ${FILESDIR}/apache-sqwebmail.inc apache-sqwebmail.inc
	
	touch ${D}/var/lib/courier/webmail-logincache/.keep
	touch ${D}/var/lib/courier/tmp/broken/.keep
	touch ${D}/var/lib/courier/msgs/.keep
	touch ${D}/var/lib/courier/msgq/.keep
	touch ${D}/var/lib/courier/filters/.keep
	touch ${D}/var/lib/courier/faxtmp/.keep
	touch ${D}/var/lib/courier/calendar/public/.keep
	touch ${D}/var/lib/courier/calendar/private/.keep
	touch ${D}/var/lib/courier/calendar/localcache/.keep
	touch ${D}/var/lib/courier/calendar/.keep
	touch ${D}/var/lib/courier/allfilters/.keep

	dodoc AUTHORS BENCHMARKS ChangeLog* NEWS README TODO

	# See bug #10574
	# file which describes the webadmin password file
	insinto /etc/courier/webadmin
	insopts -m 400 -o mail -g mail
	doins ${FILESDIR}/password.dist

	# fixes bug#25028 courier doesn't symlink sendmail to /usr/sbin
	dosym /usr/bin/sendmail /usr/sbin/sendmail

}

pkg_preinst() {
	# avoid name collisions in /usr/sbin
	local y
	cd ${D}/usr/share/courier
	set_maildir imapd imapd-ssl pop3d pop3d-ssl

	cd ${D}/usr/sbin
	for y in imapd imapd-ssl pop3d pop3d-ssl
	do
		mv ${y} courier-${y}
	done
	
	cd ${D}/etc/courier
	for y in *.dist
	do
		cp ${y} ${y%%.dist}
	done
	touch esmtproutes
	touch backuprelay
	touch maildroprc
	chown mail:root ldapaliasrc
	chg_cfg imapd-ssl COURIERTLS /usr/bin/couriertls
	chg_cfg authdaemonrc authmodulelist authpam
	chg_cfg authdaemonrc version authdaemond.plain
	set_mime esmtpd esmtpd-ssl esmtpd-msa
	set_maildir courierd
}

pkg_postinst() {
	cd ${S}
	make install-configure

	# fixes bug #15873 for upgrades, should be able to yank this sometime in 
	# the future
	chown --recursive mail.mail ${ROOT}/var/run/courier

	# need to do this for new installs to be able to start courier 
        # without having to run rc-update ...
        /etc/init.d/depscan.sh

	einfo "The following command will setup courier for you system:"
	einfo "ebuild /var/db/pkg/${CATEGORY}/${PN}-${PV}/${PN}-${PV}.ebuild config"
	echo
	einfo "To enable webmail/webadmin, run the following commands:"
	einfo "$ echo \"Include /etc/courier/apache-sqwebmail.inc\" >> /etc/apache*/conf/apache.conf"
	einfo "$ chmod a+rx /usr/lib/courier/courier/webmail"
	einfo "Then visit: http(s)://localhost/courier/webmail"

	ewarn "The init scripts for courier have changed."
	ewarn "There is now one init script (/etc/init.d/courier). The rest"
	ewarn "are obsolete. You can remove /etc/init.d/courier-*. You also"
	ewarn "need to edit the following files in /etc/courier to enable"
	ewarn "the different services:"
	ewarn "imapd"
	ewarn "pop3d"
	ewarn "pop3d-ssl"
	ewarn "esmtpd"
	ewarn "imapd-ssl"
	ewarn "esmtpd-msa"
	ewarn "esmtpd-ssl"
	ewarn "hint: look for a line at the bottom of the file that looks like so"
	ewarn "ESMTPDSTART=NO"
	ewarn "and change it to YES for the services that you use"
	echo -ne "\a" ; sleep 1
	echo -ne "\a" ; sleep 1
	echo -ne "\a" ; sleep 1
	echo -ne "\a" ; sleep 1
	echo -ne "\a" ; sleep 1
}

pkg_config() {
	mailhost=`hostname`
	export mailhost
	
	domainname=`echo ${mailhost} | sed -e "s/[^\.]*\.\(.*\)/\1/"`
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
