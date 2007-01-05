# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/dovecot/dovecot-1.0_rc16.ebuild,v 1.1 2007/01/05 19:20:16 uberlord Exp $

inherit autotools eutils

MY_P="${P/_/.}"
S="${WORKDIR}/${MY_P}"
SIEVE="dovecot-sieve-1.0"
SIEVE_S="${WORKDIR}/${SIEVE}"

SRC_URI="http://dovecot.org/releases/${MY_P}.tar.gz
sieve? ( http://dovecot.org/releases/sieve/${SIEVE}.tar.gz )"

DESCRIPTION="An IMAP and POP3 server written with security primarily in mind"
HOMEPAGE="http://dovecot.org/"

SLOT="0"
LICENSE="LGPL-2.1"
KEYWORDS="~alpha ~amd64 ~ppc ~sparc ~x86"

IUSE="debug doc ipv6 kerberos ldap mbox mysql pop3d pam postgres sieve ssl vpopmail"

# Developer documentation, controlled by the doc USE flag
DEVDOCS="auth-protocol index multiaccess securecoding"

DEPEND=">=sys-apps/sed-4
	kerberos? ( virtual/krb5 )
	ldap? ( net-nds/openldap )
	pam? ( virtual/pam )
	ssl? ( dev-libs/openssl )
	postgres? ( dev-db/postgresql )
	mysql? ( virtual/mysql )
	vpopmail? ( net-mail/vpopmail )"

RDEPEND="${DEPEND}
	>=net-mail/mailbase-0.00-r8"

pkg_setup() {
	# Add user and group for login process (same as for fedora/redhat)
	enewgroup dovecot 97
	enewuser dovecot 97 -1 /dev/null dovecot
}

src_compile() {
	local myconf=
	use ssl && myconf="${myconf} --with-ssl=openssl" \
		|| myconf="${myconf} --without-ssl"

		econf --localstatedir=/var --sysconfdir=/etc/dovecot \
		--with-ioloop=best --with-poll=best \
		$(use_enable debug) \
		$(use_enable ipv6) \
		$(use_with kerberos gssapi) \
		$(use_with ldap) \
		$(use_with mysql) \
		$(use_with pam) \
		$(use_with pop3d) \
		$(use_with postgres pgsql) \
		$(use_with vpopmail) \
		${myconf} || die "configure failed"
	emake || die "make failed"

	if use sieve ; then
		einfo "Building sieve"
		cd "${SIEVE_S}"
		econf --with-dovecot="${S}" || die "configure failed"
		emake || die "make failed"
	fi
}

src_install () {
	make DESTDIR="${D}" install || die "make install failed"

	newinitd "${FILESDIR}"/dovecot.init dovecot

	# Documentation
	rm -rf "${D}"/usr/share/doc/dovecot
	dodoc AUTHORS NEWS README TODO dovecot-example.conf
	if use doc ; then
		dodoc doc/*.txt
	else
		local x= n=
		for x in doc/*.txt ; do
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
	if use mbox ; then
		mail_location="mbox:/var/spool/mail/%u:INDEX=/var/dovecot/%u"
		keepdir /var/dovecot
		sed -i -e 's|#mail_extra_groups =|mail_extra_groups = mail|' "${conf}"
	fi
	sed -i -e \
		"s|#mail_location =|mail_location = ${mail_location}|" "${conf}" || die

	# We're using pam files (imap and pop3) provided by mailbase
	if use pam ; then
		sed -i -e '/passdb pam/, /^[ \t]*}/ s|#args = dovecot|args = "\*"|' \
			"${conf}" || die
	fi

	# Listen on ipv6 and ipv4
	if use ipv6 ; then
		sed -i -e 's/^#listen = \*/listen = \[::\]/g' "${conf}" || die
	fi

	# Install SQL configuration
	if use mysql || use postgres ; then
		cp doc/dovecot-sql.conf "${D}"/etc/dovecot
		fperms 600 /etc/dovecot/dovecot-sql.conf
		sed -i -e '/db sql/,/args/ s|=|= /etc/dovecot-sql.conf|' "${conf}"
		dodoc doc/dovecot-sql.conf
	fi

	# Install LDAP configuration
	if use ldap ; then
		cp doc/dovecot-ldap.conf "${D}"/etc/dovecot
		fperms 600 /etc/dovecot/dovecot-ldap.conf
		sed -i -e '/db ldap/,/args/ s|=|= /etc/dovecot-ldap.conf|' "${conf}"
		dodoc doc/dovecot-ldap.conf
	fi

	# Create SSL certificates
	if use ssl ; then
		dodir /etc/ssl/certs
		dodir /etc/ssl/private
		# Let's not make a new certificate if we already have one
		if ! [[ -e /etc/ssl/certs/dovecot.pem && \
			-e /etc/ssl/private/dovecot.pem ]]; then
			einfo "Generating X.509 certificate for SSL"
			pushd doc >/dev/null && \
				SSLDIR="${D}"/etc/ssl sh mkcert.sh && \
				popd >/dev/null
		fi
		dodoc doc/*.cnf doc/mkcert.sh
	fi

	# Install sieve plugin
	if use sieve ; then
		make -C "${SIEVE_S}" DESTDIR="${D}" install || die "make install failed"
	fi

	dodir /var/run/dovecot
	fowners root:0 /var/run/dovecot
	fperms 0700 /var/run/dovecot
	keepdir /var/run/dovecot/login
	fowners root:dovecot /var/run/dovecot/login
	fperms 0750 /var/run/dovecot/login
}

get_config_var() {
	sed -n 's/^[[:space:]]\?base_dir[[:space:]]*="*\([^#"]\+\)"*/\1/p' \
		/etc/dovecot/dovecot.conf
}

pkg_postinst() {
	einfo "The dovecot configuration has vastly changed since 0.99."
	einfo "You are encouraged to start afresh with a new configuration file."
	einfo "see http://wiki.dovecot.org/ for configuration examples."

	if [[ -e ${ROOT}etc/dovecot.conf ]] ; then
		ewarn
		ewarn "dovecot configuration is now in ${ROOT}etc/dovecot"
	fi

	local base_dir="$(get_config_var base_dir)"
	base_dir="${basedir:-/var/run/dovecot}"
	if use ssl \
		&& [[ ! -e "${ROOT}/${base_dir}/login/ssl-parameters.dat" ]] ; then
		einfo
		einfo "Dovecot requires DH SSL Parameters if you use SSL connections"
		einfo "These take some time to make, and dovecot will create them before"
		einfo "it allows any SSL connections."
		einfo "You can create them now before starting dovecot like so"
		einfo "   emerge --config =${PF}"
	fi
}

pkg_config() {
	local base_dir="$(get_config_var base_dir)"
	base_dir="${base_dir:-/var/run/dovecot}"

	einfo "Regenerating SSL parameters. This will take some time."
	/usr/libexec/dovecot/ssl-build-param "${base_dir}/login/ssl-parameters.dat"
}
