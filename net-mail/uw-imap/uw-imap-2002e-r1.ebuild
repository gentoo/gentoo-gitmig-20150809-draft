# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/uw-imap/uw-imap-2002e-r1.ebuild,v 1.7 2004/02/05 07:18:08 vapier Exp $

MY_P=imap-${PV}
S=${WORKDIR}/${MY_P}

DESCRIPTION="UW server daemons for IMAP and POP network mail protocols."
SRC_URI="ftp://ftp.cac.washington.edu/imap/${MY_P}.tar.Z"
HOMEPAGE="http://www.washington.edu/imap/"

LICENSE="as-is"
SLOT="0"
KEYWORDS="x86 sparc ppc hppa alpha amd64"
IUSE="ssl mbox pic"

PROVIDE="virtual/imapd"
PROVIDE="${PROVIDE} virtual/imap-c-client"
DEPEND="!net-mail/vimap
	!virtual/imap-c-client
	virtual/glibc
	>=sys-libs/pam-0.72
	ssl? ( dev-libs/openssl )"

src_unpack() {
	unpack ${A}
	# Tarball packed with bad file perms
	chmod -R ug+w ${S}

	use pic || use alpha && append-flags -fPIC

	cd ${S}/src/osdep/unix/
	cp Makefile Makefile.orig
	sed \
		-e 's,-g -fno-omit-frame-pointer -O6,${CFLAGS},g' \
		-e 's,SSLDIR=/usr/local/ssl,SSLDIR=/usr,g' \
		-e 's,SSLCERTS=$(SSLDIR)/certs,SSLCERTS=/etc/ssl/certs,g' \
		< Makefile.orig > Makefile

	# Uncomment this for MBX support
	#cp Makefile Makefile.orig2
	#sed \
	#	-e "s:CREATEPROTO=unixproto:CREATEPROTO=mbxproto:" \
	#	-e "s:EMPTYPROTO=unixproto:EMPTYPROTO=mbxproto:" \
	#	< Makefile.orig2 > Makefile
	cd ${S}
}

src_compile() {
	local extracflags
	use amd64 && extracflags=-fPIC
	if use ssl; then
		cd ${S}
		yes | make lnp EXTRACFLAGS="${extracflags}" SSLTYPE=unix || die

		local i
		for i in imapd ipop3d; do
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

			cat $$PEM1 >  ${i}.pem
			echo ""    >> ${i}.pem
			cat $$PEM2 >> ${i}.pem
			rm $$PEM1 $$PEM2
			umask 022
		done
	else
		yes | make lnp EXTRACFLAGS="${extracflags}" SSLTYPE=none || die
	fi
}

src_install() {
	into /usr
	dosbin imapd/imapd ipopd/ipop?d dmail/dmail tmail/tmail
	dobin mailutil/mailutil mlock/mlock mtest/mtest

	if use ssl; then
		dodir /etc/ssl/certs
		mv imapd.pem ${D}/etc/ssl/certs
		mv ipop3d.pem ${D}/etc/ssl/certs
	fi

	insinto /usr/include/imap
	doins c-client/{c-client,mail,imap4r1,rfc822,linkage,misc,smtp,nntp}.h
	doins c-client/{osdep,env_unix,env,fs,ftl,nl,tcp}.h
	dolib.a c-client/c-client.a
	dosym /usr/lib/c-client.a /usr/lib/libc-client.a

	doman src/ipopd/ipopd.8c src/imapd/imapd.8c
	doman src/dmail/dmail.1 src/tmail/tmail.1 src/mailutil/mailutil.1

	dodoc CPYRIGHT README docs/*.txt docs/CONFIG docs/RELNOTES

	docinto rfc
	dodoc docs/rfc/*.txt

	# gentoo config stuff
	insinto /etc/pam.d
	newins ${FILESDIR}/uw-imap.pam-system-auth imap
	newins ${FILESDIR}/uw-imap.pam-system-auth pop
	insinto /etc/xinetd.d
	newins ${FILESDIR}/uw-imap.xinetd  imap
	newins ${FILESDIR}/uw-ipop2.xinetd ipop2
	newins ${FILESDIR}/uw-ipop3.xinetd ipop3
	newins ${FILESDIR}/uw-ipop3s.xinetd ipop3s
	newins ${FILESDIR}/uw-imaps.xinetd imaps
}
