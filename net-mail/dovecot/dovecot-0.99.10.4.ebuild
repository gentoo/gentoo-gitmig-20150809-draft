# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/dovecot/dovecot-0.99.10.4.ebuild,v 1.1 2004/04/10 14:21:11 g2boojum Exp $

IUSE="debug ipv6 ldap maildir pam postgres sasl ssl vpopmail nopop3d"

DESCRIPTION="An IMAP and POP3 server written with security primarily in mind"
HOMEPAGE="http://dovecot.procontrol.fi/"
SRC_URI="${HOMEPAGE}/${P}.tar.gz"

SLOT="0"
LICENSE="LGPL-2.1"
KEYWORDS="~x86"

#PROVIDE="virtual/imapd"

# Note: current dovecot will break on gnutls-1.0.5
DEPEND=">=sys-libs/db-3.2
	>=sys-apps/sed-4
	ldap? ( >=net-nds/openldap-1.2 )
	pam? ( sys-libs/pam )
	sasl? ( >=dev-libs/cyrus-sasl-2.1 )
	ssl? ( >=dev-libs/openssl-0.9.6g )
	gnutls? ( <=net-libs/gnutls-1.0.4 )
	postgres? ( dev-db/postgresql )
	vpopmail? ( net-mail/vpopmail )"

RDEPEND="${DEPEND}
	net-mail/mailbase"


pkg_preinst() {
	# Add user and group for login process
	if ! getent group | grep -q ^dovecot
	then
		groupadd dovecot || die "problem adding group dovecot"
	fi
	if ! getent passwd | grep -q ^dovecot
	then
		useradd -c dovecot -d /usr/libexec/dovecot -g dovecot \
		-s /bin/false dovecot  || die "problem adding user dovecot"
	fi
}

src_compile() {
	local myconf
	use debug && myconf="--enable-debug"
	use ldap && myconf="${myconf} --with-ldap"
	use ipv6 || myconf="${myconf} --disable-ipv6"
	use nopop3d && myconf="${myconf} --without-pop3d"
	use pam || myconf="${myconf} --without-pam"
	use postgres && myconf="${myconf} --with-pgsql"
	use sasl && myconf="${myconf} --with-cyrus-sasl2"
	use gnutls && myconf="${myconf} --with-ssl=gnutls"
	use ssl && myconf="${myconf} --with-ssl=openssl"
	! use gnutls && ! use ssl && myconf="${myconf} --without-ssl"
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
	make DESTDIR=${D} install || die

	# If /etc/dovecot.conf doesn't already exist, install a copy of
	# dovecot-example.conf, changing the default mailbox locations to
	# Gentoo's default ($HOME/.maildiir/ or /var/spool/mail/$USER)
	if [ ! -e /etc/dovecot.conf ]; then
		cd ${D}/etc
		if [ "`use maildir`" ]; then
			sed s/^#default_mail_env.*$/default_mail_env\ =\ maildir:%h\\/.maildir/	dovecot-example.conf > dovecot.conf
		else
			sed s/^#default_mail_env.*$/default_mail_env\ =\ mbox:\\/var\\/spool\\/mail\\/%u/ dovecot-example.conf > dovecot.conf
		fi
		cd -
	fi
	rm -f ${D}/etc/dovecot-example.conf

	# Documentation
	rm -fr ${D}/usr/share/doc/dovecot
	cd ${S}
	dodoc AUTHORS COPYING* NEWS README TODO dovecot-example.conf
	dodoc doc/*.txt doc/*.conf doc/*.cnf

	# per default dovecot wants it ssl cert called dovecot.pem
	# fix this in mkcert.sh, which we use to generate the ssl certs
	cd ${S}/doc
	mv mkcert.sh mkcert.sh.tmp
	sed s/imapd.pem/dovecot.pem/g mkcert.sh.tmp > mkcert.sh
	dodoc mkcert.sh

	# rc script
	exeinto /etc/init.d
	newexe ${FILESDIR}/dovecot.init dovecot

	# PAM
	if [ "`use pam`" ]; then
		dodir /etc/pam.d
		insinto /etc/pam.d
		newins ${FILESDIR}/dovecot.pam dovecot
	fi

	# Create SSL certificates
	if [ "`use ssl`" || "`use gnutls`" ]; then
		cd ${S}/doc
		dodir /etc/ssl/certs
		dodir /etc/ssl/private
		[ -e /etc/ssl/certs/dovecot.pem -a -e /etc/ssl/private/dovecot.pem ] \
			|| SSLDIR=${D}/etc/ssl sh mkcert.sh
	fi

	dodir /var/run/dovecot
	fowners root:root /var/run/dovecot
	fperms 0700 /var/run/dovecot
	keepdir /var/run/dovecot/login
	fowners root:dovecot /var/run/dovecot/login
	fperms 0750 /var/run/dovecot/login
}

pkg_postinst() {
	if [ "`use pam`" ]; then
		ewarn "If you are upgrading from Dovecot prior to 0.99.10, be aware"
		ewarn "that the PAM profile was changed from 'imap' to 'dovecot'."
		einfo "Please review /etc/pam.d/dovecot."
	fi
	einfo "Please review /etc/dovecot.conf, particularly auth_userdb and auth_passdb."
}
