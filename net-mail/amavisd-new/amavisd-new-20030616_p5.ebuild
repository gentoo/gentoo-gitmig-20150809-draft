# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/amavisd-new/amavisd-new-20030616_p5.ebuild,v 1.8 2004/01/14 19:53:04 max Exp $

inherit eutils

DESCRIPTION="High-performance interface between the MTA and content checkers."
HOMEPAGE="http://www.ijs.si/software/amavisd/"
SRC_URI="http://www.ijs.si/software/amavisd/${PN}-${PV/_/-}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE="ldap mysql postgres milter"

DEPEND=">=sys-apps/sed-4"

RDEPEND="${DEPEND}
	>=sys-apps/coreutils-5.0-r3
	app-arch/gzip
	app-arch/bzip2
	app-arch/arc
	app-arch/lha
	app-arch/unarj
	app-arch/unrar
	app-arch/zoo
	dev-perl/Archive-Tar
	dev-perl/Archive-Zip
	dev-perl/Compress-Zlib
	dev-perl/Convert-TNEF
	dev-perl/Convert-UUlib
	dev-perl/MIME-Base64
	dev-perl/MIME-tools
	>=dev-perl/MailTools-1.58
	dev-perl/net-server
	>=dev-perl/libnet-1.12
	dev-perl/Digest-MD5
	dev-perl/IO-stringy
	dev-perl/Time-HiRes
	dev-perl/Unix-Syslog
	dev-perl/Mail-SpamAssassin
	ldap? ( dev-perl/perl-ldap )
	mysql? ( dev-perl/DBD-mysql )
	postgres? ( dev-perl/DBD-Pg )
	virtual/antivirus
	virtual/mta"

S="${WORKDIR}/${PN}-${PV/_*/}"

src_compile() {
	if [ -n "`use milter`" ] ; then
		cd "${S}/helper-progs"

		econf --with-runtime-dir=/var/run/amavis \
			--with-sockname=/var/run/amavis/amavisd.sock \
			--with-user=amavis
		emake || die "compile problem"

		cd "${S}"
	fi
}

src_install() {
	enewgroup amavis
	enewuser amavis -1 /bin/false /var/lib/amavis amavis

	dosbin amavisd

	insinto /etc
	doins amavisd.conf
	dosed "s:^#\\?\\\$MYHOME[^;]*;:\$MYHOME = '/var/run/amavis';:" \
		/etc/amavisd.conf
	dosed "s:^#\\?\\\$daemon_user[^;]*;:\$daemon_user = 'amavis';:" \
		/etc/amavisd.conf
	dosed "s:^#\\?\\\$daemon_group[^;]*;:\$daemon_group = 'amavis';:" \
		/etc/amavisd.conf
	if [ "$(domainname)" = "(none)" ] ; then
		dosed "s:^#\\?\\\$mydomain[^;]*;:\$mydomain = '$(hostname)';:" \
			/etc/amavisd.conf
	else
		dosed "s:^#\\?\\\$mydomain[^;]*;:\$mydomain = '$(domainname)';:" \
			/etc/amavisd.conf
	fi

	exeinto /etc/init.d
	newexe "${FILESDIR}/amavisd.rc6" amavisd

	keepdir /var/spool/amavis /var/run/amavis
	fowners amavis:amavis /var/spool/amavis /var/run/amavis
	fperms 0750 /var/spool/amavis /var/run/amavis

	dodoc AAAREADME.first INSTALL LICENSE MANIFEST RELEASE_NOTES README_FILES/*
	docinto samples
	dodoc test-messages/*

	if [ -n "`use milter`" ] ; then
		cd "${S}/helper-progs"
		einstall
	fi
}
