# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/courier-imap/courier-imap-3.0.2.ebuild,v 1.5 2004/03/26 18:53:20 gmsoft Exp $

DESCRIPTION="An IMAP daemon designed specifically for maildirs"
SRC_URI="mirror://sourceforge/courier/${P}.tar.bz2"
HOMEPAGE="http://www.courier-mta.org/"
KEYWORDS="x86 ~ppc sparc ~mips ~alpha hppa amd64"
LICENSE="GPL-2"
SLOT="0"
IUSE="gdbm ldap berkdb mysql pam nls postgres fam"
PROVIDE="virtual/imapd"
# not compatible with >=sys-libs/db-4
RDEPEND="virtual/glibc
	>=dev-libs/openssl-0.9.6
	pam? ( >=sys-libs/pam-0.75 )
	berkdb? ( =sys-libs/db-3* )
	gdbm? ( >=sys-libs/gdbm-1.8.0 )
	mysql? ( >=dev-db/mysql-3.23.36 )
	ldap? ( >=net-nds/openldap-1.2.11 )
	postgres? ( >=dev-db/postgresql-7.2 )
	>=dev-tcltk/expect-5.33.0
	fam? ( app-admin/fam )"
DEPEND="${RDEPEND}
	>=sys-apps/sed-4
	dev-lang/perl
	sys-apps/procps"

#userpriv breaks linking against vpopmail
RESTRICT="nouserpriv nomirror"

VPOPMAIL_INSTALLED=
VPOPMAIL_DIR=
export VPOPMAIL_INSTALLED VPOPMAIL_DIR

vpopmail_setup() {
	VPOPMAIL_DIR=`grep ^vpopmail /etc/passwd 2>/dev/null | cut -d: -f6`
	VPOPMAIL_INSTALLED=
	if has_version 'net-mail/vpopmail' && [ -n "${VPOPMAIL_DIR}" ] && [ -f "${VPOPMAIL_DIR}/etc/lib_deps" ]; then
		VPOPMAIL_INSTALLED=1
	else
		VPOPMAIL_DIR=
	fi
}

src_unpack() {
	unpack ${A}

	# patch to fix db4.0 detection as db4.1
	# bug #27517, patch was sent upstream, but was ignored :-(
	EPATCH_OPTS="${EPATCH_OPTS} -p1 -d ${S}" \
	epatch ${FILESDIR}/${PN}-3.0.2-db40vs41.patch

	cd ${S}
	# explicitly use db3 over db4
	if use berkdb; then
		sed -i -e 's,-ldb,-ldb-3.2,g' configure
		sed -i -e 's,-ldb,-ldb-3.2,g' bdbobj/configure
		sed -i -e 's#s,@CFLAGS@,$CFLAGS,#s,@CFLAGS@,-I/usr/include/db3 $CFLAGS,#' configure
		sed -i -e 's#s,@CFLAGS@,$CFLAGS,#s,@CFLAGS@,-I/usr/include/db3 $CFLAGS,#' bdbobj/configure
	fi

	# Fix a bug with where the password change module is installed. Upstream bug in configure file.
	sed -i -e 's,--with-authchangepwdir=/var/tmp/dev/null,--with-authchangepwdir=$libexecdir/authlib,' configure

	epatch ${FILESDIR}/${PN}-3.0.2-removerpm.patch
	cd ${S}/authlib
	aclocal
	autoconf
}

