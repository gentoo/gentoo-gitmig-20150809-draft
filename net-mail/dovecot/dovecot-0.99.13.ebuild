# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/dovecot/dovecot-0.99.13.ebuild,v 1.3 2005/03/31 23:54:09 wschlich Exp $

IUSE="debug ipv6 ldap mbox pam postgres sasl ssl gnutls vpopmail nopop3d mysql"
inherit eutils

DESCRIPTION="An IMAP and POP3 server written with security primarily in mind"
HOMEPAGE="http://dovecot.org/"
SRC_URI="http://dovecot.org/releases/${P}.tar.gz"

SLOT="0"
LICENSE="LGPL-2.1"
KEYWORDS="x86 ~amd64 ~sparc ~ppc"

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
	net-mail/mailbase"


pkg_setup() {
	# Add user and group for login process (same as for fedora/redhat)
	enewgroup dovecot 97
	enewuser dovecot 97 /bin/false /dev/null dovecot
}

src_compile() {
	local myconf
	use debug && myconf="--enable-debug"
	use ldap && myconf="${myconf} --with-ldap"
	use ipv6 || myconf="${myconf} --disable-ipv6"
	use nopop3d && myconf="${myconf} --without-pop3d"
	use pam || myconf="${myconf} --without-pam"
	use postgres && myconf="${myconf} --with-pgsql"
	use mysql && myconf="${myconf} --with-mysql"
	use sasl && myconf="${myconf} --with-cyrus-sasl2"
	# gnutls support no longer working
	# (http://www.dovecot.org/list/dovecot/2004-November/005169.html)
	use ssl && myconf="${myconf} --with-ssl=openssl"
	if use gnutls; then
		eerror 'GNUTLS support no longer available, see'
		eerror 'http://www.dovecot.org/list/dovecot/2004-November/005169.html'
		eerror
		eerror 'Please set USE="-gnutls ssl" if you want TLS support.'
		die
	fi
	# prefer gnutls to ssl if both gnutls and ssl are defined
	#use gnutls && myconf="${myconf} --with-ssl=gnutls"
	#use ssl && ! use gnutls && myconf="${myconf} --with-ssl=openssl"
	#! use gnutls && ! use ssl && myconf="${myconf} --without-ssl"
	use vpopmail || myconf="${myconf} --without-vpopmail"

	./configure \
	  --prefix=/usr \
	  --host=${CHOST} \
	  --mandir=/usr/share/man \
	  --infodir=/usr/share/info \
	  --datadir=/usr/share \
	  --sysconfdir=/etc \
	  --localstatedir=/var \
	  ${myconf} || die "configure failed"
	emake || die
}

src_install () {
	# Create the dovecot.conf file from the dovecot-example.conf file that
	# the dovecot folks nicely left for us, changing the default
	# mail spool locations to the Gentoo defaults.  
	if use mbox
	then
		# /var/spool/mail/$USER mail spool
		# The location of the INDEX may be overridden by the user if desired.
		if [ -z ${DOVECOT_INDEX_PATH} ]
		then
			DOVECOT_INDEX_PATH="/var/dovecot/%d/%n"
			dodir /var/dovecot
		fi
		sed -e \
			"s|#default_mail_env =|#default_mail_env = mbox:/var/spool/mail/%u:INDEX=${DOVECOT_INDEX_PATH}|" \
			dovecot-example.conf > dovecot.conf
	else
		# $HOME/.maildir mail spool.  
		sed -e \
			's|#default_mail_env =|default_mail_env = maildir:%h/.maildir|' \
			dovecot-example.conf > dovecot.conf
	fi
	insinto /etc
	doins dovecot.conf

	make DESTDIR=${D} install || die
	rm ${D}/etc/dovecot-example.conf

	# Documentation
	rm -fr ${D}/usr/share/doc/dovecot
	cd ${S}
	dodoc AUTHORS COPYING* NEWS README TODO dovecot-example.conf
	dodoc doc/*.txt doc/*.conf doc/*.cnf

	# per default dovecot wants it ssl cert called dovecot.pem
	# fix this in mkcert.sh, which we use to generate the ssl certs
	cd ${S}/doc
	sed -i -e 's/imapd.pem/dovecot.pem/g' mkcert.sh
	dodoc mkcert.sh

	# rc script
	exeinto /etc/init.d
	newexe ${FILESDIR}/dovecot.init dovecot

	# PAM
	if use pam
	then
		dodir /etc/pam.d
		insinto /etc/pam.d
		newins ${FILESDIR}/dovecot.pam dovecot
	fi

	# Create SSL certificates
	if  use ssl || use gnutls
	then
		cd ${S}/doc
		dodir /etc/ssl/certs
		dodir /etc/ssl/private
		# Let's not make a new certificate if we already have one
		[ -e /etc/ssl/certs/dovecot.pem -a -e /etc/ssl/private/dovecot.pem ] \
			|| SSLDIR=${D}/etc/ssl sh mkcert.sh
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
	if use pam
	then
		ewarn "If you are upgrading from Dovecot prior to 0.99.10, be aware"
		ewarn "that the PAM profile was changed from 'imap' to 'dovecot'."
		einfo "Please review /etc/pam.d/dovecot."
	fi
	einfo "Please review /etc/dovecot.conf, particularly auth_userdb and auth_passdb."
}
