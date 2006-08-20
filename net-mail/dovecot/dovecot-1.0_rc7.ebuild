# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/dovecot/dovecot-1.0_rc7.ebuild,v 1.2 2006/08/20 12:28:03 uberlord Exp $

inherit autotools eutils

DESCRIPTION="An IMAP and POP3 server written with security primarily in mind"
HOMEPAGE="http://dovecot.org/"
MY_P="${P/_/.}"
S="${WORKDIR}/${MY_P}"
SRC_URI="http://dovecot.org/releases/${MY_P}.tar.gz"

SLOT="0"
LICENSE="LGPL-2.1"
KEYWORDS="~alpha ~amd64 ~ppc ~sparc ~x86"

IUSE="debug doc ipv6 kerberos ldap mbox mysql pop3d pam postgres ssl vpopmail"

DEPEND=">=sys-apps/sed-4
	kerberos? ( virtual/krb5 )
	ldap? ( net-nds/openldap )
	pam? ( virtual/pam )
	ssl? ( dev-libs/openssl )
	postgres? ( dev-db/postgresql )
	mysql? ( dev-db/mysql )
	vpopmail? ( net-mail/vpopmail )"

RDEPEND="${DEPEND}
	>=net-mail/mailbase-0.00-r8"

pkg_setup() {
	# Add user and group for login process (same as for fedora/redhat)
	enewgroup dovecot 97
	enewuser dovecot 97 -1 /dev/null dovecot
}

src_compile() {
	local myconf="--sysconfdir=/etc/dovecot --with-ioloop=best --with-poll=best"
	use ssl && myconf="${myconf} --with-ssl=openssl" \
		|| myconf="${myconf} --without-ssl"

	econf --localstatedir=/var \
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
}

src_install () {
	make DESTDIR="${D}" install || die "make install failed"

	newinitd "${FILESDIR}"/dovecot.init dovecot

	# Create the dovecot.conf file from the dovecot-example.conf file that
	# the dovecot folks nicely left for us....
	local conf="${D}/etc/dovecot/dovecot.conf"
	mv "${D}"/etc/dovecot/dovecot-example.conf "${D}"/etc/dovecot/dovecot.conf
	fperms 0600 /etc/dovecot/dovecot.conf

	# .maildir is the Gentoo default, but we need to support mbox to
	local mailenv="maildir:%h/.maildir"
	if use mbox ; then
		mailenv="mbox:/var/spool/mail/%u:INDEX=/var/dovecot/%u"
		keepdir /var/dovecot
		sed -i -e 's|#mail_extra_groups =|mail_extra_groups = mail|' "${conf}"
	fi
	sed -i -e \
		"s|#default_mail_env =|default_mail_env = ${mailenv}|" "${conf}" || die

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
	fi

	# Install LDAP configuration
	if use ldap ; then
		cp doc/dovecot-ldap.conf "${D}"/etc/dovecot
		fperms 600 /etc/dovecot/dovecot-ldap.conf
		sed -i -e '/db ldap/,/args/ s|=|= /etc/dovecot-ldap.conf|' "${conf}"
	fi

	# Documentation
	rm -rf "${D}"/usr/share/doc/dovecot
	if use doc ; then
		dodoc AUTHORS NEWS README TODO dovecot-example.conf
		dodoc doc/*.txt doc/*.conf doc/*.cnf doc/mkcert.sh
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
