# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/vimap/vimap-2001a.ebuild,v 1.2 2003/02/13 14:43:18 vapier Exp $

PN0=imap
S=${WORKDIR}/${PN0}-${PV}
DESCRIPTION="Linuxconf style virtual domain patched UW server daemons for IMAP and POP network mail protocols."
SRC_URI="ftp://ftp.cac.washington.edu/${PN0}/${PN0}-${PV}.tar.Z"
HOMEPAGE="http://www.washington.edu/imap/ http://vimap.sf.net/"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~x86 ~sparc "
IUSE="ssl kerberos"

PROVIDE="virtual/imapd"
DEPEND="!net-mail/uw-imap
	virtual/glibc
	>=sys-libs/pam-0.72
	>=sys-apps/xinetd-2.3.3
	ssl? ( dev-libs/openssl )
	kerberos? ( app-crypt/krb5 )"

src_unpack() {
	unpack ${A}

	# Set CFLAGS
	cd ${S}/src/osdep/unix/
	cp Makefile Makefile.orig
	sed \
		-e "s:-g -fno-omit-frame-pointer -O6:${CFLAGS}:" \
		-e "s:SSLDIR=/usr/local/ssl:SSLDIR=/usr:" \
		-e "s:SSLCERTS=\$(SSLDIR)/certs:SSLCERTS=/etc/ssl/certs:" \
		< Makefile.orig > Makefile
	cd ${S}

	bzcat ${FILESDIR}/imap-2001a-timeout.patch.bz2 | patch -p1 \
		|| die "patch 1 failed"
		
	bzcat ${FILESDIR}/imap-2000-linux.patch.bz2 | patch -p1 \
		|| die "patch 2 failed"
		
	bzcat ${FILESDIR}/imap-2001a-mbox-disable.patch.bz2 | patch -p0 \
		|| die "patch 3 failed"
		
	if use kerberos; then
		bzcat ${FILESDIR}/imap-2000-krbpath.patch.bz2 | patch -p1 \
			|| die "patch 4 failed"
	fi
	
	bzcat ${FILESDIR}/imap-2000c-redhat-flock.patch.bz2 | patch -p1 \
		|| die "patch 5 failed"
			
	bzcat ${FILESDIR}/imap-2001a-overflow.patch.bz2 | patch -p1 \
		|| die "patch 6 failed"
			
	bzcat ${FILESDIR}/imap-2001a-gentoo-version.patch.bz2 | patch -p0 \
		|| die "patch 7 failed"
			
	bzcat ${FILESDIR}/imap-2001a-boguswarning.patch.bz2 | patch -p0 \
		|| die "patch 8 failed"
			
	bzcat ${FILESDIR}/imap-2000-time.patch.bz2 | patch -p1 \
		|| die "patch 9 failed"
			
	bzcat ${FILESDIR}/imap-2001a-virtual.patch.bz2 | patch -p1 \
		|| die "patch 10 failed"
			
	bzcat ${FILESDIR}/flock.c.bz2 > src/osdep/unix/flock.c \
		|| die "patch 11 failed"
}

src_compile() {                           
	cd ${S}
	EXTRACFLAGS=" -DDISABLE_POP_PROXY=1 -DIGNORE_LOCK_EACCES_ERRORS=1 \
		-DDISABLE_REVERSE_DNS_LOOKUP"
	if use ssl; then
		EXTRACFLAGS=" ${EXTRACFLAGS} -I/usr/include/openssl"
		SSLFLAGTHINGS="SPECIALAUTHENTICATORS=ssl SSLTYPE=unix"
	fi
	if use kerberos; then
		EXTRACFLAGS=" ${EXTRACFLAGS} -I/usr/include/kerberosIV"
		KRBFLAGTHINGS="EXTRAAUTHENTICATORS=gss"
	fi
	make lnv EXTRACFLAGS="${EXTRACFLAGS}" ${KRBFLAGTHINGS} ${SSLFLAGTHINGS} \
		|| die
	if use ssl; then
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
	fi
}

src_install() {                               
	into /usr
	dosbin imapd/imapd ipopd/ipop?d

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
	newins ${FILESDIR}/uw-ipop3s.xinetd ipop3s
	newins ${FILESDIR}/uw-imaps.xinetd imaps
}
