# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/net-snmp/net-snmp-5.1.1-r1.ebuild,v 1.2 2004/08/03 22:02:52 genone Exp $

inherit eutils

DESCRIPTION="Software for generating and retrieving SNMP data"
HOMEPAGE="http://net-snmp.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~arm ~hppa ~amd64 ~ia64 ~s390 ~ppc64"
IUSE="perl ipv6 ssl tcpd X lm_sensors"

PROVIDE="virtual/snmp"
DEPEND="virtual/libc
	<sys-libs/db-2
	>=sys-libs/zlib-1.1.4
	>=sys-apps/sed-4
	ssl? ( >=dev-libs/openssl-0.9.6d )
	tcpd? ( >=sys-apps/tcp-wrappers-7.6 )
	perl? (
		>=sys-devel/libperl-5.8.0
		>=dev-perl/ExtUtils-MakeMaker-6.11-r1
	)
	lm_sensors? (
		x86?   ( sys-apps/lm-sensors )
		amd64? ( sys-apps/lm-sensors )
	)"
RDEPEND="${DEPEND}
	perl? ( X? ( dev-perl/perl-tk ) )
	!virtual/snmp"

src_unpack() {
	unpack ${A}
	cd ${S}

	if use lm_sensors; then
		if use x86 || use amd64; then
			epatch ${FILESDIR}/${PN}-lm_sensors.patch
		else
			eerror "Unfortunatly you are trying to enable lm_sensors support for an unsupported arch."
			eerror "please check the availability of sys-apps/lm-sensors - if it is available on"
			eerror "your arch, please file a bug about this."
			die "lm_sensors patch error: unsupported arch."
		fi
	fi
}

src_compile() {
	local myconf
	myconf="${myconf} `use_enable perl embedded-perl`"
	myconf="${myconf} `use_with ssl openssl` `use_enable !ssl internal-md5`"
	myconf="${myconf} `use_with tcpd libwrap`"
	myconf="${myconf} `use_enable ipv6`"

	econf \
		--with-sys-location="Unknown" \
		--with-sys-contact="root@Unknown" \
		--with-default-snmp-version="3" \
		--with-mib-modules="host smux ucd-snmp/dlmod" \
		--with-logfile=/var/log/net-snmpd.log \
		--with-persistent-directory=/var/lib/net-snmp \
		--enable-ucd-snmp-compatibility \
		--enable-shared \
		--with-zlib \
		${myconf} || die "econf failed"

	emake -j1 || die "compile problem"

	if use perl ; then
		emake perlmodules || die "compile perl modules problem"
	fi
}

src_install () {
	einstall exec_prefix="${D}/usr" persistentdir="${D}/var/lib/net-snmp"

	if use perl ; then
		make DESTDIR="${D}" perlinstall || die "make perlinstall failed"
		if ! use X ; then
			rm -f "${D}/usr/bin/tkmib"
		fi
	else
		rm -f "${D}/usr/bin/mib2c" "${D}/usr/bin/tkmib"
	fi

	dodoc AGENT.txt ChangeLog FAQ INSTALL NEWS PORTING README* TODO
	newdoc EXAMPLE.conf.def EXAMPLE.conf

	exeinto /etc/init.d
	newexe "${FILESDIR}/snmpd-5.1.rc6" snmpd
	insinto /etc/conf.d
	newins "${FILESDIR}/snmpd-5.1.conf" snmpd

	keepdir /etc/snmp /var/lib/net-snmp
}
