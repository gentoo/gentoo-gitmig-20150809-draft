# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-filter/amavisd-new/amavisd-new-2.3.2.ebuild,v 1.8 2005/08/23 13:12:06 ticho Exp $

inherit eutils

DESCRIPTION="High-performance interface between the MTA and content checkers."
HOMEPAGE="http://www.ijs.si/software/amavisd/"
SRC_URI="http://www.ijs.si/software/amavisd/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ppc ppc64 ~sparc x86"
IUSE="ldap mysql postgres milter"

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
	dev-perl/Compress-Zlib
	dev-perl/Convert-TNEF
	>=dev-perl/Convert-UUlib-1.051
	perl-core/MIME-Base64
	>=dev-perl/MIME-tools-5.415
	>=dev-perl/MailTools-1.58
	dev-perl/net-server
	>=dev-perl/libnet-1.16
	dev-perl/IO-stringy
	>=perl-core/Time-HiRes-1.49
	dev-perl/Unix-Syslog
	>=sys-libs/db-3.1
	dev-perl/BerkeleyDB
	virtual/mta
	virtual/antivirus
	ldap? ( >=dev-perl/perl-ldap-0.33 )
	mysql? ( dev-perl/DBD-mysql )
	postgres? ( dev-perl/DBD-Pg )
	milter? ( >=mail-mta/sendmail-8.12 )"

AMAVIS_ROOT=/var/amavis

src_unpack() {
	if ! $(has_version ">=mail-filter/spamassassin-3.0.0") ; then
		echo
		ewarn "WARNING: Amavisd-new will not work with SpamAssassin older than 3.0.0."
		ewarn "         Consider upgrading your SpamAssassin installation."
		ebeep 3
		sleep 5
	fi
	unpack ${A}
	cd ${S}
	if $(has_version mail-mta/courier) ; then
		einfo "Patching with courier support."
		epatch "amavisd-new-courier.patch" || die "patch failed"
	fi

	if $(has_version mail-mta/qmail) || $(has_version mail-mta/qmail-ldap) ; then
		einfo "Patching with qmail qmqp support."
		epatch "amavisd-new-qmqpqq.patch" || die "patch failed"

		einfo "Patching with qmail lf bug workaround."
		epatch "${FILESDIR}/${PN}-2.2.1-qmail-lf-workaround.patch" || die "patch failed"
	fi

	epatch "${FILESDIR}/${PN}-2.3.0-amavisd.conf-gentoo.patch" || die "patch failed"
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
	dosbin amavisd amavisd-agent amavisd-nanny

	insinto /etc
	insopts -m0640
	newins amavisd.conf-sample amavisd.conf
	fowners root:amavis /etc/amavisd.conf
	dosed "s:^#\\?\\\$MYHOME[^;]*;:\$MYHOME = '$AMAVIS_ROOT';:" \
		/etc/amavisd.conf
	if [ "$(domainname)" = "(none)" ] ; then
		dosed "s:^#\\?\\\$mydomain[^;]*;:\$mydomain = '$(hostname)';:" \
			/etc/amavisd.conf
	else
		dosed "s:^#\\?\\\$mydomain[^;]*;:\$mydomain = '$(domainname)';:" \
			/etc/amavisd.conf
	fi
	if ! $(has_version mail-filter/spamassassin) ; then
		einfo "Disabling anti-spam code in amavisd.conf..."

		dosed "s:^#[\t ]*@bypass_spam_checks_maps[\t ]*=[\t ]*(1);:\@bypass_spam_checks_maps = (1);:" \
			/etc/amavisd.conf
	fi

	newinitd "${FILESDIR}/amavisd.rc6" amavisd
	dosed "s:/var/run/amavis/:$AMAVIS_ROOT/:g" /etc/init.d/amavisd

	keepdir ${AMAVIS_ROOT}
	keepdir ${AMAVIS_ROOT}/db
	keepdir ${AMAVIS_ROOT}/quarantine
	keepdir ${AMAVIS_ROOT}/tmp

	if $(has_version net-nds/openldap ) ; then
		einfo "Adding ${P} schema to openldap schema dir."
		dodir /etc/openldap/schema
		insinto /etc/openldap/schema
		insopts -o root -g root -m 644
		newins LDAP.schema ${PN}.schema || die
		newins LDAP.schema ${PN}.schema.default || die
	fi

	newdoc test-messages/README README.samples
	dodoc AAAREADME.first INSTALL LICENSE MANIFEST RELEASE_NOTES \
		README_FILES/* test-messages/sample-* amavisd.conf-default amavisd-agent

	if use milter ; then
		cd "${S}/helper-progs"
		einstall
	fi

	for i in whitelist blacklist spam_lovers; do
		if [ ! -f ${D}/${AMAVIS_ROOT}/${i} ]; then
			touch ${D}/${AMAVIS_ROOT}/${i}
		fi
	done

	if $(has_version mail-filter/razor) ; then
		if [ ! -f ${AMAVIS_ROOT}/.razor/razor-agent.conf ] ; then
			einfo "Setting up initial razor config files..."

			razor-admin -create -home=${D}/${AMAVIS_ROOT}/.razor
			sed -i -e "s:debuglevel\([ ]*\)= .:debuglevel\1= 0:g" \
				${D}/${AMAVIS_ROOT}/.razor/razor-agent.conf
		else
			einfo "Copying existing razor config files..."
			insinto ${AMAVIS_ROOT}/.razor
			doins ${AMAVIS_ROOT}/.razor/*.{conf,lst}
		fi
	fi

	chown -R amavis:amavis ${D}/${AMAVIS_ROOT}
	find ${D}/${AMAVIS_ROOT} -name "*" -type d -exec chmod 0750 \{\} \;
	find ${D}/${AMAVIS_ROOT} -name "*" -type f -exec chmod 0640 \{\} \;
}

pkg_postinst() {
	enewgroup amavis
	enewuser amavis -1 -1 ${AMAVIS_ROOT} amavis

	if ! $(has_version mail-filter/spamassassin) ; then
		echo
		einfo "Amavisd-new no longer requires SpamAssassin, but no anti-spam checking"
		einfo "will be performed without it. Since you do not have SpamAssassin installed,"
		einfo "all spam checks have been disabled. To enable them, install SpamAssassin"
		einfo "and comment out the line containing: "
		einfo "@bypass_spam_checks_maps = (1); in /etc/amavisd.conf."
	fi
	echo
	ewarn "Adjusting permissions for /etc/amavisd.conf (0 for world, owner root:amavis)"
	echo
	chmod o-rwx /etc/amavisd.conf
	chown root:amavis /etc/amavisd.conf
}
