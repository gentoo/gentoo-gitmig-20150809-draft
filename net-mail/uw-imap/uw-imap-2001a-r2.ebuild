# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/net-mail/uw-imap/uw-imap-2001a-r2.ebuild,v 1.5 2002/08/18 00:22:47 raker Exp $

PN0=imap
S=${WORKDIR}/${PN0}-${PV}
DESCRIPTION="UW server daemons for IMAP and POP network mail protocols."
SRC_URI="ftp://ftp.cac.washington.edu/${PN0}/${PN0}-${PV}.tar.Z"
HOMEPAGE="http://www.washington.edu/imap/"
PROVIDE="virtual/imapd"
DEPEND="virtual/glibc >=sys-libs/pam-0.72 ssl? ( dev-libs/openssl )"


LICENSE="as-is"
SLOT="0"
KEYWORDS="x86 sparc sparc64"

src_unpack() {
	unpack ${A}
	cd ${S}/src/osdep/unix/
	sed "s:-g -fno-omit-frame-pointer -O6:${CFLAGS}:" Makefile > Makefile.bak
	mv Makefile.bak Makefile
	cd ${S}
	patch -p1 < ${FILESDIR}/gentoo.diff || die
}

src_compile() {                           
	if use ssl; then
		cd ${S}
		make lnp SPECIALAUTHENTICATORS=ssl SSLTYPE=unix || die
	# I was SO tempted to add -DY4KBUGFIX to the EXTRACFLAGS... 
	# but I didn't.  S0meday s00n.

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
		make lnp EXTRACFLAGS=-DMAILSUBDIR=\"mail\" || die
	fi
}

src_install() {                               
	into /usr
	dosbin imapd/imapd ipopd/ipop?d

	if use ssl; then
		mkdir -p ${D}/usr/ssl/certs
		mv imapd.pem ${D}/usr/ssl/certs
		mv ipop3d.pem ${D}/usr/ssl/certs
	fi

	insinto /usr/include/imap
	doins c-client/{c-client,mail,imap4r1,rfc822,linkage,misc,smtp,nntp}.h
	doins c-client/{osdep,env_unix,env,fs,ftl,nl,tcp}.h
	dolib.a c-client/c-client.a
	dosym /usr/lib/c-client.a /usr/lib/libc-client.a

	doman src/ipopd/ipopd.8c src/imapd/imapd.8c

	dodoc CPYRIGHT README docs/*.txt docs/CONFIG docs/FAQ docs/RELNOTES

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
	newins ${FILESDIR}/uw-imaps.xinetd imaps
}
