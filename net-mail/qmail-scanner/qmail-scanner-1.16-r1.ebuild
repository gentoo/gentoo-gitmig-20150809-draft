# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/qmail-scanner/qmail-scanner-1.16-r1.ebuild,v 1.1 2003/04/19 23:18:35 prez Exp $

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
        virtual/virus"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~sparc"

src_compile () {
    yes | PATH=${PATH}:/opt/f-prot ./configure \
        --domain localhost \
           || die "./configure failed!"
}

src_install () {

    # Create Directory Structure
    diropts -m 755 -o qmailq -g qmail
    dodir /var/spool/qmailscan
    keepdir /var/spool/qmailscan
    dodir /var/spool/qmailscan/quarantine
    keepdir /var/spool/qmailscan/quarantine
    dodir /var/spool/qmailscan/quarantine/tmp
    keepdir /var/spool/qmailscan/quarantine/tmp
    dodir /var/spool/qmailscan/quarantine/new
    keepdir /var/spool/qmailscan/quarantine/new
    dodir /var/spool/qmailscan/quarantine/cur
    keepdir /var/spool/qmailscan/quarantine/cur
    dodir /var/spool/qmailscan/working
    keepdir /var/spool/qmailscan/working
    dodir /var/spool/qmailscan/working/tmp
    keepdir /var/spool/qmailscan/working/tmp
    dodir /var/spool/qmailscan/working/new
    keepdir /var/spool/qmailscan/working/new
    dodir /var/spool/qmailscan/working/cur
    keepdir /var/spool/qmailscan/working/cur
    dodir /var/spool/qmailscan/archive
    keepdir /var/spool/qmailscan/archive
    dodir /var/spool/qmailscan/archive/tmp
    keepdir /var/spool/qmailscan/archive/tmp
    dodir /var/spool/qmailscan/archive/new
    keepdir /var/spool/qmailscan/archive/new
    dodir /var/spool/qmailscan/archive/cur
    keepdir /var/spool/qmailscan/archive/cur

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

    einfo
    einfo "NOTICE:"
    einfo "Set QMAILQUEUE=/var/qmail/bin/qmail-scanner-queue.pl"
    einfo "in your /etc/tcp.smtp file to activate qmail-scanner."
    einfo
}
