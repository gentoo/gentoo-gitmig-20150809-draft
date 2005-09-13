# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/dovecot/dovecot-1.0_alpha2.ebuild,v 1.2 2005/09/13 21:42:06 wschlich Exp $

IUSE="debug ipv6 ldap maildir mbox pam postgres sasl ssl gnutls vpopmail nopop3d mysql"
inherit eutils

DESCRIPTION="An IMAP and POP3 server written with security primarily in mind"
HOMEPAGE="http://dovecot.org/"
MY_P="${P/_/.}"
S="${WORKDIR}/${MY_P}"
SRC_URI="http://dovecot.org/releases/${MY_P}.tar.gz"

SLOT="0"
LICENSE="LGPL-2.1"
KEYWORDS="~alpha ~amd64 ~ppc ~sparc ~x86"

#PROVIDE="virtual/imapd"

# Note: current dovecot will break on gnutls
# http://www.dovecot.org/list/dovecot/2004-November/005169.html
DEPEND=">=sys-libs/db-3.2
	>=sys-apps/sed-4
	ldap? ( >=net-nds/openldap-1.2 )
	pam? ( sys-libs/pam )
	sasl? ( >=dev-libs/cyrus-sasl-2.1 )
	ssl? ( >=dev-libs/openssl-0.9.6g )
	postgres? ( dev-db/postgresql )
	mysql? ( dev-db/mysql )
	vpopmail? ( net-mail/vpopmail )"
	#gnutls? ( <=net-libs/gnutls-1.0.4 )

RDEPEND="${DEPEND}
	>=net-mail/mailbase-0.00-r8"

pkg_setup() {
	# Add user and group for login process (same as for fedora/redhat)
	enewgroup dovecot 97
	enewuser dovecot 97 -1 /dev/null dovecot
}

src_compile() {
	local myconf=''
	useq debug && myconf="${myconf} --enable-debug"
	useq ldap && myconf="${myconf} --with-ldap"
	useq ipv6 || myconf="${myconf} --disable-ipv6"
	useq nopop3d && myconf="${myconf} --without-pop3d"
	useq pam || myconf="${myconf} --without-pam"
	useq postgres && myconf="${myconf} --with-pgsql"
	useq mysql && myconf="${myconf} --with-mysql"
	useq sasl && myconf="${myconf} --with-cyrus-sasl2"
	# gnutls support no longer working
	# (http://www.dovecot.org/list/dovecot/2004-November/005169.html)
	useq ssl && myconf="${myconf} --with-ssl=openssl"
	if useq gnutls; then
		eerror
		eerror 'GNUTLS support no longer available, see'
		eerror 'http://www.dovecot.org/list/dovecot/2004-November/005169.html'
		eerror
		eerror 'Please set USE="-gnutls ssl" if you want SSL support.'
		eerror
		die
	fi
	# prefer gnutls to ssl if both gnutls and ssl are defined
	#use gnutls && myconf="${myconf} --with-ssl=gnutls"
	#use ssl && ! use gnutls && myconf="${myconf} --with-ssl=openssl"
	#! use gnutls && ! use ssl && myconf="${myconf} --without-ssl"
	useq vpopmail || myconf="${myconf} --without-vpopmail"

	./configure \
		--prefix=/usr \
		--host=${CHOST} \
		--mandir=/usr/share/man \
		--infodir=/usr/share/info \
		--datadir=/usr/share \
		--sysconfdir=/etc \
		--localstatedir=/var \
		${myconf} || die "configure failed"
	emake || die "make failed"
}

src_install () {
	einstall || die "make install failed"

	# rc script
	exeinto /etc/init.d
	newexe ${FILESDIR}/dovecot.init dovecot

	# Create the dovecot.conf file from the dovecot-example.conf file that
	# the dovecot folks nicely left for us....
	mv ${D}/etc/dovecot-example.conf ${D}/etc/dovecot.conf

	# ...changing the default mail spool locations to the Gentoo defaults.  
	if useq mbox; then
		if useq maildir; then
			ewarn "Both mbox and maildir USE flags set, using mbox"
		fi
		# /var/spool/mail/$USER mail spool
		# The location of the INDEX may be overridden by the user if desired.
		if [ -z ${DOVECOT_INDEX_PATH} ]; then
			DOVECOT_INDEX_PATH='/var/dovecot/%u'
			dodir /var/dovecot
		fi
		sed -i -e \
			"s|#default_mail_env =|default_mail_env = mbox:/var/spool/mail/%u:INDEX=${DOVECOT_INDEX_PATH}|" \
			${D}/etc/dovecot.conf
		# enable dovecot to create dotlocks in /var/spool/mail
		sed -i -e \
			's|#mail_extra_groups =|mail_extra_groups = mail|' \
			${D}/etc/dovecot.conf
	elif useq maildir; then
		# $HOME/.maildir mail spool.  
		sed -i -e \
			's|#default_mail_env =|default_mail_env = maildir:%h/.maildir|' \
			${D}/etc/dovecot.conf
	else
		einfo "Both mbox and maildir USE flags unset, not modifying"
		einfo "default_mail_env in /etc/dovecot.conf"
	fi

	# PAM
	# We're using pam files (imap and pop3) provided by mailbase-0.00-r8
	if useq pam; then
		sed -i -e '/passdb pam {/,+10s:#args = .*:args = \*:' ${D}/etc/dovecot.conf
	fi

	# Documentation
	rm -rf ${D}/usr/share/doc/dovecot
	dodoc AUTHORS COPYING* NEWS README TODO dovecot-example.conf
	dodoc doc/*.txt doc/*.conf doc/*.cnf doc/mkcert.sh

	# Create SSL certificates
	if useq ssl || useq gnutls; then
		dodir /etc/ssl/certs
		dodir /etc/ssl/private
		# Let's not make a new certificate if we already have one
		if ! [[ -e /etc/ssl/certs/dovecot.pem && \
			-e /etc/ssl/private/dovecot.pem ]]; then
			einfo "Generating X.509 certificate for SSL"
			pushd doc >/dev/null && \
				SSLDIR=${D}/etc/ssl sh mkcert.sh && \
				popd >/dev/null
		fi
	fi

	dodir /var/run/dovecot
	fowners root:root /var/run/dovecot
	fperms 0700 /var/run/dovecot
	keepdir /var/run/dovecot/login
	fowners root:dovecot /var/run/dovecot/login
	fperms 0750 /var/run/dovecot/login
	fperms 0600 /etc/dovecot.conf
}

pkg_postinst() {
	if useq pam; then
		ewarn "If you are upgrading from Dovecot prior to 0.99.14-r1. be aware that the PAM"
		ewarn "profile usage was changed. Dovecot's services now use distinctive profiles,"
		ewarn "i.e. IMAP uses profile 'imap', POP3S uses profile 'pop3s', etc..."
		echo
		einfo "The above applies for default configuration (\"auth_passdb = pam *\")."
		einfo "These PAM profiles are provided by net-mail/mailbase ebuild."
		echo
	fi
	einfo "Please review /etc/dovecot.conf, particularly auth_userdb and auth_passdb."
}
