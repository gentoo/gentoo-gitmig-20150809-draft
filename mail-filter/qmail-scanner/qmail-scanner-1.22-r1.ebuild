# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-filter/qmail-scanner/qmail-scanner-1.22-r1.ebuild,v 1.1 2004/07/17 09:07:13 st_lim Exp $

inherit fixheadtails gcc eutils

DESCRIPTION="E-Mail virus scanner for qmail."
HOMEPAGE="http://qmail-scanner.sourceforge.net/"
SRC_URI="mirror://sourceforge/qmail-scanner/${P}.tgz
	spamassassin? (http://xoomer.virgilio.it/j.toribio/qmail-scanner/download/q-s-1.22st-20040606.patch.gz)"

IUSE="spamassassin"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~sparc"

DEPEND=">=dev-lang/perl-5.6.1-r1
	>=dev-perl/Time-HiRes-01.20-r2
	>=net-mail/tnef-1.1.1
	>=dev-perl/DB_File-1.803-r2
	>=net-mail/ripmime-1.3.0.4
	|| (
	>=mail-mta/qmail-1.03-r8
	>=mail-mta/qmail-ldap-1.03-r1
	  mail-mta/qmail-mysql
	)
	>=app-arch/unzip-5.42-r1
	spamassassin ( >=mail-filter/spamassassin-2.63 )
	virtual/antivirus"

pkg_setup() {
	enewgroup qscand 210
	enewuser qscand 210 /bin/false /var/spool/qmailscan qscand
}

pkg_preinst() {
	local oldname="/var/qmail/bin/qmail-scanner-queue.pl"
	if [ -f ${oldname} ]; then
		newname=${oldname}.`date +%Y%m%d%H%M%S`
		einfo "Backing up old qmail-scanner as $newname in case of modifications."
		cp ${oldname} ${newname}
		chmod 600 ${newname}
	fi
}

src_unpack() {
	unpack ${A}
	cd ${S}
	use spamassassin && epatch ${DISTDIR}/q-s-1.22st-20040606.patch.gz
	ht_fix_file autoupdaters/* configure

	EXTRA_VIRII="bagle,beagle,mydoom,sco,maldal,mimail,novarg,shimg"
	einfo "Adding items to the SILENT_VIRUSES list (${EXTRA_VIRII})"
	sed -e "/^SILENT_VIRUSES/s/\"$/,${EXTRA_VIRII}\"/g"  -i configure
}

src_compile () {
	local myconf
	use spamassassin && myconf="--virus-to-delete yes --sa-quarantine 2.1 --sa-delete 4.2 --sa-reject yes --sa-subject SPAM: --sa-delta 0.5 --sa-alt yes"

	PATH=${PATH}:/opt/f-prot:/opt/vlnx ./configure \
	--domain localhost \
	--batch \
	--log-details yes \
	--mime-unpacker "ripmime" \
	${myconf} \
	|| die "./configure failed!"

	# build for qmail-scanner-queue wrapper, so we don't need suidperl
	cd contrib
	`gcc-getCC` ${CFLAGS} -o qmail-scanner-queue qmail-scanner-queue.c || die
}

src_install () {
	# Create Directory Structure
	diropts -m 755 -o qscand -g qscand
	dodir /var/spool/qmailscan
	keepdir /var/spool/qmailscan
	for i in quarantine working archive; do
		for j in tmp new cur; do
			dodir /var/spool/qmailscan/${i}/${j}
			keepdir /var/spool/qmailscan/${i}/${j}
		done
	done
	dodir /var/spool/qmailscan/tmp
	keepdir /var/spool/qmailscan/tmp

	# Install standard quarantine attachments file
	insinto /var/spool/qmailscan
	insopts -m 644 -o qscand -g qscand
	doins quarantine-attachments.txt

	# create quarantine.log and viruses.log
	touch quarantine.log
	insinto /var/spool/qmailscan
	insopts -m 644 -o qscand -g qscand
	doins quarantine.log
	dosym quarantine.log ${DESTDIR}/var/spool/qmailscan/viruses.log

	# Install qmail-scanner wrapper
	insinto /var/qmail/bin
	insopts -m 4755 -o qscand -g qscand
	doins contrib/qmail-scanner-queue

	# Install qmail-scanner script
	insinto /var/qmail/bin
	insopts -m 0755 -o qscand -g qscand
	doins qmail-scanner-queue.pl

	insinto /etc/logrotate.d/
	insopts -m 644 -o root -g root
	newins ${FILESDIR}/qmailscanner.logrotate qmail-scanner

	exeinto /etc/cron.daily/
	newexe ${FILESDIR}/qmailscanner.cronjob qmail-scanner

	# Install documentation
	dodoc README CHANGES COPYING
	dohtml README.html FAQ.php TODO.php configure-options.php manual-install.php perlscanner.php

	docinto contrib
	cd contrib
	dodoc qs2mrtg.pl mrtg-qmail-scanner.cfg
}

pkg_postinst () {
	einfo "Fixing ownerships"
	chown -R qscand:qscand /var/spool/qmailscan/tmp /var/spool/qmailscan/working /var/spool/qmailscan/quarantine* /var/spool/qmailscan/archive /var/spool/qmailscan/qmail*
	touch /var/qmail/bin/qmail-scanner-queue.pl

	# Setup perlscanner + Version Info
	chmod -s ${ROOT}/var/qmail/bin/qmail-scanner-queue.pl
	${ROOT}/var/qmail/bin/qmail-scanner-queue -z
	${ROOT}/var/qmail/bin/qmail-scanner-queue -g

	einfo "To activate qmail-scanner, please edit your"
	einfo "/var/qmail/control/conf-common file and set:"
	einfo "export QMAILQUEUE=/var/qmail/bin/qmail-scanner-queue"
	einfo "Or place it in your tcprules file."
	ewarn "Please note that it was a call to qmail-scanner-queue.pl before,"
	ewarn "but this is now changed to use a wrapper to improve security!"
	ewarn "Once you have changed to the wrapper, you can remove the setuid "
	ewarn "bit on qmail-scanner-queue.pl"
}
