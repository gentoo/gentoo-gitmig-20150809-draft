# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/courier-imap/courier-imap-1.7.0.ebuild,v 1.5 2003/04/11 22:44:20 liquidx Exp $

DESCRIPTION="An IMAP daemon designed specifically for maildirs"
SRC_URI="http://twtelecom.dl.sourceforge.net/sourceforge/courier/${P}.tar.bz2"
HOMEPAGE="http://www.courier-mta.org/"
KEYWORDS="x86 ~ppc ~sparc "
LICENSE="GPL-2"
SLOT="0"
IUSE="ipv6 gdbm tcltk ldap berkdb mysql pam nls postgres"
PROVIDE="virtual/imapd"
# not compatible with >=sys-libs/db-4
RDEPEND="virtual/glibc
	>=dev-libs/openssl-0.9.6
	pam? ( >=sys-libs/pam-0.75 )
	berkdb? ( =sys-libs/db-3* )
	gdbm? ( >=sys-libs/gdbm-1.8.0 )
	mysql? ( >=dev-db/mysql-3.23.36 )
	ldap? ( >=net-nds/openldap-1.2.11 )
	tcltk? ( >=dev-tcltk/expect-5.33.0 )
	postgres? ( >=dev-db/postgresql-7.2 )"
DEPEND="${RDEPEND} dev-lang/perl sys-apps/procps"

inherit flag-o-matic
filter-flags -funroll-loops
filter-flags -fomit-frame-pointer

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

	VPOPMAIL_DIR=`cat /etc/passwd | grep ^vpopmail | cut -d: -f6`
	if [ -f ${VPOPMAIL_DIR}/etc/lib_deps ]; then
		myconf="${myconf} --with-authvchkpw"
	else
		myconf="${myconf} --without-authvchkpw"
	fi

	if use nls && [ ! -z "$ENABLE_UNICODE" ]; then
		myconf="${myconf} --enable-unicode"
	elif use nls; then
		myconf="${myconf} --enable-unicode=$ENABLE_UNICODE"
	else
		myconf="${myconf} --disable-unicode"
	fi

	myconf="${myconf} debug=true"

	./configure \
		--prefix=/usr \
		--bindir=/usr/sbin \
		--disable-root-check \
		--mandir=/usr/share/man \
		--sysconfdir=/etc/courier-imap \
		--libexecdir=/usr/lib/courier-imap \
		--localstatedir=/var/lib/courier-imap \
		--enable-workarounds-for-imap-client-bugs \
		--with-authdaemonvar=/var/lib/courier-imap/authdaemon \
		--host=${CHOST} ${myconf} || die "bad ./configure"

	# change the pem file location..
	cp imap/imapd-ssl.dist imap/imapd-ssl.dist.old
	sed -e "s:^\(TLS_CERTFILE=\).*:\1/etc/courier-imap/imapd.pem:" \
		imap/imapd-ssl.dist.old > imap/imapd-ssl.dist

	cp imap/pop3d-ssl.dist imap/pop3d-ssl.dist.old
	sed -e "s:^\(TLS_CERTFILE=\).*:\1/etc/courier-imap/pop3d.pem:" \
		imap/pop3d-ssl.dist.old > imap/pop3d-ssl.dist

	emake || die "compile problem"
}

src_install() {
	dodir /var/lib/courier-imap /etc/pam.d
	make install DESTDIR=${D} || die

	# avoid name collisions in /usr/sbin wrt imapd and pop3d
	cd ${D}/usr/sbin
	for name in imapd pop3d
	do
		mv ${name} "courier-${name}"
	done

	# hack /usr/lib/courier-imap/foo.rc to use ${MAILDIR} instead of
	# 'Maildir', and to use /usr/sbin/courier-foo names.
	cd ${D}/usr/lib/courier-imap
	local service
	for service in imapd pop3d
	do
		local type
		for type in "" "-ssl"
		do
			local file
			file="${service}${type}.rc"
			cp ${file} ${file}.orig
			sed -e 's/Maildir/${MAILDIR}/' \
			    -e "s/\/usr\/sbin\/${service}/\/usr\/sbin\/courier-${service}/" \
				${file}.orig > ${file}
		done
	done

	cd ${D}/etc/courier-imap
	local x
	for x in pop3d pop3d-ssl imapd imapd-ssl authdaemonrc
	do
		mv ${x}.dist ${x}
	done
	
	insinto /etc/courier-imap
	doins ${FILESDIR}/authdaemond.conf

	# add a value for ${MAILDIR} to /etc/courier-imap/imapd
	for service in imapd pop3d
	do
		echo -e '\n#Hardwire a value for ${MAILDIR}' >> ${service}
		echo 'MAILDIR=.maildir' >> ${service}
	done

	cd ${D}/usr/sbin
	for x in *
	do
		if [ -L ${x} ]
		then
			rm ${x}
		fi
	done

	cd ../share
	mv * ../sbin
        mv ../sbin/man .
	cd ..

	rm -f ${D}/usr/sbin/mkimapdcert ${D}/usr/sbin/mkpop3dcert
	exeinto /usr/sbin 
		doexe ${FILESDIR}/mkimapdcert ${FILESDIR}/mkpop3dcert

 	exeinto /etc/init.d
		newexe ${FILESDIR}/authdaemond.rc6 authdaemond
		newexe ${FILESDIR}/courier-imapd.rc6 courier-imapd
		newexe ${FILESDIR}/courier-imapd-ssl.rc6 courier-imapd-ssl
		newexe ${FILESDIR}/courier-pop3d.rc6 courier-pop3d
		newexe ${FILESDIR}/courier-pop3d-ssl.rc6 courier-pop3d-ssl

	exeinto /usr/lib/courier-imap
		newexe ${FILESDIR}/gentoo-imapd-1.6.1.rc gentoo-imapd.rc
		newexe ${FILESDIR}/gentoo-imapd-ssl-1.6.1.rc gentoo-imapd-ssl.rc
		newexe ${FILESDIR}/gentoo-pop3d-1.6.1.rc gentoo-pop3d.rc
		newexe ${FILESDIR}/gentoo-pop3d-ssl-1.6.1.rc gentoo-pop3d-ssl.rc

	dodir /usr/bin
	mv ${D}/usr/sbin/maildirmake ${D}/usr/bin/maildirmake

	dodoc ${S}/imap/ChangeLog

}

pkg_postinst() {
	# rebuild init deps to include deps on authdaemond
	/etc/init.d/depscan.sh
	echo
	einfo "Make sure to change /etc/courier-imap/authdaemond.conf if"
	einfo "you would like to use something other than the"
	einfo "authdaemond.plain authenticator"
	echo
}
