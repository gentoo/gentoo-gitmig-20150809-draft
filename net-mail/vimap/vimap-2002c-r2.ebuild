# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/vimap/vimap-2002c-r2.ebuild,v 1.1 2005/02/18 22:23:50 ferdy Exp $

inherit eutils flag-o-matic

S=${WORKDIR}/imap-2002c1

DESCRIPTION="Linuxconf style virtual domain patched UW server daemons for IMAP and POP network mail protocols."
SRC_URI="ftp://ftp.cac.washington.edu/imap/imap-2002c1.tar.Z"
HOMEPAGE="http://www.washington.edu/imap/ http://vimap.sf.net/"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~sparc ~ppc ~hppa ~alpha"
IUSE="ssl"

PROVIDE="virtual/imapd"
PROVIDE="${PROVIDE} virtual/imap-c-client"

RDEPEND=">=net-mail/mailbase-0.00-r8"

DEPEND="
	!virtual/imap-c-client
	virtual/libc
	>=sys-libs/pam-0.72
	ssl? ( dev-libs/openssl )"

pkg_setup() {
	# Warn people with pam flag deactivated.
	if ! built_with_use net-mail/mailbase pam;
	then
		echo
		ewarn "It is recommended to have the net-mail/mailbase package"
		ewarn "  built with the pam use flag activated. Please rebuild"
		ewarn "  net-mail/mailbase with pam activated."
		echo
		epause 3
	fi
}
src_unpack() {
	unpack ${A}
	# Tarball packed with bad file perms
	chmod -R ug+w ${S}
	cd ${S}
	bzcat ${FILESDIR}/imap-2002c-virtual.patch.bz2 | patch -p0
	if use amd64; then
		# Now we must make all the individual Makefiles use different CFLAGS,
		# otherwise they would all use -fPIC
		sed -i -e "s|\`cat \$C/CFLAGS\`|${CFLAGS}|g" src/dmail/Makefile \
			src/imapd/Makefile src/ipopd/Makefile src/mailutil/Makefile \
			src/mlock/Makefile src/mtest/Makefile src/tmail/Makefile \
			|| die "sed failed patching Makefile CFLAGS."
		# Now there is only c-client left, which should be built with -fPIC
		append-flags -fPIC
		# Apply our patch to actually build the shared library for PHP5
		epatch ${FILESDIR}/${P}-amd64-so-fix.patch
	fi
	cd ${S}/src/osdep/unix/
	cp Makefile Makefile.orig
	sed \
		-e "s:BASECFLAGS=\".*\":BASECFLAGS=:g" \
		-e 's,SSLDIR=/usr/local/ssl,SSLDIR=/usr,g' \
		-e 's,SSLCERTS=$(SSLDIR)/certs,SSLCERTS=/etc/ssl/certs,g' \
		< Makefile.orig > Makefile
	cd ${S}
}

src_compile() {
	if use ssl; then
		cd ${S}

		yes | make lnp ${mymake} ${ipver} \
			SSLTYPE=unix EXTRACFLAGS="${CFLAGS}" EXTRALDFLAGS="-lcrypt" || die

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
		yes | make lnp ${mymake} ${ipver} \
			SSLTYPE=none EXTRACFLAGS="${CFLAGS}" EXTRALDFLAGS="-lcrypt" || die
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

	if use amd64; then
		dolib.so c-client/libc-client.so*
		cd ${D}/usr/$(get_libdir)
		ln -s libc-client.so.1.0.0 libc-client.so.1
		ln -s libc-client.so.1 libc-client.so
	fi

	cd ${S}

	insinto /usr/include/imap
	doins c-client/{c-client,mail,imap4r1,rfc822,linkage,misc,smtp,nntp}.h
	doins c-client/{osdep,env_unix,env,fs,ftl,nl,tcp}.h
	dolib.a c-client/c-client.a
	dosym /usr/$(get_libdir)/c-client.a /usr/$(get_libdir)/libc-client.a

	doman src/ipopd/ipopd.8c src/imapd/imapd.8c

	dodoc CPYRIGHT README docs/*.txt docs/CONFIG docs/RELNOTES

	docinto rfc
	dodoc docs/rfc/*.txt

	## pam.d files are provided by mailbase
	#   unless mailbase wasn't built with pam.
	if ! built_with_use net-mail/mailbase pam;
	then
		insinto /etc/pam.d
		newins ${FILESDIR}/uw-imap.pam-system-auth imap
		newins ${FILESDIR}/uw-imap.pam-system-auth pop
	fi

	insinto /etc/xinetd.d
	newins ${FILESDIR}/uw-imap.xinetd  imap
	newins ${FILESDIR}/uw-ipop2.xinetd ipop2
	newins ${FILESDIR}/uw-ipop3.xinetd ipop3
	newins ${FILESDIR}/uw-ipop3s.xinetd ipop3s
	newins ${FILESDIR}/uw-imaps.xinetd imaps
}
