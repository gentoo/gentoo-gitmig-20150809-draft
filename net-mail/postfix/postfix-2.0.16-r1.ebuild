# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/postfix/postfix-2.0.16-r1.ebuild,v 1.16 2004/03/17 23:50:32 g2boojum Exp $

inherit eutils ssl-cert

TLS_P="pfixtls-0.8.16-2.0.16-0.9.7b"
IPV6="1.18a"
IPV6_P="ipv6-${IPV6}-pf-2.0.16"
IPV6_TLS_P="tls+${IPV6_P}"
PGSQL_P="postfix-pg.postfix-2.0.0.2"

DESCRIPTION="A fast and secure drop-in replacement for sendmail."
HOMEPAGE="http://www.postfix.org/"
SRC_URI="ftp://ftp.porcupine.org/mirrors/postfix-release/official/${P}.tar.gz
	ftp://ftp.porcupine.org/mirrors/postfix-release/official/${PN}-2.0-ns-mx-acl-patch.gz
	ssl? ( ftp://ftp.aet.tu-cottbus.de/pub/postfix_tls/old/${TLS_P}.tar.gz )
	ipv6? ( ftp://ftp.stack.nl/pub/postfix/tls+ipv6/${IPV6}/${IPV6_P}.patch.gz )
	ipv6? ( ftp://ftp.stack.nl/pub/postfix/tls+ipv6/${IPV6}/${IPV6_TLS_P}.patch.gz )
	postgres? ( http://www.mat.cc/postfix/${PGSQL_P}.patch )"

LICENSE="IPL-1"
SLOT="0"
KEYWORDS="x86 sparc ~ppc"
IUSE="ipv6 pam ldap mysql postgres ssl sasl maildir mbox"

PROVIDE="virtual/mta virtual/mda"
DEPEND=">=sys-libs/db-3.2
	>=dev-libs/libpcre-3.4
	>=sys-apps/sed-4
	ldap? ( >=net-nds/openldap-1.2 )
	mysql? ( >=dev-db/mysql-3.23.51 )
	postgres? ( >=dev-db/postgresql-7.1 )
	ssl? ( >=dev-libs/openssl-0.9.6g )
	sasl? ( >=dev-libs/cyrus-sasl-2 )"
RDEPEND="${DEPEND}
	>=net-mail/mailbase-0.00
	!virtual/mta"

# Is this still necessary since gentoo sasl looks
# in /etc/sasl2 for it's config files?
pkg_setup() {
	# Prevent mangling the smtpd.conf file.
	if [ ! -L "${ROOT}/usr/lib/sasl2/smtpd.conf" ] ; then
		if [ -f "${ROOT}/usr/lib/sasl2/smtpd.conf" ] ; then
			ebegin "Protecting your smtpd.conf file"
			if [ ! -d "${ROOT}/etc/sasl2" ] ; then
				mkdir -p "${ROOT}/etc/sasl2"
			fi

			# This shouldn't be necessary, but apparently
			# without it things can still get messy.
			if [ -L "${ROOT}/etc/sasl2/smtpd.conf" ] ; then
				rm "${ROOT}/etc/sasl2/smtpd.conf"
			fi

			# If both files exist, make sure that we preserve
			# a copy of each with the ._cfg system.
			if [ -f "${ROOT}/etc/sasl2/smtpd.conf" ] ; then
				mv "${ROOT}/etc/sasl2/smtpd.conf" \
					"${ROOT}/etc/sasl2/._cfg0000_smtpd.conf"
			fi
			mv "${ROOT}/usr/lib/sasl2/smtpd.conf" "${ROOT}/etc/sasl2"
			eend
		fi
	fi
}

src_unpack() {
	unpack ${A} && cd "${S}"

	if [ "`use ssl`" ] ; then
		if [ "`use ipv6`" ] ; then
			epatch "${WORKDIR}/${IPV6_TLS_P}.patch"
		else
			epatch "${WORKDIR}/${TLS_P}/pfixtls.diff"
		fi
	elif [ "`use ipv6`" ]; then
		epatch "${WORKDIR}/${IPV6_P}.patch"
	fi

	if [ "`use postgres`" ] ; then
		epatch "${DISTDIR}/${PGSQL_P}.patch"
	fi

	# Verisign name services fixes.
	epatch "${WORKDIR}/${PN}-2.0-ns-mx-acl-patch"

	# Postfix does not get the FQDN if no hostname is configured.
	epatch "${FILESDIR}/${PN}-2.0.9-get-FQDN.patch"

	# Fix install paths.
	sed -e "s:/usr/libexec/postfix:/usr/lib/postfix:" \
		-i src/global/mail_params.h -i conf/main.cf || die "sed failed"
}

src_compile() {
	local mycc="-DHAS_PCRE" mylibs="-L/usr/lib -lpcre -ldl -lcrypt -lpthread"

	if [ "`use pam`" ] ; then
		mylibs="${mylibs} -lpam"
	fi
	if [ "`use ldap`" ] ; then
		mycc="${mycc} -DHAS_LDAP"
		mylibs="${mylibs} -lldap -llber"
	fi
	if [ "`use mysql`" ] ; then
		mycc="${mycc} -DHAS_MYSQL -I/usr/include/mysql"
		mylibs="${mylibs} -lmysqlclient -lm -lz"
	fi
	if [ "`use postgres`" ] ; then
		if [ "`best_version '=dev-db/postgresql-7.3*'`" ] ; then
			mycc="${mycc} -DHAS_PGSQL -I/usr/include/postgresql"
		else
			mycc="${mycc} -DHAS_PGSQL -I/usr/include/postgresql/pgsql"
		fi
		mylibs="${mylibs} -lpq"
	fi
	if [ "`use ssl`" ] ; then
		mycc="${mycc} -DUSE_SSL"
		mylibs="${mylibs} -lssl -lcrypto"
	fi
	if [ "`use sasl`" ] ; then
		mycc="${mycc} -DUSE_SASL_AUTH -I/usr/include/sasl"
		mylibs="${mylibs} -lsasl2"
	fi

	mycc="${mycc} -DDEF_CONFIG_DIR=\\\"/etc/postfix\\\""
	mycc="${mycc} -DDEF_DAEMON_DIR=\\\"/usr/lib/postfix\\\""
	mycc="${mycc} -DDEF_PROGRAM_DIR=\\\"/usr/lib/postfix\\\""
	mycc="${mycc} -DDEF_MANPAGE_DIR=\\\"/usr/share/man\\\""
	mycc="${mycc} -DDEF_README_DIR=\\\"/usr/share/doc/${PF}/readme\\\""
	mycc="${mycc} -DDEF_SAMPLE_DIR=\\\"/usr/share/doc/${PF}/sample\\\""

	make CC="${CC:=gcc}" OPT="${CFLAGS}" CCARGS="${mycc}" AUXLIBS="${mylibs}" \
		makefiles || die "configure problem"

	emake || die "compile problem"
}

src_install () {
	/bin/sh postfix-install \
		-non-interactive \
		install_root="${D}" \
		daemon_directory="/usr/lib/postfix" \
		program_directory="/usr/lib/postfix" \
		config_directory="/usr/share/doc/${PF}/defaults" \
		readme_directory="/usr/share/doc/${PF}/readme" \
		sample_directory="/usr/share/doc/${PF}/sample" \
		manpage_directory="/usr/share/man" \
		mail_owner="postfix" \
		setgid_group="postdrop" || die "postfix-install failed"

	# Provide another link for legacy FSH.
	dosym /usr/sbin/sendmail /usr/lib/sendmail

	# Install an rmail for UUCP, closing bug #19127.
	dobin auxiliary/rmail/rmail

	# Set proper permissions on required files/directories.
	fowners root:postdrop /usr/sbin/post{drop,queue}
	fperms 02711 /usr/sbin/post{drop,queue}

	keepdir /etc/postfix
	mv "${D}/usr/share/doc/${PF}/defaults/"{*.cf,post*-*} "${D}/etc/postfix"
	if [ "`use maildir`" ] ; then
		mypostconf="home_mailbox=.maildir/"
	elif [ "`use mbox`" ] ; then
		mypostconf="mail_spool_directory=/var/spool/mail"
	fi
	"${D}/usr/sbin/postconf" -c "${D}/etc/postfix" -e \
		"alias_maps=hash:/etc/mail/aliases" \
		"alias_database=hash:/etc/mail/aliases" \
		"local_destination_concurrency_limit=2" \
		"default_destination_concurrency_limit=2" \
		${mypostconf} || die "postconf failed"

	insinto /etc/postfix
	newins "${FILESDIR}/smtp.pass" saslpass
	fperms 600 /etc/postfix/saslpass

	exeinto /etc/init.d
	newexe "${FILESDIR}/postfix.rc6" postfix

	dodoc *README COMPATIBILITY HISTORY INSTALL LICENSE PORTING RELEASE_NOTES*
	dohtml html/*

	if [ "`use pam`" ] ; then
		insinto /etc/pam.d
		newins "${FILESDIR}/smtp.pam" smtp
	fi
	if [ "`use ssl`" ] ; then
		SSL_ORGANIZATION="${SSL_ORGANIZATION:-Postfix SMTP Server}"
		insinto /etc/ssl/postfix
		docert server
		fowners postfix:mail /etc/ssl/postfix/server.{key,pem}
	fi
	if [ "`use sasl`" ] ; then
		insinto /etc/sasl2
		newins "${FILESDIR}/smtp.sasl" smtpd.conf
	fi
}

pkg_postinst() {
	ebegin "Fixing queue directories and permissions"
	"${ROOT}/etc/postfix/post-install" upgrade-permissions
	eend $?
	echo

	ewarn "If you upgraded from postfix-1.x, you must revisit"
	ewarn "your configuration files.  See"
	ewarn "  /usr/share/doc/${PF}/RELEASE_NOTES"
	ewarn "for a list of changes."

	if [ ! -e /etc/mail/aliases.db ] ; then
		echo
		ewarn "You must edit /etc/mail/aliases to suit your needs"
		ewarn "and then run /usr/bin/newaliases. Postfix will not"
		ewarn "work correctly without it."
	fi
}
