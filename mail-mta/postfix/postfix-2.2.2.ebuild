# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-mta/postfix/postfix-2.2.2.ebuild,v 1.1 2005/04/04 17:00:50 langthang Exp $

inherit eutils ssl-cert toolchain-funcs flag-o-matic
IUSE="ipv6 pam ldap mysql postgres ssl sasl mailwrapper mbox nis vda selinux hardened"
#IUSE="ipv6 pam ldap mysql postgres ssl sasl mailwrapper mbox nis vda selinux hardened devel"

MY_PV=${PV}
MY_SRC=${PN}-${MY_PV}
#DEV_SRC=${MY_SRC}-newdb-nonprod
VDA_P="${PN}-2.2.1-vda"

DESCRIPTION="A fast and secure drop-in replacement for sendmail."
HOMEPAGE="http://www.postfix.org/"
SRC_URI="ftp://ftp.porcupine.org/mirrors/postfix-release/official/${MY_SRC}.tar.gz
	vda? ( http://web.onda.com.br/nadal/postfix/VDA/${VDA_P}.patch.gz ) "
#	devel? ( ftp://ftp.porcupine.org/mirrors/postfix-release/experimental/${DEV_SRC}.tar.gz ) "

LICENSE="IPL-1"
SLOT="0"
KEYWORDS="~x86 ~sparc ~ppc ~alpha ~amd64 ~s390 ~mips ~hppa ~ppc64"

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
	selinux? ( sec-policy/selinux-postfix )
	!mailwrapper? ( !virtual/mta )
	mailwrapper? ( >=net-mail/mailwrapper-0.2 )"

#if use devel; then
#	MY_SRC=${DEV_SRC}
#fi

S=${WORKDIR}/${MY_SRC}

group_user_check() {
	einfo "checking for postfix group...	create if missing."
	enewgroup postfix 207
	einfo "checking for postdrop group...	create if missing."
	enewgroup postdrop 208
	einfo "checking for postfix user...		create if missing."
	enewuser postfix 207 /bin/false /var/spool/postfix postfix
}

pkg_setup() {
	# do not upgrade from postfix-2.1. logic to fix bug #53324
	if [[ $(ps h -u postfix) ]]; then
		if has_version '<mail-mta/postfix-2.2' ; then
			if [ "${FORCE_UPGRADE}" ]; then
				echo
				ewarn "You are upgrading from a incompatible version and"
				ewarn "you have FORCE_UPGRADE set,  will build this package with postfix running."
				ewarn "You MUST stop postfix BEFORE install it to your system."
				echo
			else
				echo
				eerror "You are upgrading from a incompatible version."
				eerror "You MUST stop postfix BEFORE install it to your system."
				eerror "If you want a minimal downtime, emerge postfix with:"
				eerror "\`FORCE_UPGRADE=1 emerge --buildpkgonly postfix\`; then"
				eerror "\`/etc/init.d/postfix stop && emerge --usepkgonly postfix\`"
				eerror "run etc-update or dispatch-conf and merge the configuration files."
				eerror "Next /etc/init.d/postfix start"
				die "upgrade from an incompatible version!"
				echo
			fi

		else
			echo
			ewarn "It is safe to upgrade your current version while it's running."
			ewarn "If you don't want to take any chance; please hit Ctrl+C now;"
			ewarn "stop Postfix then emerge again."
			ewarn "You have been warned!"
			ewarn "Waiting 5 seconds before continuing."
			echo
			epause 5
		fi
	fi

	echo
	ewarn "Read \"ftp://ftp.porcupine.org/mirrors/postfix-release/official/${MY_SRC}.RELEASE_NOTES\""
	ewarn "for incompatible changes before continue."
	ewarn "Bugs should be filed at \"http://bugs.gentoo.org\""
	ewarn "assign to \"net-mail@gentoo.org\"."
	echo
	#epause 5

	# put out warnings to work around bug #45764
	if has_version '<=mail-mta/postfix-2.0.18'; then
		echo
		ewarn "You are upgrading from postfix-2.0.18 or earlier, one of the empty queue"
		ewarn "directory get deleted during unmerge the older version (#45764). Please run"
		ewarn "\`etc/postfix/post-install upgrade-source\` to recreate them."
		echo
	#epause 5
	fi

	#TLS non-prod warn
	if use ssl; then
		echo
		ewarn "you have \"ssl\" in your USE flags, TLS will be enabled."
		ewarn "This service entry is incompatible with previous TLS patch."
		ewarn "Visit http://www.postfix.org/TLS_README.html for more info."
		echo
	#epause 5
	fi

	# IPV6 non-prod warn
	if use ipv6; then
		echo
		ewarn "you have \"ipv6\" in your USE flags, IPV6 will be enabled."
		ewarn "Visit http://www.postfix.org/IPV6_README.html for more info."
		echo
	fi

	# VDA error
	#if use vda; then
	#	eerror "VDA patch is not available yet for this snapshot"
	#	eerror "If you still want to update to this snapshot"
	#	eerror "please remove \"vda\" from your USE flags."
	#	die "VDA support is not available at this time!"
	#fi

	# add postfix, postdrop user/group. Bug #77565.
	group_user_check || die "failed to check/add needed user/group"

}

src_unpack() {
	unpack ${A} && cd "${S}"

	#ht_fix_all

	if use vda ; then
		epatch "${WORKDIR}/${VDA_P}.patch" || die "failed to patch VDA"
	fi

	# Postfix does not get the FQDN if no hostname is configured.
	epatch "${FILESDIR}/${PN}-2.0.9-get-FQDN.patch" || die "patch failed."

	# Fix install paths.
	sed -e "s:/usr/libexec/postfix:/usr/lib/postfix:" \
		-i src/global/mail_params.h -i conf/main.cf || die "sed failed"
	# Fix hardcoded ALIAS_DB_MAP. Bug #75361.
	sed -e "/^#define ALIAS_DB_MAP/s|hash:/etc/aliases|hash:/etc/mail/aliases|" \
		-i.orig src/util/sys_defs.h || die "sed failed"

}

src_compile() {
	cd ${S}
	# added -Wl,-z,now wrt 62674.
	local mycc="-DHAS_PCRE" mylibs="-Wl,-z,now -L/usr/lib -lpcre -ldl -lcrypt -lpthread"

	if use pam ; then
		mylibs="${mylibs} -lpam"
	fi
	if use ldap ; then
		mycc="${mycc} -DHAS_LDAP"
		mylibs="${mylibs} -lldap -llber"
	fi
	if use mysql ; then
		mycc="${mycc} -DHAS_MYSQL -I/usr/include/mysql"
		mylibs="${mylibs} -lmysqlclient -lm -lz"
	fi
	if use postgres ; then
		if best_version '=dev-db/postgresql-7.3*' ; then
			mycc="${mycc} -DHAS_PGSQL -I/usr/include/postgresql"
		else
			mycc="${mycc} -DHAS_PGSQL -I/usr/include/postgresql/pgsql"
		fi
		mylibs="${mylibs} -lpq"
	fi
	if use ssl ; then
		mycc="${mycc} -DUSE_TLS"
		mylibs="${mylibs} -lssl -lcrypto"
	fi
	if use sasl ; then
		mycc="${mycc} -DUSE_SASL_AUTH -I/usr/include/sasl"
		mylibs="${mylibs} -lsasl2"
	fi

	if ! use nis; then
		sed -i -e "s|#define HAS_NIS|//#define HAS_NIS|g" src/util/sys_defs.h || \
			die "sed failed"
	fi

	mycc="${mycc} -DDEF_CONFIG_DIR=\\\"/etc/postfix\\\""
	mycc="${mycc} -DDEF_DAEMON_DIR=\\\"/usr/lib/postfix\\\""
	mycc="${mycc} -DDEF_PROGRAM_DIR=\\\"/usr/lib/postfix\\\""
	mycc="${mycc} -DDEF_MANPAGE_DIR=\\\"/usr/share/man\\\""
	mycc="${mycc} -DDEF_README_DIR=\\\"/usr/share/doc/${PF}/readme\\\""
	mycc="${mycc} -DDEF_HTML_DIR=\\\"/usr/share/doc/${PF}/html\\\""

	ebegin "Starting make makefiles..."

	local my_cc=$(tc-getCC)
	einfo "CC=${my_cc:=gcc}"

	# workaround for bug #76512
	[ "$(gcc-version)" == "3.4" ] && use hardened && replace-flags -O? -Os

	#ht_fix_file ${S}/Makefile.in || die "failed to fix head/tail"
	#epause 60

	make CC="${my_cc:=gcc}" OPT="${CFLAGS}" CCARGS="${mycc}" AUXLIBS="${mylibs}" \
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
		manpage_directory="/usr/share/man" \
		mail_owner="postfix" \
		setgid_group="postdrop" || die "postfix-install failed"

	# Fix spool removal on upgrade.
	rm -rf "${D}/var"
	keepdir /var/spool/postfix

	# mailwrapper stuff
	if use mailwrapper
	then
		mv "${D}/usr/sbin/sendmail" "${D}/usr/sbin/sendmail.postfix"
		insinto /etc/mail
		doins "${FILESDIR}/mailer.conf"
	fi


	# Provide another link for legacy FSH.
	dosym /usr/sbin/sendmail /usr/lib/sendmail

	# Install an rmail for UUCP, closing bug #19127.
	dobin auxiliary/rmail/rmail

	# Install qshape tool.
	dobin auxiliary/qshape/qshape.pl

	# Set proper permissions on required files/directories.
	fowners root:postdrop /usr/sbin/post{drop,queue}
	fperms 02711 /usr/sbin/post{drop,queue}

	keepdir /etc/postfix
	mv ${D}/usr/share/doc/${PF}/defaults/{*.cf,post*-*} ${D}/etc/postfix
	if use mbox
	then
		mypostconf="mail_spool_directory=/var/spool/mail"
	else
		mypostconf="home_mailbox=.maildir/"
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

	newinitd "${FILESDIR}/postfix.rc6" postfix || \
		die "newinitd failed"

	mv "${S}/examples" "${D}/usr/share/doc/${PF}/"
	dodoc *README COMPATIBILITY HISTORY INSTALL LICENSE PORTING RELEASE_NOTES*
	dohtml html/*

	if use pam ; then
		insinto /etc/pam.d
		newins "${FILESDIR}/smtp.pam" smtp
	fi
	if use ssl ; then
		SSL_ORGANIZATION="${SSL_ORGANIZATION:-Postfix SMTP Server}"
		insinto /etc/ssl/postfix
		docert server
		fowners postfix:mail /etc/ssl/postfix/server.{key,pem}
	fi
	if use sasl ; then
		insinto /etc/sasl2
		newins "${FILESDIR}/smtp.sasl" smtpd.conf
	fi
}

pkg_postinst() {

	# add postfix, postdrop user/group. Bug #77565.
	group_user_check || die "failed to check/add needed user/group"

	ebegin "Fixing queue directories and permissions"
	"${ROOT}/etc/postfix/post-install" upgrade-permissions
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

	if ! use mailwrapper && [[ -e /etc/mailer.conf ]]
	then
		einfo
		einfo "Since you emerged $PN without mailwrapper in USE,"
		einfo "you probably want to 'emerge -C mailwrapper' now."
		einfo
	fi
}
