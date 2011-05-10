# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-mta/postfix/postfix-2.7.4.ebuild,v 1.2 2011/05/10 12:21:09 phajdan.jr Exp $

EAPI=3

inherit eutils multilib ssl-cert toolchain-funcs flag-o-matic pam

MY_PV="${PV/_rc/-RC}"
MY_SRC="${PN}-${MY_PV}"
MY_URI="ftp://ftp.porcupine.org/mirrors/postfix-release/official"
VDA_PV="2.7.2"
VDA_P="${PN}-vda-${VDA_PV}"
RC_VER="2.5"

DESCRIPTION="A fast and secure drop-in replacement for sendmail."
HOMEPAGE="http://www.postfix.org/"
SRC_URI="${MY_URI}/${MY_SRC}.tar.gz
	vda? ( http://vda.sourceforge.net/VDA/${VDA_P}.patch ) "

LICENSE="IBM"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~s390 ~sh ~sparc x86 ~x86-fbsd"
IUSE="cdb doc dovecot-sasl examples hardened ipv6 ldap mbox mysql nis pam postgres sasl selinux ssl vda"

DEPEND=">=sys-libs/db-3.2
	>=dev-libs/libpcre-3.4
	cdb? ( || ( >=dev-db/cdb-0.75-r1 >=dev-db/tinycdb-0.76 ) )
	ldap? ( >=net-nds/openldap-1.2 )
	mysql? ( virtual/mysql )
	pam? ( virtual/pam )
	postgres? ( dev-db/postgresql-base )
	sasl? (  >=dev-libs/cyrus-sasl-2 )
	ssl? ( >=dev-libs/openssl-0.9.6g )"

RDEPEND="${DEPEND}
	net-mail/mailbase
	!net-mail/mailwrapper
	selinux? ( sec-policy/selinux-postfix )
	!mail-mta/courier
	!mail-mta/esmtp
	!mail-mta/exim
	!mail-mta/mini-qmail
	!mail-mta/msmtp
	!mail-mta/nbsmtp
	!mail-mta/netqmail
	!mail-mta/nullmailer
	!mail-mta/qmail-ldap
	!mail-mta/sendmail
	!<mail-mta/ssmtp-2.64-r2
	!>=mail-mta/ssmtp-2.64-r2[mta]"

S="${WORKDIR}/${MY_SRC}"

group_user_check() {
	einfo "Checking for postfix group ..."
	enewgroup postfix 207
	einfo "Checking for postdrop group ..."
	enewgroup postdrop 208
	einfo "Checking for postfix user ..."
	enewuser postfix 207 -1 /var/spool/postfix postfix,mail
}

pkg_setup() {
	# Add postfix, postdrop user/group (bug #77565)
	group_user_check || die "Failed to check/add needed user/group"
}

src_prepare() {
	if use vda ; then
		epatch "${DISTDIR}"/${VDA_P}.patch
	fi

	sed -i -e "/^#define ALIAS_DB_MAP/s|:/etc/aliases|:/etc/mail/aliases|" \
		src/util/sys_defs.h || die "sed failed"

	# change default paths to better comply with portage standard paths
	sed -i -e "s:/usr/local/:/usr/:g" conf/master.cf || die "sed failed"
}

src_configure() {
	# Make sure LDFLAGS get passed down to the executables.
	local mycc="-DHAS_PCRE" mylibs="${LDFLAGS} -lpcre -lcrypt -lpthread"

	use pam && mylibs="${mylibs} -lpam"

	if use ldap ; then
		mycc="${mycc} -DHAS_LDAP"
		mylibs="${mylibs} -lldap -llber"
	fi

	if use mysql ; then
		mycc="${mycc} -DHAS_MYSQL $(mysql_config --include)"
		mylibs="${mylibs} $(mysql_config --libs)"
	fi

	if use postgres ; then
		mycc="${mycc} -DHAS_PGSQL -I$(pg_config --includedir)"
		mylibs="${mylibs} -lpq -L$(pg_config --libdir)"
	fi

	if use ssl ; then
		mycc="${mycc} -DUSE_TLS"
		mylibs="${mylibs} -lssl -lcrypto"
	fi

	if use sasl ; then
		if use dovecot-sasl ; then
			# Set dovecot as default.
			mycc="${mycc} -DDEF_SASL_SERVER=\\\"dovecot\\\""
		fi
		mycc="${mycc} -DUSE_SASL_AUTH -DUSE_CYRUS_SASL -I/usr/include/sasl"
		mylibs="${mylibs} -lsasl2"
	elif use dovecot-sasl ; then
		mycc="${mycc} -DUSE_SASL_AUTH -DDEF_SERVER_SASL_TYPE=\\\"dovecot\\\""
	fi

	if ! use nis ; then
		sed -i -e "s|#define HAS_NIS|//#define HAS_NIS|g" \
			src/util/sys_defs.h || die "sed failed"
	fi

	if use cdb ; then
		mycc="${mycc} -DHAS_CDB -I/usr/include/cdb"
		CDB_LIBS=""

		# Tinycdb is preferred.
		if has_version dev-db/tinycdb ; then
			einfo "Building with dev-db/tinycdb"
			CDB_LIBS="-lcdb"
		else
			einfo "Building with dev-db/cdb"
			CDB_PATH="/usr/$(get_libdir)"
			for i in cdb.a alloc.a buffer.a unix.a byte.a ; do
				CDB_LIBS="${CDB_LIBS} ${CDB_PATH}/${i}"
			done
		fi

		mylibs="${mylibs} ${CDB_LIBS}"
	fi

	mycc="${mycc} -DDEF_DAEMON_DIR=\\\"/usr/$(get_libdir)/postfix\\\""

	# Robin H. Johnson <robbat2@gentoo.org> 17/Nov/2006
	# Fix because infra boxes hit 2Gb .db files that fail a 32-bit fstat signed check.
	mycc="${mycc} -D_FILE_OFFSET_BITS=64 -D_LARGEFILE_SOURCE -D_LARGEFILE64_SOURCE"
	filter-lfs-flags

	# Workaround for bug #76512
	if use hardened ; then
		[[ "$(gcc-version)" == "3.4" ]] && replace-flags -O? -Os
	fi

	emake DEBUG="" CC="$(tc-getCC)" OPT="${CFLAGS}" CCARGS="${mycc}" AUXLIBS="${mylibs}" \
		makefiles || die "configure problem"
}

src_install () {
	local myconf
	use doc && myconf="readme_directory=\"/usr/share/doc/${PF}/readme\" \
		html_directory=\"/usr/share/doc/${PF}/html\""

	/bin/sh postfix-install \
		-non-interactive \
		install_root="${D}" \
		config_directory="/usr/share/doc/${PF}/defaults" \
		manpage_directory="/usr/share/man" \
		${myconf} \
		|| die "postfix-install failed"

	# Fix spool removal on upgrade
	rm -Rf "${D}"/var
	keepdir /var/spool/postfix

	# Install rmail for UUCP, closes bug #19127
	dobin auxiliary/rmail/rmail

	# Provide another link for legacy FSH
	dosym /usr/sbin/sendmail /usr/$(get_libdir)/sendmail

	# Install qshape tool
	dobin auxiliary/qshape/qshape.pl
	doman man/man1/qshape.1

	# Performance tuning tools and their manuals
	dosbin bin/smtp-{source,sink} bin/qmqp-{source,sink}
	doman man/man1/smtp-{source,sink}.1 man/man1/qmqp-{source,sink}.1

	# Set proper permissions on required files/directories
	dodir /var/lib/postfix
	keepdir /var/lib/postfix
	fowners postfix:postfix /var/lib/postfix
	fowners postfix:postfix /var/lib/postfix/.keep_${CATEGORY}_${PN}-${SLOT}
	fperms 0750 /var/lib/postfix
	fowners root:postdrop /usr/sbin/post{drop,queue}
	fperms 02711 /usr/sbin/post{drop,queue}

	keepdir /etc/postfix
	mv "${D}"/usr/share/doc/${PF}/defaults/*.cf "${D}"/etc/postfix
	if use mbox ; then
		mypostconf="mail_spool_directory=/var/spool/mail"
	else
		mypostconf="home_mailbox=.maildir/"
	fi
	"${D}"/usr/sbin/postconf -c "${D}"/etc/postfix \
		-e ${mypostconf} || die "postconf failed"

	insinto /etc/postfix
	newins "${FILESDIR}"/smtp.pass saslpass
	fperms 600 /etc/postfix/saslpass

	newinitd "${FILESDIR}"/postfix.rc6.${RC_VER} postfix || die "newinitd failed"

	use examples && mv "${S}"/examples "${D}"/usr/share/doc/${PF}/

	dodoc *README COMPATIBILITY HISTORY INSTALL PORTING RELEASE_NOTES*

	pamd_mimic_system smtp auth account

	if use sasl ; then
		insinto /etc/sasl2
		newins "${FILESDIR}"/smtp.sasl smtpd.conf
	fi

	# Remove unnecessary files
	rm -f "${D}"/usr/$(get_libdir)/postfix/*.cf
}

pkg_postinst() {
	# Add postfix, postdrop user/group (bug #77565)
	group_user_check || die "Failed to check/add needed user/group"

	# Do not install server.{key,pem) SSL certificates if they already exist
	if use ssl && [[ ! -f "${ROOT}"/etc/ssl/postfix/server.key \
		&& ! -f "${ROOT}"/etc/ssl/postfix/server.pem ]] ; then
		SSL_ORGANIZATION="${SSL_ORGANIZATION:-Postfix SMTP Server}"
		install_cert /etc/ssl/postfix/server
		chown postfix:mail "${ROOT}"/etc/ssl/postfix/server.{key,pem}
	fi

	ebegin "Fixing queue directories and permissions"
	"${ROOT}"/usr/$(get_libdir)/postfix/post-install upgrade-permissions \
		daemon_directory="${ROOT}/usr/$(get_libdir)/postfix"

	if [[ ! -e /etc/mail/aliases.db ]] ; then
		ewarn
		ewarn "You must edit /etc/mail/aliases to suit your needs"
		ewarn "and then run /usr/bin/newaliases. Postfix will not"
		ewarn "work correctly without it."
		ewarn
	fi

	if [[ -e /etc/mailer.conf ]] ; then
		einfo
		einfo "mailwrapper support is discontinued."
		einfo "You may want to 'emerge -C mailwrapper' now."
		einfo
	fi

	elog
	elog "See the RELEASE_NOTES file in /usr/share/doc/${PF}"
	elog "for incompatibilities and other major changes between releases."
	elog
}
