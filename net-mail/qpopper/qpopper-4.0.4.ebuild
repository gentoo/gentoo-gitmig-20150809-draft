# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $ Header: $

PN0=qpopper
S=${WORKDIR}/${PN0}4.0.4
DESCRIPTION="Qpopper enables a unix/linux machine to act as a Post Office Protocol version 3 (pop) server"
SRC_URI="ftp://ftp.qualcomm.com/eudora/servers/unix/popper/${PN0}4.0.4.tar.gz"
HOMEPAGE="http://www.qpopper.org/"

DEPEND="virtual/glibc \
	  sys-libs/gdbm \
	  sys-apps/xinetd \
	  pam? ( >=sys-libs/pam-0.72 ) \
	  ssl? ( dev-libs/openssl )"
KEYWORDS="x86"
LICENSE="GPL"
SLOT="0"

src_unpack() {
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
		mkdir -p -m665 ${D}/etc/mail/certs
		chown root.mail ${D}/etc/mail/certs
		chmod 660 ${D}/etc/mail/certs
		mv cert.pem ${D}/etc/mail/certs
		chmod 600 ${D}/etc/mail/certs/cert.pem
		chown root.0 ${D}/etc/mail/certs/cert.pem
	fi

	doman man/popauth.8  man/poppassd.8  man/popper.8

	dodoc GUIDE.pdf

	docinto rfc
	dodoc doc/rfc*.txt

    # gentoo config stuff
	if use pam; then
		insinto /etc/pam.d
		newins ${FILESDIR}/pop3.pam-system-auth pop3
	fi

	insinto /etc/xinetd.d
	newins ${FILESDIR}/pop3.xinetd  pop-3

	echo "----------------------------------------------------------------"
	echo " PS. If you use APOP service to authenticate "
	echo " the users you have to follow these steps: "
	echo " 1) create a new account named pop;"
	echo " 2) change the owner and permissions of"
	echo "	  /usr/sbin/popauth:"
	echo "	  # chown pop /usr/sbin/popauth"
	echo "	  # chmod u+s /usr/sbin/popauth"
	echo " 3) initialize the authentication database:"
	echo "	  # popauth -init"
	echo " 4) new users can be added by root:"
	echo "	  # popauth -user <user>"
	echo "	  or removed:"
	echo "	  # popauth -delete <user>"
	echo "	  Other users can add themeselves or change their"
	echo " 	  password with the command: popauth"
	echo " 5) scripts or other non-interactive processes can add or change"
	echo "    the passwords with the following command:"
	echo "	  # popauth -user <user> <password>"
	echo "-----------------------------------------------------------------"
}
