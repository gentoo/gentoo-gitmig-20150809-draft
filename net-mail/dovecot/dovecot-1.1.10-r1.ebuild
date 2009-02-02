# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/dovecot/dovecot-1.1.10-r1.ebuild,v 1.1 2009/02/02 11:18:37 wschlich Exp $

inherit autotools eutils ssl-cert versionator

MY_P="${P/_/.}"
MY_PV12=$(get_version_component_range 1-2 ${PV})
S="${WORKDIR}/${MY_P}"
SIEVE="dovecot-sieve-1.1.6"
SIEVE_S="${WORKDIR}/${SIEVE}"
MANAGESIEVE_PATCH="managesieve-0.10.5"
MANAGESIEVE="managesieve-0.10.5"
MANAGESIEVE_S="${WORKDIR}/${PN}-${MY_PV12}-${MANAGESIEVE}"

SRC_URI="http://dovecot.org/releases/${MY_PV12}/${MY_P}.tar.gz
sieve? ( http://dovecot.org/releases/sieve/${SIEVE}.tar.gz )
managesieve? ( http://www.rename-it.nl/${PN}/${MY_PV12}/${MY_P}-${MANAGESIEVE_PATCH}.diff.gz
http://www.rename-it.nl/${PN}/${MY_PV12}/${PN}-${MY_PV12}-${MANAGESIEVE}.tar.gz )"

DESCRIPTION="An IMAP and POP3 server written with security primarily in mind"
HOMEPAGE="http://www.dovecot.org/"

SLOT="0"
LICENSE="LGPL-2.1"
KEYWORDS="~alpha ~amd64 ~ppc ~sparc ~x86 ~x86-fbsd"

IUSE="berkdb debug doc ipv6 kerberos ldap managesieve mbox mysql pop3d pam postgres sieve sqlite3 ssl suid vpopmail"

# Developer documentation, controlled by the doc USE flag
DEVDOCS="auth-protocol index multiaccess securecoding"

DEPEND=">=sys-apps/sed-4
	sys-libs/libcap
	berkdb? ( >=sys-libs/db-4.2 )
	kerberos? ( virtual/krb5 )
	ldap? ( net-nds/openldap )
	pam? ( virtual/pam )
	ssl? ( dev-libs/openssl )
	postgres? ( virtual/postgresql-base )
	mysql? ( virtual/mysql )
	sqlite3? ( =dev-db/sqlite-3* )
	vpopmail? ( net-mail/vpopmail )"

RDEPEND="${DEPEND}
	>=net-mail/mailbase-0.00-r8"

src_unpack() {
	unpack ${A}
	cd "${S}"
	if use managesieve; then
		epatch "${WORKDIR}"/${MY_P}-${MANAGESIEVE_PATCH}.diff
		eautoreconf
	fi
	epatch "${FILESDIR}/${P}-498022697a33.patch"
}

pkg_setup() {
	if ! use sieve && use managesieve; then
		eerror "managesieve USE flag selected but sieve USE flag unselected"
		die "USE flag problem"
	fi
	# Add user and group for login process (same as for fedora/redhat)
	enewgroup dovecot 97
	enewuser dovecot 97 -1 /dev/null dovecot
}

src_compile() {
	local myconf=
	use ssl && myconf="${myconf} --with-ssl=openssl" \
		|| myconf="${myconf} --without-ssl"
	econf \
		--localstatedir=/var \
		--sysconfdir=/etc/dovecot \
		--enable-header-install \
		--with-ioloop=best \
		--with-poll=best \
		$(use_with berkdb db) \
		$(use_enable debug) \
		$(use_enable ipv6) \
		$(use_with kerberos gssapi) \
		$(use_with ldap) \
		$(use_with mysql) \
		$(use_with pam) \
		$(use_with pop3d) \
		$(use_with postgres pgsql) \
		$(use_with sqlite3 sqlite) \
		$(use_with vpopmail) \
		${myconf} \
		|| die "configure failed"
	emake || die "make failed"

	if use sieve; then
		einfo "Building sieve"
		cd "${SIEVE_S}"
		econf --with-dovecot="${S}" || die "configure failed (sieve)"
		emake || die "make failed (sieve)"
	fi

	if use managesieve; then
		einfo "Building managesieve"
		cd "${MANAGESIEVE_S}"
		econf --with-dovecot="${S}" --with-dovecot-sieve="${SIEVE_S}" \
			|| die "configure failed (managesieve)"
		emake || die "make failed (managesieve)"
	fi
}

src_install () {
	make DESTDIR="${D}" install || die "make install failed"
	use suid && fperms u+s /usr/libexec/dovecot/deliver

	rm -f "${D}"/etc/dovecot/dovecot-{ldap,sql}-example.conf

	newinitd "${FILESDIR}"/dovecot.init-r2 dovecot

	# Documentation
	rm -rf "${D}"/usr/share/doc/dovecot
	dodoc AUTHORS NEWS README TODO dovecot-example.conf
	use managesieve && newdoc ${MANAGESIEVE_S}/README README.managesieve
	if use doc; then
		dodoc doc/*.txt
	else
		local x= n=
		for x in doc/*.txt; do
			n=$(basename "${x}" .txt)
			[[ " ${DEVDOCS} " != *" ${n} "* ]] && dodoc "${x}"
		done
	fi

	# Create the dovecot.conf file from the dovecot-example.conf file that
	# the dovecot folks nicely left for us....
	local conf="${D}/etc/dovecot/dovecot.conf"
	mv "${D}"/etc/dovecot/dovecot-example.conf "${D}"/etc/dovecot/dovecot.conf

	# .maildir is the Gentoo default, but we need to support mbox to
	local mail_location="maildir:~/.maildir"
	if use mbox; then
		mail_location="mbox:/var/spool/mail/%u:INDEX=/var/dovecot/%u"
		keepdir /var/dovecot
		sed -i -e 's|#mail_privileged_group =|mail_privileged_group = mail|' "${conf}"
	fi
	sed -i -e \
		"s|#mail_location =|mail_location = ${mail_location}|" "${conf}" \
		|| die "failed to update mail location settings in dovecot.conf"

	# We're using pam files (imap and pop3) provided by mailbase
	if use pam; then
		sed -i -e '/passdb pam/, /^[ \t]*}/ s|#args = dovecot|args = "\*"|' \
			"${conf}" || die "failed to update PAM settings in dovecot.conf"
		# mailbase does not provide a managesieve pam file
		use managesieve && dosym imap /etc/pam.d/managesieve
	fi

	# Listen on ipv6 and ipv4
	if use ipv6; then
		sed -i -e 's/^#listen = \*/listen = \[::\]/g' "${conf}" \
			|| die "failed to update listen settings in dovecot.conf"
	fi

	# Update ssl cert locations
	if use ssl; then
		sed -i -e 's,^#ssl_cert_file =.*,ssl_cert_file = /etc/ssl/dovecot/server.pem,' \
			-e 's,^#ssl_key_file =.*,ssl_key_file = /etc/ssl/dovecot/server.key,' \
			"${conf}" || die "failed to update SSL settings in dovecot.conf"
	fi

	# Install SQL configuration
	if use mysql || use postgres; then
		cp doc/dovecot-sql-example.conf "${D}"/etc/dovecot/dovecot-sql.conf
		fperms 600 /etc/dovecot/dovecot-sql.conf
		sed -i -e '/db sql/,/args/ s|=|= /etc/dovecot-sql.conf|' "${conf}" \
			|| die "failed to update SQL settings in dovecot-sql.conf"
		dodoc doc/dovecot-sql-example.conf
	fi

	# Install LDAP configuration
	if use ldap; then
		cp doc/dovecot-ldap-example.conf "${D}"/etc/dovecot/dovecot-ldap.conf
		fperms 600 /etc/dovecot/dovecot-ldap.conf
		sed -i -e '/db ldap/,/args/ s|=|= /etc/dovecot-ldap.conf|' "${conf}" \
			|| die "failed to update LDAP settings in dovecot-ldap.conf"
		dodoc doc/dovecot-ldap-example.conf
	fi

	# Install sieve plugin
	if use sieve; then
		make -C "${SIEVE_S}" DESTDIR="${D}" install \
			|| die "make install failed (sieve)"
	fi

	# Install managesieve
	if use managesieve; then
		make -C "${MANAGESIEVE_S}" DESTDIR="${D}" install \
			|| die "make install failed (managesieve)"
	fi

	dodir /var/run/dovecot
	fowners root:0 /var/run/dovecot
	fperms 0755 /var/run/dovecot
	keepdir /var/run/dovecot/login
	fowners root:dovecot /var/run/dovecot/login
	fperms 0750 /var/run/dovecot/login
}

get_config_var() {
	local varname=${1}
	if [[ -z ${varname} ]]; then
		die "${FUNCNAME}: variable name missing"
	fi
	sed -n 's/^[[:space:]]\?'"${varname}"'[[:space:]]*="*\([^#"]\+\)"*/\1/p' \
		"${ROOT}"/etc/dovecot/dovecot.conf
}

pkg_postinst() {
	elog "The Dovecot configuration has vastly changed since 0.99."
	elog "You are encouraged to start afresh with a new configuration file."
	elog "see http://wiki.dovecot.org/ for configuration examples."

	if [[ -e "${ROOT}"/etc/dovecot.conf ]]; then
		echo
		ewarn "The Dovecot configuration now resides in ${ROOT}/etc/dovecot"
	fi

	local base_dir="$(get_config_var base_dir)"
	base_dir="${base_dir:-/var/run/dovecot}"
	if use ssl; then
		# Let's not make a new certificate if we already have one
		if ! [[ -e "${ROOT}"/etc/ssl/dovecot/server.pem && \
			-e "${ROOT}"/etc/ssl/dovecot/server.key ]]; then
			einfo "Creating SSL certificate"
			SSL_ORGANIZATION="${SSL_ORGANIZATION:-Dovecot IMAP Server}"
			install_cert /etc/ssl/dovecot/server
			chown dovecot:mail "${ROOT}"/etc/ssl/dovecot/server.{key,pem}
		fi
		if [[ ! -e "${ROOT}${base_dir}/login/ssl-parameters.dat" ]]; then
			echo
			elog "Dovecot requires DH SSL Parameters if you use SSL connections"
			elog "These take some time to make, and dovecot will create them before"
			elog "it allows any SSL connections."
			elog "You can create them now before starting dovecot like so"
			elog "   emerge --config =${PF}"
		fi
	fi

	if grep -q '^ssl_key_password' "${ROOT}"/etc/dovecot/dovecot.conf; then
		echo
		ewarn "*** ATTENTION ATTENTION ATTENTION ATTENTION ATTENTION ***"
		ewarn
		ewarn "You have set ssl_key_password in dovecot.conf!"
		ewarn "You are URGED to read the advice in the current"
		ewarn "dovecot-example.conf regarding sensible handling"
		ewarn "of that password, as it might be readable by any"
		ewarn "user on your system who can access that file!"
		ewarn
		ewarn "*** ATTENTION ATTENTION ATTENTION ATTENTION ATTENTION ***"
		echo
	fi
}

pkg_config() {
	local base_dir="$(get_config_var base_dir)"
	base_dir="${base_dir:-/var/run/dovecot}"

	if use ssl; then
		einfo "Regenerating SSL parameters. This will take some time."
		"${ROOT}"/usr/libexec/dovecot/ssl-build-param "${base_dir}/login/ssl-parameters.dat"
	fi
}
