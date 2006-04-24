# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/courier-authlib/courier-authlib-0.58.ebuild,v 1.9 2006/04/24 17:24:35 kumba Exp $

inherit eutils gnuconfig flag-o-matic

DESCRIPTION="courier authentication library"
[ -z "${PV/?.??/}" ] && SRC_URI="mirror://sourceforge/courier/${P}.tar.bz2"
[ -z "$SRC_URI" ] && SRC_URI="http://www.courier-mta.org/beta/courier-authlib/${P%%_pre}.tar.bz2"
HOMEPAGE="http://www.courier-mta.org/"
S="${WORKDIR}/${P%%_pre}"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="alpha amd64 arm hppa ia64 mips ppc ppc64 s390 sh sparc x86"
IUSE="postgres ldap mysql berkdb gdbm pam crypt debug"
RESTRICT="nouserpriv"

DEPEND="virtual/libc
		gdbm? ( sys-libs/gdbm )
		!gdbm? ( >=sys-devel/autoconf-2.5 sys-libs/db )
		>=dev-libs/openssl-0.9.6
		pam? ( >=sys-libs/pam-0.75 )
		mysql? ( >=dev-db/mysql-3.23.36 )
		ldap? ( >=net-nds/openldap-1.2.11 )
		postgres? ( >=dev-db/postgresql-7.2 )"

RDEPEND="virtual/libc
		gdbm? ( sys-libs/gdbm )
		!gdbm? ( sys-libs/db )"

filter-flags '-fomit-frame-pointer'

src_unpack() {
	if ! has_version 'dev-tcltk/expect' ; then
		ewarn 'The dev-tcltk/expect package is not installed.'
		einfo 'Without it, you will not be able to change system login passwords.'
		einfo 'However non-system authentication modules (LDAP, MySQL, PostgreSQL,'
		einfo 'and others) will work just fine.'
	fi
	unpack ${A}
	cd ${S}
	sed -e"s|^chk_file .* |&\${DESTDIR}|g" -i.orig authmigrate.in
	use elibc_uclibc && sed -i -e 's:linux-gnu\*:linux-gnu\*\ \|\ linux-uclibc:' config.sub
	if ! use gdbm ; then
		epatch ${FILESDIR}/configure-db4.patch
		export WANT_AUTOCONF="2.5"
		gnuconfig_update
		libtoolize --copy --force
		ebegin "Recreating configure"
			autoconf ||  die "recreate configure failed"
		eend $?
		cd ${S}/bdbobj
		libtoolize --copy --force
		ebegin "Recreating bdbobj/configure"
			autoconf ||  die "recreate bdbobj/configure failed"
		eend $?
	fi
	sed -i -e'/for dir in/a@@INDENT@@/etc/courier-imap \\' ${S}/authmigrate.in
	sed -i -e'/for dir in/a@@INDENT@@/etc/courier/authlib \\' ${S}/authmigrate.in
	sed -i -e"s|@@INDENT@@|		|g" ${S}/authmigrate.in
	sed -i -e"s|\$sbindir/makeuserdb||g" ${S}/authmigrate.in
}

src_compile() {
	local myconf
	myconf="`use_with pam authpam` `use_with ldap authldap`"

	if use berkdb ; then
		use gdbm && \
			einfo "Both gdbm and berkdb selected. Using gdbm." || \
				myconf="${myconf} --with-db=db"
	fi
	use gdbm && myconf="${myconf} --with-db=gdbm"

	if has_version 'net-mail/vpopmail' ; then
		myconf="${myconf} --with-authvchkpw --without-authmysql --without-authpgsql"
		use mysql && ewarn "vpopmail found. authmysql will not be built."
		use postgres && ewarn "vpopmail found. authpgsql will not be built."
	else
		myconf="${myconf} --without-authvchkpw `use_with mysql authmysql` `use_with postgres authpgsql`"
	fi

	use debug && myconf="${myconf} debug=true"

	einfo "Configuring courier-authlib: ${myconf}"

	econf \
		--sysconfdir=/etc/courier \
		--datadir=/usr/share/courier \
		--libexecdir=/usr/$(get_libdir)/courier \
		--localstatedir=/var/lib/courier \
		--sharedstatedir=/var/lib/courier/com \
		--with-authdaemonvar=/var/lib/courier/authdaemon \
		--with-authshadow \
		--without-redhat \
		--with-mailuser=mail \
		--with-mailgroup=mail \
		--cache-file=${S}/configuring.cache \
		${myconf} || die "bad ./configure"
	emake || die "Compile problem"
}

