# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/cyrus-imap-dev/cyrus-imap-dev-2.2.3.ebuild,v 1.2 2004/01/20 23:57:09 max Exp $

inherit eutils

DESCRIPTION="Developer support for the Cyrus IMAP Server."
HOMEPAGE="http://asg.web.cmu.edu/cyrus/imapd/"
SRC_URI="ftp://ftp.andrew.cmu.edu/pub/cyrus-mail/cyrus-imapd-${PV}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~x86"
IUSE="afs kerberos snmp ssl tcpd"

DEPEND="virtual/glibc
	sys-devel/libtool
	sys-devel/autoconf
	sys-devel/automake
	>=sys-apps/sed-4
	>=sys-libs/db-3.2
	>=dev-libs/cyrus-sasl-2.1.12
	afs? ( >=net-fs/openafs-1.2.2 )
	kerberos? ( >=app-crypt/mit-krb5-1.2.6 )
	snmp? ( >=net-analyzer/ucd-snmp-4.2.3 )
	ssl? ( >=dev-libs/openssl-0.9.6 )
	tcpd? ( >=sys-apps/tcp-wrappers-7.6 )"

S="${WORKDIR}/cyrus-imapd-${PV}"

src_unpack() {
	unpack ${A} && cd "${S}"

	# Add libwrap defines as we don't have a dynamicly linked library.
	if [ "`use tcpd`" ] ; then
		epatch "${FILESDIR}/cyrus-imapd-libwrap.patch"
	fi

	# DB4 detection and versioned symbols.
	epatch "${FILESDIR}/cyrus-imapd-${PV}-db4.patch"

	# Recreate configure.
	export WANT_AUTOCONF="2.5"
	ebegin "Recreating configure"
	rm -f configure config.h.in
	sh SMakefile &>/dev/null || die "SMakefile failed"
	eend $?

	# When linking with rpm, you need to link with more libraries.
	sed -e "s:lrpm:lrpm -lrpmio -lrpmdb:" -i configure || die "sed failed"
}

src_compile() {
	local myconf
	myconf="${myconf} `use_with afs`"
	myconf="${myconf} `use_with ssl openssl`"
	myconf="${myconf} `use_with snmp ucdsnmp`"
	myconf="${myconf} `use_with tcpd libwrap`"
	myconf="${myconf} `use_enable kerberos gssapi`"

	econf \
		--enable-murder \
		--enable-listext \
		--enable-netscapehack \
		--with-cyrus-group=mail \
		--with-com_err=yes \
		--with-auth=unix \
		--without-perl \
		--disable-cyradm \
		${myconf}

	emake -C "${S}/lib" all || die "compile problem"
}

src_install() {
	dodir /usr/include/cyrus

	make -C "${S}/lib" DESTDIR="${D}" install || die "make install failed"
	dodoc COPYRIGHT README*
}