src_compile() {
	vpopmail_setup

	local myconf
	myconf="${myconf} `use_with pam authpam`"
	myconf="${myconf} `use_with ldap authldap`"
	myconf="${myconf} `use_with mysql authmysql`"
	myconf="${myconf} `use_with postgres authpostgresql`"
	# the --with-ipv6 is broken
	#myconf="${myconf} --with-ipv6"
	use ipv6 || myconf="${myconf} --without-ipv6"
	use berkdb \
		&& myconf="${myconf} --with-db=db" \
		|| myconf="${myconf} --with-db=gdbm"

	if [ -n "${VPOPMAIL_INSTALLED}" ]; then
		einfo "vpopmail found"
		myconf="${myconf} --with-authvchkpw"
		tmpLDFLAGS="`cat ${VPOPMAIL_DIR}/etc/lib_deps`"
		LDFLAGS="${LDFLAGS} ${tmpLDFLAGS}"
		CFLAGS="${CFLAGS} `cat ${VPOPMAIL_DIR}/etc/inc_deps`"
	else
		einfo "vpopmail not found"
		myconf="${myconf} --without-authvchkpw"
	fi

	if use nls && [ -z "$ENABLE_UNICODE" ]; then
		myconf="${myconf} --enable-unicode"
	elif use nls; then
		myconf="${myconf} --enable-unicode=$ENABLE_UNICODE"
	else
		myconf="${myconf} --disable-unicode"
	fi

	use debug && myconf="${myconf} debug=true"

	local cachefile
	cachefile=${WORKDIR}/config.cache
	rm -f ${cachefile}

	# fix for bug #21330
	CFLAGS=`echo ${CFLAGS} | xargs`
	CXXFLAGS=`echo ${CXXFLAGS} | xargs`
	LDFLAGS=`echo ${LDFLAGS} | xargs`

	# fix for bug #27528
	# they really should use a better way to detect redhat
	myconf="${myconf} --without-redhat"

	# bug #29879 - FAM support
	if has_version 'app-admin/fam' && [ -z "`use fam`" ]; then
		ewarn "FAM will be detected by the package and support will be enabled"
		ewarn "The package presently provides no way to disable fam support if you don't want it"
	fi

	# fix for non-x86 platforms, bug #38606
	# courier-imap doesn't respect just --host=$CHOST without --build
	[ -z "${CBUILD}" ] && export CBUILD="${CHOST}"

	# Do the actual build now
	LDFLAGS="${LDFLAGS}" econf \
		--disable-root-check \
		--bindir=/usr/sbin \
		--mandir=/usr/share/man \
		--sysconfdir=/etc/courier-imap \
		--libexecdir=/usr/lib/courier-imap \
		--localstatedir=/var/lib/courier-imap \
		--enable-workarounds-for-imap-client-bugs \
		--with-authdaemonvar=/var/lib/courier-imap/authdaemon \
		--cache-file=${cachefile} \
		${myconf}

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
	vpopmail_setup

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
		echo -e '#Put any program for ${PRERUN} here' >> ${service}
		echo 'PRERUN='>> ${service}
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

	dosym /usr/sbin/courierlogger /usr/lib/courier-imap/courierlogger

	exeinto /etc/init.d
		newexe ${FILESDIR}/authdaemond.rc6 authdaemond
		newexe ${FILESDIR}/courier-imapd.rc6 courier-imapd
		newexe ${FILESDIR}/courier-imapd-ssl.rc6 courier-imapd-ssl
		newexe ${FILESDIR}/courier-pop3d.rc6 courier-pop3d
		newexe ${FILESDIR}/courier-pop3d-ssl.rc6 courier-pop3d-ssl

	exeinto /usr/lib/courier-imap
		newexe ${FILESDIR}/gentoo-imapd-1.7.3-r1.rc gentoo-imapd.rc
		newexe ${FILESDIR}/gentoo-imapd-ssl-1.7.3-r1.rc gentoo-imapd-ssl.rc
		newexe ${FILESDIR}/gentoo-pop3d-1.7.3-r1.rc gentoo-pop3d.rc
		newexe ${FILESDIR}/gentoo-pop3d-ssl-1.7.3-r1.rc gentoo-pop3d-ssl.rc

	local authmods
	authmods="authsystem.passwd authcram authshadow authuserdb authpwd authtest authinfo authmksock authcustom authdaemontest"
	use mysql && authmods="${authmods} authmysql"
	use postgres && authmods="${authmods} authpgsql"
	use pam && authmods="${authmods} authpam"
	use ldap && authmods="${authmods} authldap"
	[ -n "${VPOPMAIL_INSTALLED}" ] && authmods="${authmods} authvchkpw"
	exeinto /usr/lib/courier-imap/authlib
	for i in ${authmods}; do
		[ -f ${S}/authlib/${i} ] && doexe ${S}/authlib/${i}
	done;

	dodir /usr/bin
	mv ${D}/usr/sbin/maildirmake ${D}/usr/bin/maildirmake

	dodoc ${S}/imap/ChangeLog

	keepdir /var/lib/courier-imap/authdaemon

}

pkg_postinst() {
	# rebuild init deps to include deps on authdaemond
	/etc/init.d/depscan.sh
	einfo "Make sure to change /etc/courier-imap/authdaemond.conf if"
	einfo "you would like to use something other than the"
	einfo "authdaemond.plain authenticator"
}
