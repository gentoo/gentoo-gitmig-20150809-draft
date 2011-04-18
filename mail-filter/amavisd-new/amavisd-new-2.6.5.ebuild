# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-filter/amavisd-new/amavisd-new-2.6.5.ebuild,v 1.2 2011/04/18 10:46:22 eras Exp $

inherit eutils multilib

DESCRIPTION="High-performance interface between the MTA and content checkers."
HOMEPAGE="http://www.ijs.si/software/amavisd/"
SRC_URI="http://www.ijs.si/software/amavisd/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ppc ~ppc64 ~sparc ~x86"
IUSE="courier dkim ldap milter mysql postgres qmail razor spamassassin"

DEPEND=">=sys-apps/sed-4
	>=dev-lang/perl-5.8.2
	milter? ( || ( mail-filter/libmilter >=mail-mta/sendmail-8.12 ) )"

RDEPEND="${DEPEND}
	>=sys-apps/coreutils-5.0-r3
	app-arch/gzip
	app-arch/bzip2
	app-arch/arc
	app-arch/cabextract
	app-arch/freeze
	app-arch/lha
	app-arch/unarj
	|| ( app-arch/unrar app-arch/rar )
	app-arch/zoo
	>=dev-perl/Archive-Zip-1.14
	>=virtual/perl-IO-Compress-1.35
	dev-perl/Convert-TNEF
	>=dev-perl/Convert-UUlib-1.08
	virtual/perl-MIME-Base64
	>=dev-perl/MIME-tools-5.415
	>=dev-perl/MailTools-1.58
	>=dev-perl/net-server-0.91
	virtual/perl-Digest-MD5
	dev-perl/IO-stringy
	>=virtual/perl-Time-HiRes-1.49
	dev-perl/Unix-Syslog
	>=sys-libs/db-3.2
	dev-perl/BerkeleyDB
	dev-perl/Convert-BinHex
	>=dev-perl/Mail-DKIM-0.31
	virtual/mta
	ldap? ( >=dev-perl/perl-ldap-0.33 )
	mysql? ( dev-perl/DBD-mysql )
	postgres? ( dev-perl/DBD-Pg )
	razor? ( mail-filter/razor )
	spamassassin? ( mail-filter/spamassassin )"

AMAVIS_ROOT="/var/amavis"

src_unpack() {
	unpack ${A}
	cd "${S}"

	if use courier ; then
		epatch amavisd-new-courier.patch
	fi

	if use qmail ; then
		epatch amavisd-new-qmqpqq.patch
	fi

	epatch "${FILESDIR}/${PN}-2.6.3-amavisd.conf-gentoo.patch"

	if ! use dkim ; then
		epatch "${FILESDIR}/${PN}-2.6.3-dkimconf.patch"
	fi
}

src_compile() {
	if use milter ; then
		cd "${S}/helper-progs"

		econf --with-runtime-dir=${AMAVIS_ROOT} \
			--with-sockname=${AMAVIS_ROOT}/amavisd.sock \
			--with-user=amavis \
			--with-milterlib="/usr/$(get_libdir)" || die "helper-progs econf failed"
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
	dodoc AAAREADME.first INSTALL MANIFEST RELEASE_NOTES README_FILES/README.* \
		test-messages/sample* amavisd.conf-default amavisd-agent \
		amavisd-custom.conf

	dodir /usr/share/doc/${PF}/html
	insinto /usr/share/doc/${PF}/html
	doins README_FILES/*.{html,css}
	dodir /usr/share/doc/${PF}/html/images
	insinto /usr/share/doc/${PF}/html/images
	doins README_FILES/images/*

	if use milter ; then
		cd "${S}/helper-progs"
		einstall
		cd "${S}"
	fi

	for i in whitelist blacklist spam_lovers; do
		if [ -f ${AMAVIS_ROOT}/${i} ]; then
			cp "${AMAVIS_ROOT}/${i}" "${D}/${AMAVIS_ROOT}"
		else
			touch "${D}"/${AMAVIS_ROOT}/${i}
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

	find "${D}"/${AMAVIS_ROOT} -name "*" -type d -exec chmod 0750 \{\} \;
	find "${D}"/${AMAVIS_ROOT} -name "*" -type f -exec chmod 0640 \{\} \;
}

pkg_preinst() {
	enewgroup amavis
	enewuser amavis -1 -1 ${AMAVIS_ROOT} amavis

	if [ -z "$(dnsdomainname)" ] ; then
		dosed "s:^#\\?\\\$mydomain[^;]*;:\$mydomain = '$(hostname)';:" \
			/etc/amavisd.conf
	else
		dosed "s:^#\\?\\\$mydomain[^;]*;:\$mydomain = '$(dnsdomainname)';:" \
			/etc/amavisd.conf
	fi

	if use razor ; then
		if [ ! -d ${AMAVIS_ROOT}/.razor ] ; then
			elog "Setting up initial razor config files..."

			razor-admin -create -home="${D}"/${AMAVIS_ROOT}/.razor
			sed -i -e "s:debuglevel\([ ]*\)= .:debuglevel\1= 0:g" \
				"${D}"/${AMAVIS_ROOT}/.razor/razor-agent.conf
		fi
	fi

	if ! use spamassassin ; then
		einfo "Disabling anti-spam code in amavisd.conf..."

		dosed "s:^#[\t ]*@bypass_spam_checks_maps[\t ]*=[\t ]*(1);:\@bypass_spam_checks_maps = (1);:" \
			/etc/amavisd.conf
	fi
}

pkg_postinst() {
	if ! use spamassassin ; then
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
