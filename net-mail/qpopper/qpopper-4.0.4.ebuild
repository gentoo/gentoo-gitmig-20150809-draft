# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later

PN0=qpopper
S=${WORKDIR}/${PN0}4.0.4
DESCRIPTION="Qpopper enables a unix/linux machine to act as a Post Office Protocol version 3 (pop) server"
SRC_URI="ftp://ftp.qualcomm.com/eudora/servers/unix/popper/${PN0}4.0.4.tar.gz
		http://www.ibiblio.org/gentoo/distfiles/qpopper-files.tar.bz2"
HOMEPAGE="http://www.qpopper.org/"

DEPEND="virtual/glibc \
      virtual/mta \
	  sys-libs/gdbm \
	  sys-apps/xinetd \
	  pam? ( >=sys-libs/pam-0.72 ) \
	  ssl? ( dev-libs/openssl )"
RDEPEND="${DEPEND}"

SLOT="0"
LICENSE="GPL"
KEYWORDS="x86 sparc sparc64"

src_unpack() {
	
	unpack qpopper-files.tar.bz2
	unpack ${A}
	cd ${S}
}

src_compile() {                           
	CO=" --enable-apop=/etc/pop.auth \
         --enable-popuid=pop \
         --enable-log-login \
         --enable-specialauth \
		 --enable-log-facility=LOG_MAIL \
		 --enable-debugging \
		 --enable-uw-kludge-flag \
	     --with-gdbm"

	if use ssl; then
		if use pam; then
			./configure ${CO} --with-openssl --with-pam=pop3
		else
			./configure ${CO} --with-openssl
		fi
		umask 077
	 	PEM1=`/bin/mktemp ${T}/openssl.XXXXXX`
		PEM2=`/bin/mktemp ${T}/openssl.XXXXXX`
		/usr/bin/openssl req -newkey rsa:1024 -keyout $$PEM1 \
				 -nodes -x509 -days 365 -out  $$PEM2 << EOF
--
SomeState
SomeCity
SomeOrganization
SomeOrganizationalUnit
localhost.localdomain
root@localhost.localdomain
EOF

		cat $$PEM1 >  cert.pem
		echo ""    >> cert.pem
		cat $$PEM2 >> cert.pem
		make || die
		rm $$PEM1 $$PEM2
		umask 022

	elif use pam; then
		./configure ${CO} --with-pam=pop3 || die
		make || die

	else
		./configure ${CO}
		make || die
	fi
}

src_install() {                               
	into /usr
	dosbin popper/popper  popper/popauth 

	if use ssl; then
      dodir /etc/mail/certs
      fowners root.mail /etc/mail/certs
      fperms 660 /etc/mail/certs
      mv cert.pem ${D}/etc/mail/certs
      fperms 600 /etc/mail/certs/cert.pem
      fowners root.0 /etc/mail/certs/cert.pem
	fi

	doman man/popauth.8  man/poppassd.8  man/popper.8

	dodoc ${WORKDIR}/GUIDE.pdf

	docinto rfc
	dodoc doc/rfc*.txt

	if use pam; then
		insinto /etc/pam.d
		newins ${WORKDIR}/pop3.pam-system-auth pop3
	fi

	insinto /etc/xinetd.d
	newins ${WORKDIR}/pop3.xinetd  pop-3

}

pkg_postinst () {
	einfo "----------------------------------------------------------------"
	einfo " PS. If you use APOP service to authenticate "
	einfo " the users you have to follow these steps: "
	einfo " 1) create a new account named pop;"
	einfo " 2) change the owner and permissions of"
	einfo "	  /usr/sbin/popauth:"
	einfo "	  # chown pop /usr/sbin/popauth"
	einfo "	  # chmod u+s /usr/sbin/popauth"
	einfo " 3) initialize the authentication database:"
	einfo "	  # popauth -init"
	einfo " 4) new users can be added by root:"
	einfo "	  # popauth -user <user>"
	einfo "	  or removed:"
	einfo "	  # popauth -delete <user>"
	einfo "	  Other users can add themeselves or change their"
	einfo " 	  password with the command: popauth"
	einfo " 5) scripts or other non-interactive processes can add or change"
	einfo "    the passwords with the following command:"
	einfo "	  # popauth -user <user> <password>"
	einfo "-----------------------------------------------------------------"
}
