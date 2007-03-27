# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-filter/amavisd-new/amavisd-new-2.4.5-r1.ebuild,v 1.2 2007/03/27 17:43:22 ticho Exp $

inherit eutils

DESCRIPTION="High-performance interface between the MTA and content checkers."
HOMEPAGE="http://www.ijs.si/software/amavisd/"
SRC_URI="http://www.ijs.si/software/amavisd/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="courier ldap milter mysql postgres qmail"

DEPEND=">=sys-apps/sed-4
	>=dev-lang/perl-5.8.2"

RDEPEND="${DEPEND}
	>=sys-apps/coreutils-5.0-r3
	app-arch/gzip
	app-arch/bzip2
	app-arch/arc
	app-arch/cabextract
	app-arch/freeze
	app-arch/lha
	app-arch/unarj
	app-arch/unrar
	app-arch/zoo
	dev-perl/Archive-Tar
	>=dev-perl/Archive-Zip-1.14
	>=dev-perl/Compress-Zlib-1.35
	dev-perl/Convert-TNEF
	>=dev-perl/Convert-UUlib-1.08
	virtual/perl-MIME-Base64
	>=dev-perl/MIME-tools-5.415
	>=dev-perl/MailTools-1.58
	>=dev-perl/net-server-0.91
	>=virtual/perl-libnet-1.16
	dev-perl/IO-stringy
	>=virtual/perl-Time-HiRes-1.49
	dev-perl/Unix-Syslog
	>=sys-libs/db-3.1
	dev-perl/BerkeleyDB
	virtual/mta
	ldap? ( >=dev-perl/perl-ldap-0.33 )
	mysql? ( dev-perl/DBD-mysql )
	postgres? ( dev-perl/DBD-Pg )
	milter? ( || ( >=mail-mta/sendmail-8.12 mail-filter/libmilter ) )"

AMAVIS_ROOT="/var/amavis"

pkg_preinst() {
	enewgroup amavis
	enewuser amavis -1 -1 ${AMAVIS_ROOT} amavis
}

src_unpack() {
	unpack ${A}
	cd "${S}"

	if use courier ; then
		elog "Patching with courier support."
		epatch amavisd-new-courier.patch
	fi

	if use qmail ; then
		elog "Patching with qmail qmqp support."
		epatch amavisd-new-qmqpqq.patch
	fi

	epatch "${FILESDIR}/${PN}-2.4.4-amavisd.conf-gentoo.patch"
}

src_compile() {
	if use milter ; then
		cd "${S}/helper-progs"

		econf --with-runtime-dir=${AMAVIS_ROOT} \
			--with-sockname=${AMAVIS_ROOT}/amavisd.sock \
			--with-user=amavis || die "helper-progs econf failed"
		emake || die "helper-progs compile problem"

		cd "${S}"
	fi
}

src_install() {
	dosbin amavisd amavisd-agent amavisd-nanny amavisd-release
	dobin p0f-analyzer.pl

	insinto /etc
	insopts -m0640
	newins amavisd.conf-sample amavisd.conf

	dosed "s:^#\\?\\\$MYHOME[^;]*;:\$MYHOME = '$AMAVIS_ROOT';:" \
		/etc/amavisd.conf

	newinitd "${FILESDIR}/amavisd.rc6" amavisd
	dosed "s:/var/run/amavis/:$AMAVIS_ROOT/:g" /etc/init.d/amavisd

	keepdir ${AMAVIS_ROOT}
	keepdir ${AMAVIS_ROOT}/db
	keepdir ${AMAVIS_ROOT}/quarantine
	keepdir ${AMAVIS_ROOT}/tmp

	newdoc test-messages/README README.samples
	dodoc AAAREADME.first INSTALL LICENSE MANIFEST RELEASE_NOTES \
		README_FILES/* test-messages/sample* amavisd.conf-default amavisd-agent

	if use milter ; then
		cd "${S}/helper-progs"
		einstall
		cd "${S}"
	fi

	for i in whitelist blacklist spam_lovers; do
		if [ -f ${AMAVIS_ROOT}/${i} ]; then
			cp "${AMAVIS_ROOT}/${i}" "${D}/${AMAVIS_ROOT}"
		else
			touch ${D}/${AMAVIS_ROOT}/${i}
		fi
	done

	if use ldap ; then
		elog "Adding ${P} schema to openldap schema dir."
		dodir /etc/openldap/schema
		insinto /etc/openldap/schema
		insopts -o root -g root -m 644
		newins LDAP.schema ${PN}.schema || die
		newins LDAP.schema ${PN}.schema.default || die
	fi

	find ${D}/${AMAVIS_ROOT} -name "*" -type d -exec chmod 0750 \{\} \;
	find ${D}/${AMAVIS_ROOT} -name "*" -type f -exec chmod 0640 \{\} \;
}

pkg_preinst() {
	if [ -z "$(dnsdomainname)" ] ; then
		dosed "s:^#\\?\\\$mydomain[^;]*;:\$mydomain = '$(hostname)';:" \
			/etc/amavisd.conf
	else
		dosed "s:^#\\?\\\$mydomain[^;]*;:\$mydomain = '$(dnsdomainname)';:" \
			/etc/amavisd.conf
	fi

	if has_version mail-filter/razor ; then
		if [ ! -d ${AMAVIS_ROOT}/.razor ] ; then
			elog "Setting up initial razor config files..."

			razor-admin -create -home=${D}/${AMAVIS_ROOT}/.razor
			sed -i -e "s:debuglevel\([ ]*\)= .:debuglevel\1= 0:g" \
				${D}/${AMAVIS_ROOT}/.razor/razor-agent.conf
		fi
	fi
}

pkg_postinst() {
	if ! has_version mail-filter/spamassassin ; then
		echo
		elog "Amavisd-new no longer requires SpamAssassin, but no anti-spam checking"
		elog "will be performed without it. Since you do not have SpamAssassin installed,"
		elog "all spam checks have been disabled. To enable them, install SpamAssassin"
		elog "and comment out the line containing: "
		elog "@bypass_spam_checks_maps = (1); in /etc/amavisd.conf."
	fi
	echo
	ewarn "As of amavisd-new-2.4.5 p0f-analyzer.pl only binds to the loopback interface"
	ewarn "by default instead of to all interfaces. You will need to change $bind_addr"
	ewarn "in p0f-analyzer.pl to '0.0.0.0' if p0f-analyzer.pl is running on a different"
	ewarn "host from amavisd or from other querying clients."
	echo
	ewarn "Adjusting permissions for /etc/amavisd.conf (0 for world, owner root:amavis)"
	echo
	chmod o-rwx /etc/amavisd.conf
	chown root:amavis /etc/amavisd.conf
	chown -R amavis:amavis ${AMAVIS_ROOT}
}
