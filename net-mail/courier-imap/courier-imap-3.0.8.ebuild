# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/courier-imap/courier-imap-3.0.8.ebuild,v 1.27 2008/05/21 18:57:42 dev-zero Exp $

inherit eutils

DESCRIPTION="An IMAP daemon designed specifically for maildirs"
HOMEPAGE="http://www.courier-mta.org/"
SRC_URI="mirror://sourceforge/courier/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ~ppc ~ppc64 s390 sparc x86"
IUSE="fam berkdb gdbm debug ipv6 ldap mysql nls pam postgres selinux"
#userpriv breaks linking against vpopmail
RESTRICT="userpriv"

RDEPEND="virtual/libc
	>=dev-libs/openssl-0.9.6
	pam? ( >=sys-libs/pam-0.75 )
	berkdb? ( sys-libs/db )
	gdbm? ( >=sys-libs/gdbm-1.8.0 )
	mysql? ( virtual/mysql )
	ldap? ( >=net-nds/openldap-1.2.11 )
	postgres? ( >=virtual/postgresql-server-7.2 )
	>=dev-tcltk/expect-5.33.0
	fam? ( virtual/fam )
	selinux? ( sec-policy/selinux-courier-imap )"
DEPEND="${RDEPEND}
	>=sys-apps/sed-4
	dev-lang/perl
	sys-process/procps
	!mail-mta/courier"
RDEPEND="${RDEPEND}
	!virtual/imapd"

PROVIDE="virtual/imapd"

pkg_setup() {
	if ! use berkdb && ! use gdbm; then
		echo
		eerror "either 'berkdb' or 'gdbm' USE flag is required."
		eerror "please add it to '/etc/make.conf' or '/etc/portage/package.use'"
		eerror "'man 5 portage' for correct syntax usage for '/etc/postage/package.use'"
		echo
		die "required USE flag is missing."
	fi
}

vpopmail_setup() {
	VPOPMAIL_INSTALLED=
	VPOPMAIL_DIR=
	export VPOPMAIL_INSTALLED VPOPMAIL_DIR
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

	cd ${S}
	# bug #48838. Patch to enable/disable FAM support.
	# 20 Aug 2004; langthang@gentoo.org.
	# This new patch should fix bug #51540. fam USE flag is not needed for shared folder support.
	epatch ${FILESDIR}/${P}-disable-fam-configure.in.patch || die "patch failed"

	# These patches should fix problem detecting Berkeley DB.
	# We now can compile with db4 support.
	epatch ${FILESDIR}/${P}-db4-bdbobj_configure.in.patch || die "patch failed"
	epatch ${FILESDIR}/${P}-db4-configure.in.patch || die "patch failed"

	export WANT_AUTOCONF="2.5"
	ebegin "Recreating configure"
	autoconf || \
		die "recreate configure failed"
	eend $?

	cd ${S}/maildir
	ebegin "Recreating maildir/configure"
	autoconf || \
		die "recreate configure failed"
	eend $?

	cd ${S}/bdbobj
	ebegin "Recreating bdbobj/configure"
		autoconf || \
		die "recreate configure failed"
	eend $?
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

	# 19 Aug 2004; langthang@gentoo.org
	# default to gdbm if both berkdb and gdbm present.
	if use berkdb; then
		if use gdbm; then
			einfo "build with GDBM support."
			myconf="${myconf} --with-db=gdbm"
		else
			einfo "build with Berkeley DB support."
			myconf="${myconf} --with-db=db"
		fi
	else
		einfo "build with GDBM support."
		myconf="${myconf} --with-db=gdbm"
	fi

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
	CFLAGS="`echo ${CFLAGS} | xargs`"
	CXXFLAGS="`echo ${CXXFLAGS} | xargs`"
	LDFLAGS="`echo ${LDFLAGS} | xargs`"

	# fix for bug #27528
	# they really should use a better way to detect redhat
	myconf="${myconf} --without-redhat"

	# bug #29879 - FAM support
	#if has_version 'virtual/fam' && ! use fam; then
	#	ewarn "FAM will be detected by the package and support will be enabled"
	#	ewarn "The package presently provides no way to disable fam support if you don't want it"
	#fi
	myconf="${myconf} `use_with fam`"

	# fix for non-x86 platforms, bug #38606
	# courier-imap doesn't respect just --host=$CHOST without --build
	[ -z "${CBUILD}" ] && export CBUILD="${CHOST}"

	# Do the actual build now
	LDFLAGS="${LDFLAGS} " econf \
		--disable-root-check \
		--bindir=/usr/sbin \
		--mandir=/usr/share/man \
		--sysconfdir=/etc/courier-imap \
		--libexecdir=/usr/lib/courier-imap \
		--localstatedir=/var/lib/courier-imap \
		--enable-workarounds-for-imap-client-bugs \
		--with-authdaemonvar=/var/lib/courier-imap/authdaemon \
		--cache-file=${cachefile} \
		${myconf} || die "econf failed"

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
	newins ${FILESDIR}/authdaemond.conf-3.0.4-r1 authdaemond.conf

	# add a value for ${MAILDIR} to /etc/courier-imap/imapd
	for service in imapd pop3d
	do
		echo -e '\n#Hardwire a value for ${MAILDIR}' >> ${service}
		echo 'MAILDIR=.maildir' >> ${service}
		echo 'MAILDIRPATH=.maildir' >> ${service}
		echo -e '#Put any program for ${PRERUN} here' >> ${service}
		echo 'PRERUN='>> ${service}
	done
	# upstream has an extra setting of MAILDIRPATH (it's already in the base files)
	for service in imapd-ssl pop3d-ssl
	do
		echo -e '\n#Hardwire a value for ${MAILDIR}' >> ${service}
		echo 'MAILDIRPATH=.maildir' >> ${service}
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
		newexe ${FILESDIR}/authdaemond-3.0.4-r1 authdaemond
		newexe ${FILESDIR}/courier-imapd.rc6 courier-imapd
		newexe ${FILESDIR}/courier-imapd-ssl.rc6-3.0.5 courier-imapd-ssl
		newexe ${FILESDIR}/courier-pop3d.rc6 courier-pop3d
		newexe ${FILESDIR}/courier-pop3d-ssl.rc6-3.0.5 courier-pop3d-ssl

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

	keepdir /var/lib/courier-imap/authdaemon

	# bug #45953, more docs
	cd ${S}
	dohtml -r ${S}/*
	dodoc ${S}/{00README.NOW.OR.SUFFER,AUTHORS,INSTALL,NEWS,README,ChangeLog}
	docinto imap
	dodoc ${S}/imap/{ChangeLog,BUGS,BUGS.html,README}
	docinto maildir
	dodoc ${S}/maildir/{AUTHORS,INSTALL,README.maildirquota.txt,README.sharedfolders.txt}
	docinto tcpd
	dodoc ${S}/tcpd/README.couriertls
}

pkg_postinst() {
	# rebuild init deps to include deps on authdaemond
	/etc/init.d/depscan.sh
	elog "Make sure to change /etc/courier-imap/authdaemond.conf if"
	elog "you would like to use something other than the"
	elog "authdaemond.plain authenticator"
}

src_test() {
	ewarn "make check not supported by package due to"
	ewarn "--enable-workarounds-for-imap-client-bugs option."
}
