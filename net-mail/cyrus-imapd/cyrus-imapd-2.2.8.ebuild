# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/cyrus-imapd/cyrus-imapd-2.2.8.ebuild,v 1.7 2004/10/20 21:22:47 swegener Exp $

inherit eutils ssl-cert gnuconfig fixheadtails

DESCRIPTION="The Cyrus IMAP Server."
HOMEPAGE="http://asg.web.cmu.edu/cyrus/imapd/"
SRC_URI="ftp://ftp.andrew.cmu.edu/pub/cyrus-mail/${P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="x86 ~sparc ~amd64 ~ppc hppa"
IUSE="afs drac kerberos pam snmp ssl tcpd"

PROVIDE="virtual/imapd"
RDEPEND=">=sys-libs/db-3.2
	>=dev-libs/cyrus-sasl-2.1.13
	afs? ( >=net-fs/openafs-1.2.2 )
	pam? ( >=sys-libs/pam-0.75 )
	kerberos? ( virtual/krb5 )
	snmp? ( virtual/snmp )
	ssl? ( >=dev-libs/openssl-0.9.6 )
	tcpd? ( >=sys-apps/tcp-wrappers-7.6 )
	drac? ( >=mail-client/drac-1.12-r1 )"

DEPEND="$RDEPEND
	sys-devel/libtool
	>=sys-devel/autoconf-2.58
	sys-devel/automake
	>=sys-apps/sed-4"


src_unpack() {
	unpack ${A} && cd "${S}"

	ht_fix_file ${S}/imap/xversion.sh

	# Add drac database support.
	if use drac ; then
		epatch "${S}/contrib/drac_auth.patch"
	fi

	# Add libwrap defines as we don't have a dynamicly linked library.
	if use tcpd ; then
		epatch "${FILESDIR}/${PN}-libwrap.patch"
	fi

	# DB4 detection and versioned symbols.
	epatch "${FILESDIR}/${P}-db4.patch"

	# Fix master(8)->cyrusmaster(8) manpage.
	for i in `grep -rl -e 'master\.8' -e 'master(8)' "${S}"` ; do
		sed -e 's:master\.8:cyrusmaster.8:g' \
			-e 's:master(8):cyrusmaster(8):g' \
			-i "${i}" || die "sed failed"
	done
	mv man/master.8 man/cyrusmaster.8
	sed -e "s:MASTER:CYRUSMASTER:g" \
		-e "s:Master:Cyrusmaster:g" \
		-e "s:master:cyrusmaster:g" \
		-i man/cyrusmaster.8 || die "sed failed"

	# Recreate configure.
	export WANT_AUTOCONF="2.5"
	gnuconfig_update
	rm -rf configure config.h.in autom4te.cache || die
	ebegin "Recreating configure"
	sh SMakefile &>/dev/null || die "SMakefile failed"
	eend $?

	# When linking with rpm, you need to link with more libraries.
	sed -e "s:lrpm:lrpm -lrpmio -lrpmdb:" -i configure || die "sed failed"
}

src_compile() {
	local myconf
	myconf="${myconf} `use_with afs`"
	myconf="${myconf} `use_with drac`"
	myconf="${myconf} `use_with ssl openssl`"
	myconf="${myconf} `use_with snmp ucdsnmp`"
	myconf="${myconf} `use_with tcpd libwrap`"
	myconf="${myconf} `use_enable kerberos gssapi`"

	econf \
		--enable-murder \
		--enable-listext \
		--enable-netscapehack \
		--with-extraident=Gentoo \
		--with-service-path=/usr/lib/cyrus \
		--with-cyrus-user=cyrus \
		--with-cyrus-group=mail \
		--with-com_err=yes \
		--with-auth=unix \
		--without-perl \
		--disable-cyradm \
		${myconf} || die "econf failed"

	emake || die "compile problem"
}

src_install() {
	dodir /usr/bin /usr/lib
	for subdir in master imap imtest timsieved notifyd ; do
		make -C "${subdir}" DESTDIR="${D}" install || die "make install failed"
	done

	# Link master to cyrusmaster (postfix has a master too)
	dosym /usr/lib/cyrus/master /usr/lib/cyrus/cyrusmaster

	doman man/*.[0-8]
	dodoc COPYRIGHT README*
	dohtml doc/*.html doc/murder.png
	cp doc/cyrusv2.mc "${D}/usr/share/doc/${PF}/html"
	cp -r contrib tools "${D}/usr/share/doc/${PF}"
	find "${D}/usr/share/doc" -name CVS -print0 | xargs -0 rm -rf

	insinto /etc
	newins "${FILESDIR}/imapd.conf" imapd.conf
	newins "${FILESDIR}/cyrus.conf" cyrus.conf

	exeinto /etc/init.d
	newexe "${FILESDIR}/cyrus.rc6" cyrus

	if use pam ; then
		insinto /etc/pam.d
		newins "${FILESDIR}/imap.pam" imap
	fi

	if use ssl ; then
		SSL_ORGANIZATION="${SSL_ORGANIZATION:-Cyrus IMAP Server}"
		insinto /etc/ssl/cyrus
		docert server
		fowners cyrus:mail /etc/ssl/cyrus/server.{key,pem}
	fi

	for subdir in imap/{,db,log,msg,proc,socket} spool/imap/{,stage.} ; do
		keepdir "/var/${subdir}"
		fowners cyrus:mail "/var/${subdir}"
		fperms 0750 "/var/${subdir}"
	done
	for subdir in imap/{user,quota,sieve} spool/imap ; do
		for i in a b c d e f g h i j k l m n o p q r s t v u w x y z ; do
			keepdir "/var/${subdir}/${i}"
			fowners cyrus:mail "/var/${subdir}/${i}"
			fperms 0750 "/var/${subdir}/${i}"
		done
	done
}

pkg_postinst() {
	ewarn "*****NOTE*****"
	ewarn "If you're upgrading from versions prior to 2.2.2_BETA"
	ewarn "be sure to read the following thoroughly:"
	ewarn "http://asg.web.cmu.edu/cyrus/download/imapd/install-upgrade.html"
	ewarn "*****NOTE*****"
	echo

	ewarn "If you change the fs-type of /var/imap or"
	ewarn "/var/spool/imap you should read step 9 of"
	ewarn "/usr/share/doc/${P}/html/install-configure.html."
	echo

	if df -T /var/imap | grep -q ' ext[23] ' ; then
		ebegin "Making /var/imap/user/* and /var/imap/quota/* synchronous."
		chattr +S /var/imap/{user,quota}{,/*}
		eend $?
	fi

	if df -T /var/spool/imap | grep -q ' ext[23] ' ; then
		ebegin "Making /var/spool/imap/* synchronous."
		chattr +S /var/spool/imap{,/*}
		eend $?
	fi

	ewarn "If the queue directory of the mail daemon resides on an ext2"
	ewarn "or ext3 filesystem you need to set it manually to update"
	ewarn "synchronously. E.g. 'chattr +S /var/spool/mqueue'."
	echo

	einfo "For correct logging add the following to /etc/syslog.conf:"
	einfo "    local6.*         /var/log/imapd.log"
	einfo "    auth.debug       /var/log/auth.log"
	echo

	ewarn "You have to add user cyrus to the sasldb2. Do this with:"
	ewarn "    saslpasswd2 cyrus"
}