orderfirst() {
	file="${D}/etc/courier/authlib/${1}" ; option="${2}" ; param="${3}"
	if [ -e "${file}" ] ; then
		orig="`grep \"^${option}=\" ${file} | cut -d'\"' -f 2`"
		new="${option}=\"${param} `echo ${orig} | sed -e\"s/${param}//g\" -e\"s/  / /g\"`\""
		sed -i -e"s/^${option}=.*$/${new}/" ${file}
	fi
}

finduserdb() {
	for dir in \
		/etc/courier/authlib /etc/courier /etc/courier-imap \
		/usr/lib/courier/etc /usr/lib/courier-imap/etc \
		/usr/local/etc /usr/local/etc/courier /usr/local/courier/etc \
		/usr/local/lib/courier/etc /usr/local/lib/courier-imap/etc \
		/usr/local/share/sqwebmail /usr/local/etc/courier-imap ; do
	[ -e "$dir/userdb" ] && ( echo "found $dir/userdb" ; \
		cp -v $dir/userdb ${D}/etc/courier/authlib/ ; \
		chmod go-rwx ${D}/etc/courier/authlib/userdb ; continue )
	done
}

src_install() {
	diropts -o mail -g mail
	dodir /etc/courier
	keepdir /var/lib/courier/authdaemon
	keepdir /etc/courier/authlib
	emake install DESTDIR="${D}" || die "install"
	emake install-migrate DESTDIR="${D}" || die "migrate"
	[ ! -e "${D}/etc/courier/authlib/userdb" ] && finduserdb
	emake install-configure DESTDIR="${D}" || die "configure"
	rm -vf ${D}/etc/courier/authlib/*.bak
	chown mail:mail ${D}/etc/courier/authlib/*
	for y in ${D}/etc/courier/authlib/*.dist ; do
		[ ! -e "${y%%.dist}" ] && cp -v ${y} ${y%%.dist}
	done
	use pam && orderfirst authdaemonrc authmodulelist authpam
	use ldap && orderfirst authdaemonrc authmodulelist authldap
	use postgres && orderfirst authdaemonrc authmodulelist authpgsql
	use mysql && orderfirst authdaemonrc authmodulelist authmysql
	dodoc AUTHORS COPYING ChangeLog* INSTALL NEWS README
	dohtml README.html README_authlib.html NEWS.html INSTALL.html README.authdebug.html
	use mysql && ( dodoc README.authmysql.myownquery ; dohtml README.authmysql.html )
	use postgres && dohtml README.authpostgres.html README.authmysql.html
	use ldap && ( dodoc README.ldap ; dodir /etc/openldap/schema ; \
		cp authldap.schema ${D}/etc/openldap/schema/ )
	dodir /etc/init.d
	exeinto /etc/init.d
	newexe ${FILESDIR}/courier-authlib-initd courier-authlib || die "init.d failed"
}

pkg_postinst() {
	[ -e /etc/courier/authlib/userdb ] && \
		( einfo "running makeuserdb" ; chmod go-rwx /etc/courier/authlib/userdb \
		; makeuserdb )
	# Suggest cleaning out the following old files
	list="`find /etc/courier -type f -maxdepth 1 | grep \"^/etc/courier/auth\"`"
	if [ ! -z "${list}" ] ; then
		ewarn "Courier authentication files are now in /etc/courier/authlib/"
		einfo "The following files are no longer needed and can likely be removed:"
		einfo " rm `echo \"${list}\" | xargs echo`"
	fi
}
