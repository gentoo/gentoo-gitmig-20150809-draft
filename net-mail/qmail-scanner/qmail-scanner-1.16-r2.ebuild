# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/qmail-scanner/qmail-scanner-1.16-r2.ebuild,v 1.2 2004/01/29 05:26:42 robbat2 Exp $

S=${WORKDIR}/${P}

DESCRIPTION="E-Mail virus scanner for qmail."
HOMEPAGE="http://qmail-scanner.sourceforge.net/"
SRC_URI="mirror://sourceforge/qmail-scanner/${P}.tgz"

DEPEND=">=dev-lang/perl-5.6.1-r1
	>=dev-perl/Time-HiRes-01.20-r2
	>=net-mail/tnef-1.1.1
	>=net-mail/maildrop-1.3.9
	>=dev-perl/DB_File-1.803-r2
	>=net-mail/qmail-1.03-r8
	>=app-arch/unzip-5.42-r1
	virtual/antivirus"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 sparc"

inherit fixheadtails

src_unpack() {
	unpack ${A}
	cd ${S}
	ht_fix_file autoupdaters/update_macafee autoupdaters/update_trend autoupdaters/update_sophos configure
}

src_compile () {
	yes | PATH=${PATH}:/opt/f-prot:/opt/vlnx ./configure \
		--domain localhost \
			|| die "./configure failed!"
}

src_install () {
	# Create Directory Structure
	diropts -m 755 -o qmailq -g qmail
	dodir /var/spool/qmailscan
	keepdir /var/spool/qmailscan
	for i in quarantine working archive; do
		for j in tmp new cur; do
			dodir /var/spool/qmailscan/${i}/${j}
			keepdir /var/spool/qmailscan/${i}/${j}
		done
	done

	# Install standard quarantine attachments file
	insinto /var/spool/qmailscan
	insopts -m 644 -o qmailq -g qmail
	doins quarantine-attachments.txt

	# Install qmail-scanner script
	insinto /var/qmail/bin
	insopts -m 4755 -o qmailq -g qmail
	doins qmail-scanner-queue.pl

	# Install documentation
	dodoc README CHANGES COPYING
	dohtml README.html
}

pkg_postinst () {
	# Setup perlscanner + Version Info
	/var/qmail/bin/qmail-scanner-queue.pl -z
	/var/qmail/bin/qmail-scanner-queue.pl -g

	einfo "To activate qmail-scanner, please edit your"
	einfo "/var/qmail/control/conf-common file and set:"
	einfo "QMAILQUEUE=/var/qmail/bin/qmail-scanner-queue.pl"
}
